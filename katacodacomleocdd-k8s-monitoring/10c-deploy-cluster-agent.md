Now is time to deploy the Cluster Agent.

* We are going to patch the Agent to enable the Cluster Agent's client and to configure the token for the communication to be secure.<br/>
`kubectl apply -f assets/10c-deploy-cluster-agent/cluster-agent-manifests`{{copy}}

* Patch the agent DaemonSet: <br/>
`kubectl patch daemonset datadog-agent --patch "$(cat assets/10c-deploy-cluster-agent/enable-dca.patch.yaml)"`{{copy}}

* Verify that the Cluster Agent is running: <br/>
`kubectl get pod -lapp=datadog-cluster-agent`{{copy}} 

* Verify that the agent can properly communicate with it. Exec into an agent and use the `agent status` command.

<details>
<summary>Hint</summary>

```
kubectl exec -ti datadog-agent-XXX agent status
[...] 
=====================
Datadog Cluster Agent
=====================

  - Datadog Cluster Agent endpoint detected: https://10.106.63.237:5005
  Successfully connected to the Datadog Cluster Agent.
 ```
</details>

* You should now be getting metrics with cluster level metadata, which will come handy when troubleshooting traffic to the APIServer or to application services.

For instance, go check out the CoreDNS metrics broken down by `kube_service`:
![CoreDNS Requests](https://raw.githubusercontent.com/LeoCavaille/k8s-workshop/master/assets/img/coredns.png)
We are able to identify how DNS requests are load balanced to the replicas from the service perspective.
