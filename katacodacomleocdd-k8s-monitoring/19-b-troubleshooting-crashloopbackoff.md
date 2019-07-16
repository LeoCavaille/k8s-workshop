## What's broken

There is an application which is not running because it is in `CrashLoopBackoff`
state.

## Your mission: use your terminal to spot the issue

<details>
<summary>Hints</summary>
The pod list has a `STATUS` column telling you in which state the pod is.
<br/><br/>

If you `kubectl describe pod <POD_NAME>` you will see some more details about
the life of the pod and what is going wrong. <br/><br/>

Also go to your [logs explorer](https://app.datadoghq.com/logs) and add filters
to your query to filter the logs of your pods. <br/><br/>

Pods logs are also visible using `kubectl logs`.
</details>

## Your mission: monitor it in Datadog

Add to your [notebook](https://app.datadoghq.com/notebook) a graph that
represents the number of pods in `CrashLoopBackoff` state.

Here are the available metrics reported from the [kubernetes 
integration](https://docs.datadoghq.com/integrations/kubernetes/#kubernetes-state)
we installed earlier.

<details>
<summary>Hints</summary>
`kubernetes.containers.state.waiting` is giving you the count of the containers currently reporting a in waiting state with the `reason` as a tag.
</details>

## Your mission: fix the problem

Find a way to fix the issue and implement it, then look at your previously
created graph to see it fixed there too!

As a reminder, all of the manifests for the applications in this section are in
`assets/apps/manifests`.

<details>
<summary>Fix/Explanation</summary>
This pod failed to run because the command in the container it ran exited with a
non-zero status code.<br/><br/> 

A metric query that identifies this issue is to look at pods in error
`kubernetes.containers.state.waiting` filtered on `reason:crashloopbackoff` and grouped by `kube_deployment`<br/><br/> 

In this case the command in the deployment is:
`/bin/false` <br/><br/>

So if you just change the manifest to use a command that would not return a
non-zero exit code and re-apply the manifest you should be on your
way!<br/><br/>

We included a sample patch as a solution:<br/><br/>
`kubectl patch deployment macchiato --patch="$(cat assets/apps/fixes/macchiato-fix.yaml)"`{{copy}}
</details>
