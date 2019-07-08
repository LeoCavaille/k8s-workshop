As you can see the widgets of the state of resources (DaemonSets, Deployments,
ReplicaSets, Containers) are empty.

This is provided by [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics), you can find the official Datadog
documentation
[here](https://docs.datadoghq.com/integrations/kubernetes/#setup-kubernetes-state)

For convenience, we already downloaded the kube-state-metrics manifests, apply
them:
`kubectl apply -f assets/ksm`{{copy}}

You can watch the result, pods are deployed in `kube-system` by default:
`kubectl get pods -w -owide -n kube-system`{{copy}}

Now the dashboard should be fully available!
