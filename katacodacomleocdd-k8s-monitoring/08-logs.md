The Datadog agent collects logs from all pods in the cluster and reports them to Datadog.

<details>
<summary>Additional Information</summary>
The [official documentation](https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/?tab=k8sfile#log-collection) illustrates how to enable log collection.
</details>

Log collection is enabled by passing two environment variables to the Agent: `DD_LOGS_ENABLED=true` and `DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true`.

* Patch the agent DaemonSet to add the required environment variables: <br/>
`cat assets/08-datadog-logs/enable-logs.patch.yaml`{{copy}}<br/>
`kubectl patch daemonset datadog-agent --patch "$(cat assets/08-datadog-logs/enable-logs.patch.yaml)"`{{copy}}

* Check if your change has been rolled out:<br/>
`kubectl get pods -lapp=datadog-agent`{{copy}}

**Even with the new manifest uploaded, pods are not updated. The default rollout strategy for the `DaemonSet` is `OnDelete` [which means according to the documentation](https://kubernetes.io/docs/tasks/manage-daemon/update-daemon-set/) a Pod must be deleted to be replaced. To automatically roll out changes, use the `RollingUpdate` strategy.**
