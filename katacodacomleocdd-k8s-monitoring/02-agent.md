The Datadog agent runs as a `DaemonSet` with a replica on every node in the cluster that matches the selector.

<details>
<summary>Additional Information</summary>
The workshop includes with the manifests to install the agent.  For more details, see the [official documentation](https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/).
</details>

* Install the agent in your cluster: <br/>
`kubectl apply -f assets/02-datadog-agent`{{copy}}

* Verify the `DaemonsetSet` is deployed, and a replica is running on your worker node `node01`.

* Wait for all datadog-agent pods to enter `Running` state.

<details>
<summary>Hint</summary>
`kubectl get ds` prints a list of all DaemonSets in the current namespace. <br/> <br/>

`kubectl get ds <ds-name>` prints details about a specific DaemonSet. <br/> <br/>

`kubectl get pods` prints a list of all pods in the current namespace. <br/> <br/>

`kubectl get pods -owide` prints a list of all pods with extra information, including the assigned node. <br/> <br/>

`kubectl get pods -w` prints and updates a list of all pods as changes occur on the server. (Press <kbd>Ctrl</kbd>+<kbd>C</kbd> to end the watch)
</details>

_Note: you might have to click the "Finish" button if you are seeing the agent installation prompt. You will not be able to click the button until the agent has run and reported metrics, which could take up to 2 minutes._
