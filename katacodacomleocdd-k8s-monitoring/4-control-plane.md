At this point, there is only a single agent being run. Yet, we had said there were actually two nodes in this environment (the Kubernetes master where you have your terminal and node01, another Kubernetes node).

If you list the pods in the `kube-system`  namespace, you will see the components consituting the Control Plane:

```
master $ kubectl get pods -n kube-system -o  custom-columns=NAME:.metadata.name,NODE:spec.nodeName
NAME                             NODE
[...]
etcd-master                      master
kube-apiserver-master            master
kube-controller-manager-master   master
kube-scheduler-master            master
[...]
```

But no Datadog Agent. So we are going to deploy one on the master node. 
This agent is going to run as a Cluster Level Check Worker.

The [Cluster Level Checks](https://docs.datadoghq.com/agent/autodiscovery/clusterchecks/) feature allows users to monitor endpoints that are external to the cluster (e.g. Load Balancer, Database ...), it requires the [Datadog Cluster](https://docs.datadoghq.com/agent/kubernetes/cluster/) Agent to run.

In this context, the Datadog Agent will be running on the master node and will be able to communicate with all the pods on this node (e.g. the Control Plane). The Cluster Agent will be running on the worker node and will interact with the APIServer to get the details of the Control Plane endpoints. 
You can find in the `assets/03-control-plane/control-plane-configmap.yaml` the check configuration that will be used by the Cluster Agent to schedule checks on the Datadog Agent running on the master node that has the Cluster Checks feature enabled.

In larger cluster this feature can be leveraged to schedule dynamically checks that only need to be run against a set of endpoints living in or outside the cluster.

Run:
`for f in assets/03-control-plane/; do kubectl apply -f $f; done`{{execute}} 

This will deploy the Cluster agent with the correct RBAC as well as a Datadog Agent with the Cluster Check feature enabled.
You will notice that this agent has a specific toleration in its pod spec (in `spec.template.spec`):
  <pre><code>tolerations:
  - key: node-role.kubernetes.io/master
     effect: NoSchedule
  </code></pre>
  *tolerations: should be at the same indent level as containers: below it*

This will allow it to run on the master node.

If you exec in the Datadog agent on the master node, you can see all the checks scheduled:

`kubectl get pods --field-selector spec.nodeName=master`

Exec in the agent (which should be the only pod in the default namespace on the master node)

`kubectl exec -ti {{pod_name}} bash`{{execute}}

Once in the pod, run `agent configcheck`. This will show you the checks configured and how they were configured (i.e. by the Cluster Agent or as a file). Then, you can use the `agent status` commnand, which will show you that metrics are collected.

Check out the official out of the box Control Plane dashboard in your Datadog account [link to come].

You might have noticed that the agent is also collecting `audit_logs`, these will come very handy in the next section of the workshop.
