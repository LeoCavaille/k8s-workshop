1. [Kube State Metrics](https://github.com/kubernetes/kube-state-metrics/blob/master/README.md), also known as KSM is a simple service that listens to the Kubernetes API server and generates metrics about the state of the objects. 
It also an additional source of data for the official Datadog check to monitor [Kubernetes](https://docs.datadoghq.com/integrations/kubernetes/#setup-kubernetes-state). 
The agent will use a process called Autodiscovery to identify that KSM is running, so it can start crawling data from the `/metrics` endpoint.

1. Let's deploy KSM: 
`for f in assets/02_installing_kube_state_metrics/kube-state-metrics-*; do kubectl apply -f $f; done`{{execute}}

1. You will notice that this has created a dedicated service account as well as a cluster role, a service and a cluster role binding. 
Because KSM needs to get the metrics about many objects in the cluster, the application needs to communicate with the APIServer with an extended set of permissions.

1. Once KSM you see the pod running: 
`kubectl get pods -l k8s-app=kube-state-metrics -owide`{{execute}}
Execute in the pod running the Datadog agent and verify that the KSM check is running.

1. Start by getting the pod name:
`kubectl get pods -l app=datadog-agent`{{execute}} 
Then exec into the pod:
`kubectl exec -ti {{pod_name}} bash`{{execute}}
Then run `agent status`{{execute}}.

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

1. You can now go back to the Out of the box Kubernetes dashboard in your Datadog account and you should start seeing metrics flowing on all the widget. You can now start monitoring the health of the overall cluster!

1. KSM gives is good insight into the cluster, however, we are still lacking a few key elements. Namely, the actual state of the Control Plane.
In the next exercise, we are going to deploy a Cluster Check runner that will allow us to monitor each component of the Control Plane.
