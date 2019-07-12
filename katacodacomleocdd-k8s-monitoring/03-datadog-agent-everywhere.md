By now you've noticed that the agent is only running on your worker node. To schedule a replica on a master node, a `toleration` matching the `taints` on the node is required.

Find the taints applied to the master node.

<details>
<summary>Hint</summary>
`kubectl get nodes` prints a list of all nodes in the cluster. <br/> <br/>

`kubectl describe node <node-name>` prints details about a specific node. 
</details>

The agent should run on all nodes in our cluster, regardless of `taints`. 

The following patch adds a `toleration` for all taints: <br/>
```
# assets/03-datadog-agent-everywhere/tolerate-all.patch.yaml
spec:
  template:
    spec:
      tolerations:
        - operator: Exists
```

Apply the patch: <br/>
`kubectl patch daemonset datadog-agent --patch "$(cat assets/03-datadog-agent-everywhere/tolerate-all.patch.yaml)"`

Finally, verify that the agent is running on all nodes in the cluster.
