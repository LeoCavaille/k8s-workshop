The Datadog agent can collect logs from all pods in the cluster.

<details>
<summary>Additional Information</summary>
The [official documentation](https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/?tab=k8sfile#log-collection) illustrates how to enable log collection.
</details>

Log collection is enabled by passing two environment variables to the Agent:
```
    - name: DD_LOGS_ENABLED
      value: "true"
    - name: DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL
      value: "true"
```

* Patch the agent DaemonSet to add the required environment variables:
`kubectl patch daemonset datadog-agent --patch "$(cat assets/08-datadog-logs/enable-logs.patch.yaml)"`{{copy}}

* Check if your change has been rolled out:
`kubectl get pods -lapp=datadog-agent`{{execute}}

**Even with the new manifest uploaded, pods are not updated. The default rollout strategy for the `DaemonSet` is `OnDelete` [which means according to the documentation](https://kubernetes.io/docs/tasks/manage-daemon/update-daemon-set/) a Pod must be deleted to be replaced. To automatically roll out changes, use the `RollingUpdate` strategy.**
