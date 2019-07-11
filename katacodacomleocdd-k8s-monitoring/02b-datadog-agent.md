* Install the agent by applying to Kubernetes the default install manifests
(see [official documentation](https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/))

`kubectl apply -f assets/02-datadog-agent`{{copy}}
* Now watch the agent pods as they come live to see the agent being deployed,
  the pod should be marked as `Running` before continuing (press
<kbd>Ctrl</kbd>+<kbd>C</kbd> to end the watch):

`kubectl get pods -w -owide`{{copy}}
* You can also look at the status of the daemonset

`kubectl get daemonset`{{copy}}

At this point we should see `DESIRED` as 1 and also
`CURRENT/READY/UP-TO-DATE/AVALAIBLE` to 1 indicating our agent deployment is
healthy.

Now your Datadog account should be starting to get monitoring data, go take a
look at your [Kubernetes dashboard](https://app.datadoghq.com/screen/integration/86), you should see it
getting updates on the state of your cluster. Some metrics are missing, go to
the next step to fix that!


_Note: you might have to click the "Finish" button if you are seeing the agent
installation script. You will not be able to click the button until the agent has
run and reported metrics, which could take ~2mn_

![Agent Finish button](https://cl.ly/37017b1ed29c/Screenshot%2525202019-07-10%252520at%25252012.01.18.png)
