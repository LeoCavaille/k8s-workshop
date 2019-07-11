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

* In this environment, the control plane pods (apiserver, controller-manager, ...)
are deployed as [static pods](https://kubernetes.io/docs/tasks/administer-cluster/static-pod/) on the master node.
You might have noticed before that we have a single agent node running on
`node01` and not on master. So the first thing we will need to do is to add a
[toleration](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) to the agent daemonset to be able to schedule an agent on the
tainted master node.

`kubectl describe node master`{{execute}}

* While we are working on the support of auto-detecting and discovering the static
pods (it required some [contributions upstream](https://github.com/DataDog/datadog-agent/issues/2803#issuecomment-494073838)) the way to schedule checks on static pods in this
environment (running Kubernetes 1.11) is to schedule a dummy placeholder pod on
which we can add annotations which we will use to drive Agent Checks
configuration.

* You can take a look at `assets/04-control-plane/static-pods-discovery.yaml` to
see how that is implemented ([official documetation](https://docs.datadoghq.com/agent/autodiscovery/integrations/?tab=kubernetespodannotations#configuration)).

* Another agent configuration we do here is to deploy an additional logs agent
configuration to tail the apiserver audit logs. You can have a look at
`assets/04-control-plane/agent-daemonset` that has some specific comments.

* Then deploy the new configuration manifests:

`kubectl apply -f assets/04-control-plane`{{execute}}
* Find first the datadog-agent pod that runs on the master node

`kubectl get pods -lapp=datadog-agent -owide`{{execute}}
* Exec in the agent to see what checks are configured and being run (you should now see the control plane checks we added: `kube_apiserver_metrics`, `kube_controller_manager`, `kube_scheduler`, `etcd`, `kube_audit`)

`kubectl exec -ti datadog-agent-{{pod_suffix}} agent configcheck`{{copy}}
* Then, you can use the `agent status` commnand, which will show you that metrics/logs are collected:

`kubectl exec -ti datadog-agent-{{pod_suffix}} agent status`{{execute}}

Check out the official out of the box Control Plane dashboard in your Datadog
account [link to come].
