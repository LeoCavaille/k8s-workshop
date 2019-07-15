In order to begin using Datadog, you must install the agent. The agent uses an API key to authenticate with the Datadog API. 

* Copy your API key from the Datadog agent configuration page and export it as an environment variable: <br/>
`export DD_API_KEY=<your-api-key>`{{copy}}

* Create a `Secret` with your API key: <br/>
`kubectl create secret generic datadog-api-key --from-literal=token=$DD_API_KEY`{{copy}}

* Ensure your secret is configured as expected. You should have 32 bytes of secret data in the key `token` in an `Opaque` secret.

<details>
<summary>Hint</summary>
`kubectl get secrets`{{copy}} prints a list of all secrets in the current namespace. <br/> <br/>

`kubectl describe secret <your-secret-name>`{{copy}} prints details of a specific secret. <br/> <br/>

`kubectl get secret -oyaml <your-secret-name>`{{copy}} prints the full YAML representation of a secret.
</details>

The cluster agent requires a secret token to secure communication between node agents and cluster agent workers.

* Create a `Secret` with a random token for the cluster agent: <br/>
`kubectl create secret generic datadog-auth-token --from-literal=token=$(openssl rand -hex 16)`{{copy}}
