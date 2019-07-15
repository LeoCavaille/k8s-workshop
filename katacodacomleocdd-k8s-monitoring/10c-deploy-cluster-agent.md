Now is time to deploy the Cluster Agent.

* We are going to patch the Agent to enable the Cluster Agent's client and to configure the token for the communication to be secure.

`kubectl apply -f assets/10b-deploy-cluster-agent/cluster-agent-manifests`{{execute}}

* Patch the agent DaemonSet:
`kubectl patch daemonset datadog-agent --patch "$(cat assets/10b-deploy-cluster-agent/enable-dca.patch.yaml)"`{{execute}}

* Verify that the Cluster Agent is running:

`kubectl get pod -lapp=datadog-cluster-agent` 

* Verify that the agent can properly communicate with it. Exec into an agent and use the `agent status` command.

* You should now be getting metrics with cluster level metadata, which will come handy when troubleshooting traffic to the APIServer or to application services.