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

Rollout strategy is specified in the DaemonSet spec:
```
spec:
  updateStrategy:
    type: RollingUpdate
```

* Patch the agent DaemonSet to add the RollingUpdate strategy:
`kubectl patch daemonset datadog-agent --patch "$(cat assets/08-datadog-logs/rolling-update.patch.yaml)"`

* Visit the [Logs tab in Datadog](https://app.datadoghq.com/logs/onboarding/container) and select *Kubernetes*. At the bottom of the page, click to validate your choice.

* Watch the changes now happen:
`kubectl get pods -w -lapp=datadog-agent`{{execute}}

* You can also watch the rolling update of the daemonset to see the change being deployed:
`kubectl rollout status ds/datadog-agent`{{copy}}

* This should have unblocked the logs view and you should see logs flowing now.

_Note: until you have successfully sent logs you will not be able to move the
Logs Explorer page and will see this disabled button._

![Waiting for Logs button](https://cl.ly/25a21f0cb5a1/Screenshot%2525202019-07-10%252520at%25252013.39.04.png)
