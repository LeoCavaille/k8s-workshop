* Log into your [Datadog account](https://app.datadoghq.com) with the provided credentials. 

Once logged in, you will be prompted with install instructions. You need to install the agent to start using Datadog. 

The agent uses an API key to authenticate with the Datadog API. It's time to fetch the API key and make it available in your cluster.

* On the Datadog prompt, choose "from source" at the bottom. Copy your API key from the script and add it to the the environment as follows:
`export DD_API_KEY=<your-api-key>`{{copy}}

* The Datadog agent reads the API key from a Kubernetes `Secret`. Create a `Secret` with your API key:
`kubectl create secret generic datadog-api-key --from-literal=token=$DD_API_KEY`{{execute}}

* Finally, make sure the secret is configured as expected:
`kubectl describe secret datadog-api-key`{{execute}}

You should see 32 bytes of secret data in an `Opaque` secret.
