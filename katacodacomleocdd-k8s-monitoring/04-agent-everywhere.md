The agent should run on all nodes in our cluster, regardless of `taints`. 

* The workshop includes a patch to add the required toleration:
`cat assets/04-datadog-agent-everywhere/tolerate-all.patch.yaml`{{copy}}

* Apply the patch: <br/>
`kubectl patch daemonset datadog-agent --patch "$(cat assets/04-datadog-agent-everywhere/tolerate-all.patch.yaml)"`{{copy}}

* Finally, verify that the agent is running on all nodes in the cluster.
