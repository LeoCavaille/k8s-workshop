## Log in to Datadog

* Log into your [Datadog account](https://app.datadoghq.com) with the provided credentials. 
* After logging in, you will be prompted to install the agent and blocked until a metric is reported to your account.

## Add Datadog credentials 

We need to install the agent to start using our account. The agent uses an API key to authenticate with the Datadog API.

* Navigate to the [API Keys](https://app.datadoghq.com/account/settings#api) page and copy your API Key.

* Add your API key to your cluster as a secret so that the agent deployment can use it next:
`export DD_API_KEY="<your-api-key>"`{{copy}}
`kubectl create secret generic datadog-api-key --from-literal=token=$DD_API_KEY`{{execute}}
