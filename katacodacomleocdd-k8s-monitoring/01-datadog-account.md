Once logged in, you will be prompted with install instructions. You need to install the agent to start using Datadog.  The agent uses an API key to authenticate with the Datadog API - to run the agent in Kubernetes, we must make the API key available as a `Secret`.

* Log into your [Datadog account](https://app.datadoghq.com) with the provided credentials. 

* On the setup page, choose "from source" at the bottom. Copy your API key and expose it as an environment variable:
`export DD_API_KEY=<your-api-key>`{{copy}}

* Create a `Secret` with your API key:
`kubectl create secret generic datadog-api-key --from-literal=token=$DD_API_KEY`{{execute}}

* Finally, make sure the secret is configured as expected:
`kubectl describe secret datadog-api-key`{{execute}}

There should be 32 bytes of secret data in an `Opaque` secret.
