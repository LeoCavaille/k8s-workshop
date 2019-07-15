The agent should run on all nodes in our cluster. To tolerate the master taint as well as any others that may be created, the agent should tolerate all taints. 

The workshop includes a patch to add the required toleration:
`cat assets/04-datadog-agent-everywhere/tolerate-all.patch.yaml`{{copy}}

* Apply the patch: <br/>
`kubectl patch daemonset datadog-agent --patch "$(cat assets/04-datadog-agent-everywhere/tolerate-all.patch.yaml)"`{{copy}}

* Verify that the agent is running on the master and worker nodes.

<details>
<summary>Hint</summary>
`kubectl get pods -owide` prints a list of all pods with extra metadata, including the node name. <br/> <br/>

`kubectl describe node <node-name>` prints details about a specific node, including all running pods.
</details>
