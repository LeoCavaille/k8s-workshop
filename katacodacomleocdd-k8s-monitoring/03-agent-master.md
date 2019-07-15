With the default configuration, the agent is only running on worker nodes. The master node has a taint applied preventing the `DaemonSet` from targeting it. To schedule a replica on a master node, a `toleration` matching the `taint` is required.

* Find the taints applied to the master node.

<details>
<summary>Hint</summary>
`kubectl get nodes` prints a list of all nodes in the cluster. <br/> <br/>

`kubectl describe node <node-name>` prints details about a specific node. 
</details>
