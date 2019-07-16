With the control plane monitored, some data plane monitoring would be useful!

The component responsible for client side load balancing of Services in Kubernetes is `kube-proxy`. It runs on every host and maintains `iptables` or `ipvs` rules to route traffic targeting service IPs to the endpoints that back the service.

Instrument `kube-proxy` using the Datadog integration.

* Apply autodiscovery annotations to the `kube-proxy` daemonset:
`kubectl -n kube-system patch daemonset kube-proxy --patch "$(cat assets/12-kube-proxy/datadog-autodiscovery.patch.yaml)"`{{copy}}

* Verify the `kube_proxy` check is being run by the Datadog agent.

* Verify that your now have kube-proxy metrics

<details>
<summary>Hint</summary>
Agent checks are performed by the agent running on the same node as the target. <br/> <br/>

`kube-proxy` is running on every node in the `kube-system` namespace. <br/> <br/>

`kubectl get po -owide`{{copy}} prints information about all pods in the current namespace, including the target node. <br/> <br/>

`kubectl exec -it <pod-name> <command>`{{copy}} executes a command in an interactive tty attached to the target pod.
</details>
