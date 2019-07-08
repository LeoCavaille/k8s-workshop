1. Add your API key to the Kubernetes cluster
`kubectl create secret generic datadog-api-key --from-literal=token=$DD_API_KEY`{{copy}}
1. Install the agent by applying to Kubernetes the default install manifests
(see [official documentation](https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/))
`kubectl apply -f assets/01-agent-deployment`{{copy}}
1. Now watch the agent pods as they come live to see the agent being deployed
`kubectl get pods -w -owide`{{copy}}
1. You can also look at the status of the daemonset
`kubectl get daemonset`{{copy}}

Now take a look at your [Kubernetes dashboard](https://app.datadoghq.com/screen/integration/86), you should see it getting updates
on the state of your cluster. Some metrics are missing, go to the next step to
fix that!
