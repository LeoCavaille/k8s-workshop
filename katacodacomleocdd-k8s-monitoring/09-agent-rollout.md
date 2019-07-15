Rollout strategy is specified in the DaemonSet spec:
```
spec:
  updateStrategy:
    type: RollingUpdate
```

* Patch the agent DaemonSet to add the RollingUpdate strategy:
`kubectl patch daemonset datadog-agent --patch "$(cat assets/08-datadog-logs/rolling-update.patch.yaml)"`{{copy}}

* Observe the changes to the agent Pods:
`kubectl get pods -w -lapp=datadog-agent`{{copy}}

* Track the rollout of your changes across replicas:
`kubectl rollout status daemonset/datadog-agent`{{copy}}

* Visit the [Logs tab in Datadog](https://app.datadoghq.com/logs/onboarding/container) and select *Kubernetes*. At the bottom of the page, click to validate your choice.

* Check that logs are flowing in Datadog.

_Note: until you have successfully sent logs you will not be able to access the Logs Explorer page and will see a disabled confirmation button._
