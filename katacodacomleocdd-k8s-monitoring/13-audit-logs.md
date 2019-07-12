* Another agent configuration we do here is to deploy an additional logs agent
configuration to tail the apiserver audit logs. You can have a look at
`assets/04-control-plane/agent-daemonset` that has some specific comments.

* Then deploy the new configuration manifests:

`kubectl apply -f assets/04-control-plane`{{execute}}
* Find first the datadog-agent pod that runs on the master node

`kubectl get pods -lapp=datadog-agent -owide`{{execute}}
* Exec in the agent to see what checks are configured and being run (you should now see the control plane checks we added: `kube_apiserver_metrics`, `kube_controller_manager`, `kube_scheduler`, `etcd`, `kube_audit`)

* Then, you can use the `agent status` commnand, which will show you that metrics/logs are collected:

`kubectl exec -ti datadog-agent-{{pod_suffix}} agent status`{{execute}}

Check out the official out of the box Control Plane dashboard in your Datadog
account [TODO link to come].
