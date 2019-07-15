The Kubernetes control plane integrations provide metrics tailored to the performance of each component.

The control plane has several components that run in the `kube-system` namespace:
`kubectl get pods -n kube-system -o custom-columns=NAME:.metadata.name,NODE:spec.nodeName`{{execute}}

```
NAME                             NODE
[...]
etcd-master                      master
kube-apiserver-master            master
kube-controller-manager-master   master
kube-scheduler-master            master
[...]
```

In this environment, the control plane pods (apiserver, controller-manager, scheduler) are deployed as [static pods](https://kubernetes.io/docs/tasks/administer-cluster/static-pod/) on the master node. 

<details>
<summary>Additional Information</summary>
Support for auto-detecting and discovering the static pods (it required some [contributions upstream](https://github.com/DataDog/datadog-agent/issues/2803#issuecomment-494073838)) is in progress. Until upstream accepts these contributions, we offer a workaround to schedule checks against static pods. A placeholder pod is created, on which we can add annotations used to drive Agent Checks configuration.

The configuration in `assets/11-control-plane/static-pods-discovery.yaml` drives the static pod autodiscovery. See the ([official documetation](https://docs.datadoghq.com/agent/autodiscovery/integrations/?tab=kubernetespodannotations#configuration)).
</details>

* Deploy the control plane checks:
`kubectl apply -f assets/11-control-plane`{{execute}}

* Verify that the checks are running for `etcd`, `kube_apiserver`, `kube_scheduler`, and `kube_controller_manager`.

<details>
<summary>Hint</summary>
To verify a check is running, exec into the agent on the host and verify it's configuration. <br/> <br/>

`agent configcheck` in the agent pod prints the checks the agent has scheduled. <br/> <br/>

`agent status` in the agent pod prints information about the metrics and logs the agent has collected.
</details>

#TODO links to default dashboards
Each control plane integration comes with a default dashboard: [etcd](), [kube-apiserver](), [kube-scheduler](), and [kube-controller-manager]().
