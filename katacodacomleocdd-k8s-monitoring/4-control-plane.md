At this point, there is only a single agent being run. Yet, we had said there were actually two nodes in this environment (the Kubernetes master where you have your terminal and node01, another Kubernetes node).

* If you list the pods in the `kube-system`  namespace, you will see the components consituting the Control Plane:

`kubectl get pods -n kube-system -o custom-columns=NAME:.metadata.name,NODE:spec.nodeName`{{execute}}

```
NAME                             NODE
[...]
etcd-master                      master
kube-apiserver-master            master
kube-controller-manager-master   master
kube-scheduler-master            master
[...]
```

* If you look at the agent pods however you can see that we have not deployed an
  agent to the `master` node:

`kubectl get pods -lapp=datadog-agent -owide`{{execute}} 

* We are going to deploy an agent on the master and use it as a Cluster Level Check Worker.

The [Cluster Level
Checks](https://docs.datadoghq.com/agent/autodiscovery/clusterchecks/) feature
allows users to monitor endpoints that are external to the cluster (e.g. Load
Balancer, Database ...), it requires the [Datadog
Cluster](https://docs.datadoghq.com/agent/kubernetes/cluster/) Agent to run.

In this context, the Datadog Agent will be running on the master node and will
be able to communicate with all the pods on this node (e.g. the Control Plane).
The Cluster Agent will be running on the worker node and will interact with the
APIServer to get the details of the Control Plane endpoints. 

In larger cluster this feature can be leveraged to schedule dynamically checks
that only need to be run against a set of endpoints living in or outside the
cluster.

* Start by creating a token secret for the Datadog agent to communicate securely with the Datadog Cluster Agent.

`kubectl create secret generic datadog-auth-token --from-literal=token=$(openssl rand -hex 16)`{{execute}}
* Then deploy the workloads by running:

`kubectl apply -f assets/04-control-plane`{{execute}}

* You can have a look in the editor at the different manifests we included in
there:
  * `agent-cluster-check-worker.yaml` deploys one worker on the master, see its specific `tolerations` and `nodeAffinity` to do this
  * `control-plane-configmap.yaml`: check configuration that will be used to
    monitor the control plane with a Cluster Level check
  * `cluster-agent-*.yaml`: the various components of the Datadog Cluster Agent


* If you exec in the Datadog agent on the master node, you can see all the checks scheduled:

`kubectl get pods --field-selector spec.nodeName=master`{{execute}}
* Exec in the agent (which should be the only pod in the default namespace on the master node)

`kubectl exec -ti datadog-agent-cluster-check-{{pod_suffix}} agent configcheck`{{execute}}

This will show you the checks configured and how they were configured (i.e. by
the Cluster Agent or as a file).

* Then, you can use the `agent status` commnand, which will show you that metrics are collected:

`kubectl exec -ti datadog-agent-cluster-check-{{pod_suffix}} agent status`{{execute}}

Check out the official out of the box Control Plane dashboard in your Datadog
account [link to come].

You might have noticed that the agent is also collecting `audit_logs`, these
will come very handy in the next section of the workshop.
