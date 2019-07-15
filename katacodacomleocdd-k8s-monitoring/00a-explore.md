Access the Kubernetes API using the command line client, `kubectl`. The environment is configured to connect to your personal Kubernetes cluster.

You may explore the functionality provided by `kubectl` using `kubectl --help`.

Start by verifying that your cluster is running the expected version of Kubernetes, `v1.11.3`.

<details>
<summary>Hint</summary>
`kubectl version`{{copy}} prints the client and server versions.
</details>

Make sure that all the nodes in your cluster are in `Ready` state. If your nodes are `NotReady`, wait a few seconds and try again until they become `Ready`.

<details>
<summary>Hint</summary>
`kubectl get nodes`{{copy}} prints a list of the nodes in your cluster.
</details>
