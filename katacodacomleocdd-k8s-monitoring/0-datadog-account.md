* First log into your [Datadog account](https://app.datadoghq.com) with the
  provided credentials. After logging in, you will be prompted to install the
  agent and blocked until a metric is sent to your account. Don't click anything
  on that page and proceed with the instructions below.

We need to install our first agent to start using our account and
continue the workshop, so let's get started with that.

* We also provided you with an API key, so add it to your Kubernetes cluster as
  a secret so that the agent deployment can use it next:
`kubectl create secret generic datadog-api-key --from-literal=token=$DD_API_KEY`{{copy}}

