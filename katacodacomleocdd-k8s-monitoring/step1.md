1. Add your API key
`kubectl create secret generic datadog-api --from-literal=token=$DD_API_KEY`
1. Install the agent by applying to Kubernetes the default install manifests
   (see [official documentation](https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/)
