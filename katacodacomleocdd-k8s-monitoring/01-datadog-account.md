In order to begin using Datadog, you must install the agent. The agent uses an API key to authenticate with the Datadog API; to run the agent in Kubernetes, we must make the API key available in a Kubernetes `Secret`.

* Copy your API key from the Datadog agent configuration page and export it as an environment variable:
`export DD_API_KEY=<your-api-key>`{{copy}}

* Create a `Secret` with your API key:
`kubectl create secret generic datadog-api-key --from-literal=token=$DD_API_KEY`{{execute}}

**Before moving on, make sure your secret is configured as expected.** 

You should have 32 bytes of secret data in the key `token` in an `Opaque` secret.

<details>
<summary>Hint</summary>
`kubectl get secrets`{{copy}} prints a list of all secrets in the current namespace. <br/> <br/>

`kubectl describe secret <your-secret-name>`{{copy}} prints details of a specific secret. <br/> <br/>

`kubectl get secret -oyaml <your-secret-name>`{{copy}} prints the full YAML representation of a secret.
</details>
