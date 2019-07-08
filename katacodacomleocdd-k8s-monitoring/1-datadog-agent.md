1. Add your API key to the Kubernetes cluster
`kubectl create secret generic datadog-api-key --from-literal=token=$DD_API_KEY`{{copy}}
1. Install the agent by applying to Kubernetes the default install manifests
(see [official documentation](https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/))
`kubectl apply -f assets/datadog-agent`{{copy}}
1. Now watch the agent pods as they come live to see the agent being deployed
`kubectl get pods -w -owide`{{copy}}
1. You can also look at the status of the daemonset
`kubectl get daemonset`{{copy}}

Now you can see that there is only a single pod being run. We had said there
were actually two nodes in this environment (the Kubernetes master where you
have your terminal and node01 another Kubernetes node). **So why aren’t there two
agents running?**

In general, only the nodes in the cluster will run the agent, but
it’s also possible to run the agent on master if you add the tolerance to the
pod because the master as a specific taint. In the `assets/datadog-agent/agent-daemonset.yaml`
file, add the following to pod spec (in `spec.template.spec`):
<pre class-"file" data-target="clipboard">
tolerations:
  - key: node-role.kubernetes.io/master
    effect: NoSchedule
</pre>
**tolerations: should be at the same indent level as containers: below it**

1. Now apply the file again:
`kubectl apply -f assets/datadog-agent`{{copy}}
1. Watch a new agent pod being scheduled on the master node:
`kubectl get pods -w -owide`{{copy}}

Now take a look at your Kubernetes dashboard, you should see it getting updates
on the state of your cluster. Some metrics are missing, go to the next step to
fix that!
