The Datadog agent runs as a `DaemonSet` with a replica on every node in the cluster.

* Install the agent in your Kubernetes cluster:
`kubectl apply -f assets/02-datadog-agent`{{execute}}

> The manifests are included with the workshop. For more details, see the [official documentation](https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/).

* Watch the agent pods as they becoome available. Pods should be marked as `Running` before moving forward (press
<kbd>Ctrl</kbd>+<kbd>C</kbd> to end the watch):
`kubectl get pods -w -owide`{{execute}}

* Check the status of the Datadog agent `DaemonSet`: 
`kubectl get daemonset`{{execute}}
At this point we should see `DESIRED` as 1 and also
`CURRENT/READY/UP-TO-DATE/AVALAIBLE` to 1 indicating our agent deployment is
healthy.

* `kubectl describe` shows even more detail about the `DaemonSet`:
`kubectl describe daemonset datadog-agent`{{execute}}

_Note: you might have to click the "Finish" button if you are seeing the agent
installation script. You will not be able to click the button until the agent has
run and reported metrics, which could take ~2mn_

![Agent Finish button](https://cl.ly/37017b1ed29c/Screenshot%2525202019-07-10%252520at%25252012.01.18.png)
