1. Add your API key
`kubectl create secret generic datadog-api-key --from-literal=token=$DD_API_KEY`
1. Install the agent by applying to Kubernetes the default install manifests
   (see [official documentation](https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/))
`for f in assets/01_deploying_datadog_agent/agent-*; do kubectl apply -f $f; done`{{execute}}
1. Now watch the agent pods as they come live to see the agent being deployed
`kubectl get pods -w -owide`{{execute}}
1. Also look at the status of the daemonset
`kubectl get daemonset`{{execute}}

1. As there is only one worker node, you will only see one pod running. 
You can already go in your Datadog account to see the metrics reporting.
As the agent will start collecting metrics from the kubelet, an out of the box dashboard has been created for you, you can find it [here](https://app.datadoghq.com/screen/integration/86/kubernetes---overview).

1. Part of the dashboard is going to be empty however. This is because the agent is only collecting node level metrics. As part of the next exercise, we are going to deploy an application that will help us get a cluster overview. You can now move on to the Step 2: Installing Kubernetes State Metrics.
