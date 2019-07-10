To enable collecting logs from all the pods in the Kubernetes cluster we will
follow [the official documentation](https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/?tab=k8sfile#log-collection)

* Go to the [Logs tab in Datadog](https://app.datadoghq.com/logs/onboarding/container) and select Kubernetes. For
convenience we added the instructions you needed to follow here in Katacoda, see
below.

* Add the environment variables to the agent daemonset, in the editor you can go
  to `assets/04-enable-logs/agent-daemonset.yaml` and add the following
environment variables to the agent container:

```
    - name: DD_LOGS_ENABLED
        value: "true"
    - name: DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL
        value: "true"
```

_Note: you don't need to save your changes, files are auto-saved._

* Then reapply the manifest:

`kubectl apply -f assets/04-enable-logs/agent-daemonset.yaml`{{copy}}
* You can watch the rollout of the daemonset to see the change being deployed:

`kubectl rollout status ds/datadog-agent`{{copy}}

* This should have unblocked the logs view and you should see logs flowing now.

_Note: until you have successfully sent logs you will not be able to move the
Logs Explorer page and will see this disabled button._

![Waiting for Logs button](https://cl.ly/25a21f0cb5a1/Screenshot%2525202019-07-10%252520at%25252013.39.04.png)
