As you can see the widgets of the state of resources (DaemonSets, Deployments,
ReplicaSets, Containers) are empty.

This data is provided by [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics). Kube State Metrics also known as KSM is a simple service that listens to the Kubernetes API server and generates metrics about the state of the objects.
You can find the official Datadog
documentation
[here](https://docs.datadoghq.com/integrations/kubernetes/#setup-kubernetes-state) for the check.
The agent will use a process called Autodiscovery to identify that KSM is running, so it can start crawling data from the `/metrics` endpoint of the KSM pods.

* For convenience, we already downloaded the kube-state-metrics manifests, apply
them:

`kubectl apply -f assets/02-ksm-deployment`{{copy}}
* You can watch the result, pods are deployed in `kube-system` by default:

`kubectl get pods -w -owide -l k8s-app=kube-state-metrics -n kube-system`{{execute}}

You will notice that this has created a dedicated service account as well as a cluster role, a service and a cluster role binding. 
Because KSM needs to get the metrics about many objects in the cluster, the application needs to communicate with the APIServer with an extended set of permissions.

You can verify that the agent is collecting KSM metrics by executing in the pod running the Datadog agent.

* Start by getting the pod name:

`kubectl get pods -l app=datadog-agent`{{execute}} 
* Exec into the pod:

`kubectl exec -it {{pod_name}} agent status`{{copy}}

Look for:
```
=========
Collector
=========
  Running Checks
  ==============
    kubernetes_state (1.0.0)
    ------------------------------
      Instance ID: kubernetes_state:822c2bebb015713 [OK]
      Total Runs: 10
      Metric Samples: Last Run: 1,251, Total: 12,510
      Events: Last Run: 0, Total: 0
      Service Checks: Last Run: 1, Total: 10
      Average Execution Time : 1.102s  
```

You can now go back to the Out of the box [Kubernetes dashboard](https://app.datadoghq.com/screen/integration/86) in your Datadog account and you should start seeing metrics flowing in all the widgets.

KSM gives a good insight into the cluster, however, we are still lacking a few key elements.

In the next step, we are going to enable log collection for our containers.

