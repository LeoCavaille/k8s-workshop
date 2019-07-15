The Kubernetes control plane integrations provide metrics tailored to the performance of each component.

The control plane has several components that run in the `kube-system` namespace:
`kubectl get pods -n kube-system -o custom-columns=NAME:.metadata.name,NODE:spec.nodeName`{{copy}}

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
`kubectl apply -f assets/11-control-plane/static-pods-discovery.yaml`{{copy}}

* Verify that the checks are running for `etcd`, `kube_apiserver`, `kube_scheduler`, and `kube_controller_manager`.

<details>
<summary>Hint</summary>
To verify a check is running, exec into the agent on the host and verify it's configuration. <br/> <br/>

`agent configcheck` in the agent pod prints the checks the agent has scheduled. <br/> <br/>

`agent status` in the agent pod prints information about the metrics and logs the agent has collected.
</details>

Each control plane integration comes with a default dashboard: [etcd](https://app.datadoghq.com/screen/integration/75/etcd), [kube-scheduler](https://app.datadoghq.com/screen/integration/30270/kubernetes-scheduler), [kube-controller-manager](https://app.datadoghq.com/screen/integration/30271/kubernetes-controller-manager), and the kube-apiserver.

As an example for how to create custom dashboards in Datadog, we are going to create an overview of the whole control plane using the [Datadog API](https://docs.datadoghq.com/api/)

* Create an APP key in your [Datadog account](https://app.datadoghq.com/account/settings#api).
![APP Key](https://raw.githubusercontent.com/LeoCavaille/k8s-workshop/master/assets/img/dashboard.png)

* Run the following API call using the JSON description of the dashboard located in assets/11-control-plane/control_plane_json.json


`export DD_APP_KEY=<YOUR_APP_KEY>`{{copy}}

`curl -s -o /dev/null -X POST -H "Content-type: application/json" \
-d @assets/11-control-plane/control_plane_json.json \
"https://api.datadoghq.com/api/v1/dashboard?api_key=${DD_API_KEY}&application_key=${DD_APP_KEY}"`{{copy}}

Go check out your unified dashboard in the [Dashboard list](https://app.datadoghq.com/dashboard/lists?q=Kubernetes+Control+Plane)
