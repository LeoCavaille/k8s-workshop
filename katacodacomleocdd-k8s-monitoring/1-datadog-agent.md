* Install the agent by applying to Kubernetes the default install manifests
(see [official documentation](https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/))

`kubectl apply -f assets/01-agent-deployment`{{copy}}
* Now watch the agent pods as they come live to see the agent being deployed

`kubectl get pods -w -owide`{{copy}}
* You can also look at the status of the daemonset

`kubectl get daemonset`{{copy}}

Now your Datadog account should be starting to get monitoring data, go take a
look at your [Kubernetes dashboard](https://app.datadoghq.com/screen/integration/86), you should see it
getting updates on the state of your cluster. Some metrics are missing, go to
the next step to fix that!
