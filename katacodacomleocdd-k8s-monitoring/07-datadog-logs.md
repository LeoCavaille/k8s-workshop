To enable collecting logs from all the pods in the Kubernetes cluster we will
follow [the official documentation](https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/?tab=k8sfile#log-collection)

* Go to the [Logs tab in Datadog](https://app.datadoghq.com/logs/onboarding/container) and select *Kubernetes*, 
  then go at the bottom of the page to validate your choice. For
  convenience we added the instructions you needed to follow here in Katacoda, see
  below.

* To enable logs in the agent, a few environment variables are required. We've prepared a patch to enable them:
```
    - name: DD_LOGS_ENABLED
      value: "true"
    - name: DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL
      value: "true"
```

We've prepared a patch to apply the change:
`cat assets/04-datadog-logs/agent-daemonset-enable-logs.patch.yaml`{{execute}}
`kubectl patch daemonset datadog-agent --patch "$(cat assets/04-datadog-logs/agent-daemonset-enable-logs.patch.yaml)"`{{execute}}

* Check if your change has been rolled out:
`kubectl get pods -lapp=datadog-agent`{{execute}}

**Even with the new manifest uploaded you can see that nothing is changing, this
is because the current rollout strategy for the `DaemonSet` is `OnDelete` [which
means according to the documentation](https://kubernetes.io/docs/tasks/manage-daemon/update-daemon-set/) we
would need to delete the current pods to get the changes. To ease future changes
let's use the `RollingUpdate` strategy:**

* To enable rolling updates, we must set the `updateStrategy` on our daemonset:
```
spec:
  updateStrategy:
    type: RollingUpdate
```

We've prepared a patch to do just that:
`cat assets/04-datadog-logs/agent-daemonset-rolling-update.patch.yaml`{{execute}}
`kubectl patch daemonset datadog-agent --patch "$(cat assets/04-datadog-logs/agent-daemonset-rolling-update.patch.yaml)"`

* Watch the changes now happen:
`kubectl get pods -w -lapp=datadog-agent`{{execute}}

* You can also watch the rolling update of the daemonset to see the change being deployed:
`kubectl rollout status ds/datadog-agent`{{copy}}

* This should have unblocked the logs view and you should see logs flowing now.

_Note: until you have successfully sent logs you will not be able to move the
Logs Explorer page and will see this disabled button._

![Waiting for Logs button](https://cl.ly/25a21f0cb5a1/Screenshot%2525202019-07-10%252520at%25252013.39.04.png)
