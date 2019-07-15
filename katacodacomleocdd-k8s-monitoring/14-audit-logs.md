Whenever an API request is made to the Kubernetes apiserver, we can emit an
audit log line describing the request.

In this environment, the apiserver is configured to send the audit logs to
`/var/log/kubernetes/apiserver/audit.log`, go ahead and have a look at one
request log.
`tail -n1 /var/log/kubernetes/apiserver/audit.log | jq .`{{copy}}

<details>
<summary>Additional Information</summary>
The apiserver is running on the master node as a [_static
pod_](https://kubernetes.io/docs/tasks/administer-cluster/static-pod/) so this
application can be configured via a local file manifest located in:
`/etc/kubernetes/manifests/kube-apiserver.yaml`. <br/> <br/>

Find the flags we pass to the apiserver binary to configure audit logs:
  `--audit-log-path` and `--audit-policy-file`. <br/> <br/>

You can also read [the Kubernetes reference
  documentation](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/)
on auditing. <br/> <br/>

We will see the anatomy and meaning of audit policies in the next step. <br/> <br/>

*Attention: as static pods manifests are automatically reloaded, if you
introduce a breaking in change in the apiserver manifest, it might break your
Kubernetes environment. If `kubectl` commands are failing, try to fix the
manifest, reach out if you are blocked.*
</details>

* To configure the logs agent to tail these logs, we will add a configuration
  file to our agent deployment by utilizing a [Kubernetes configmap](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/):
`kubectl apply -f assets/14-audit-logs/configmap.yaml`{{copy}}

* You can look at its content by running:
`kubectl get configmap -oyaml agent-audit-logs`{{copy}}

* We included a patch for the agent daemonset to deploy this new configmap and
  configure the agent:
`cat assets/14-audit-logs/patch-daemonset-audit-logs.yaml`{{copy}}

* Apply the patch: <br/>
`kubectl patch daemonset datadog-agent --patch "$(cat assets/14-audit-logs/patch-daemonset-audit-logs.yaml)"`{{copy}}

* Look at your [Datadog logs explorer](https://app.datadoghq.com/logs) and you should start seeing audit logs
  flowing
