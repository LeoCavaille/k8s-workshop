As you can see the widgets of the state of your kubernetes resources (DaemonSets, Deployments, ReplicaSets, Containers) are empty.

This data is provided by [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics). Also known as KSM, `kube-state-metrics` is a service that watches the Kubernetes API and generates metrics about the state of objects.

<details>
<summary>Additional Information</summary>
You can find the official Datadog documentation [here](https://docs.datadoghq.com/integrations/kubernetes/#setup-kubernetes-state) for the check.
</details>

The agent will automatically discover KSM and collect metrics from it's OpenMetrics endpoint.

* Install `ksm` on your cluster: <br/>
`kubectl apply -f assets/07-datadog-ksm`{{execute}}

* Validate that `ksm` pods are running in the `kube-system` namespace.

<details>
<summary>Hint</summary>
The `-n` flag to `kubectl` change the namespace of your query.
</details>

A dedicated service account for KSM is granting permissions to access the Kubernetes API. With RBAC enabled, the manifests include a `ClusterRole` and `ClusterRoleBinding` to grant permissons.

* Find the `ClusterRole` that allows KSM to access the Kubernetes API.
<details>
<summary>Hint</summary>
`kubectl get clusterrole` prints a list of `ClusterRole` objects in the cluster. <br/> <br/>

`kubectl get clusterrolebinding` prints a list of `ClusterRoleBinding` objects in the cluster. <br/> <br/>

`kubectl describe clusterrolebinding` prints details about a `ClusterRoleBinding`, including the subjects it binds to.
</details>


* Verify that the agent is collecting KSM metrics by running the following command in a datadog-agent pod:
`agent status`{{copy}}

<details>
<summary>Hint</summary>
Agent checks are performed by the agent running on the same node as the target. <br/> <br/>

Since it has no tolerations, KSM will always be running on the worker node, `node01`. <br/> <br/>

`kubectl get po -owide`{{copy}} prints information about all pods in the current namespace, including the target node. <br/> <br/>

`kubectl exec -it <pod-name> <command>`{{copy}} executes a command in an interactive tty attached to the target pod.
</details>

Look for:
```
=========
Collector
=========
  Running Checks
  ==============
    kubernetes_state (1.0.0)
    ------------------------------
      Instance ID: kubernetes_state:822c2bebb015713 [OK]
      Total Runs: 10
      Metric Samples: Last Run: 1,251, Total: 12,510
      Events: Last Run: 0, Total: 0
      Service Checks: Last Run: 1, Total: 10
      Average Execution Time : 1.102s
```

The default [dashboard](https://app.datadoghq.com/screen/integration/86) should start filling in with metrics from KSM.

KSM gives a good insight into the cluster, however, we are still lacking a few key elements.
