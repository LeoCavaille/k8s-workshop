We need to install the agent to start using our account. The agent uses an API key to authenticate with the Datadog API.

* Log into your [Datadog account](https://app.datadoghq.com) with the provided credentials. 
* After logging in, you will be prompted to install the agent and blocked until a metric is reported to your account.

* Choose "from source" at the bottom, and copy your API key from the script. Paste it in the following command:
`export DD_API_KEY=<your-api-key>`{{copy}}

* Next, add your API key to your cluster as a secret so that the agent deployment can use it:
`kubectl create secret generic datadog-api-key --from-literal=token=$DD_API_KEY`{{execute}}
