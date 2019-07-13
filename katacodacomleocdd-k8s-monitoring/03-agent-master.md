By now you've noticed that the agent is only running on the worker node. To schedule a replica on a master node, a `toleration` matching the `taints` on the node is required.

* Find the taints applied to the master node.

<details>
<summary>Hint</summary>
`kubectl get nodes` prints a list of all nodes in the cluster. <br/> <br/>

`kubectl describe node <node-name>` prints details about a specific node. 
</details>
