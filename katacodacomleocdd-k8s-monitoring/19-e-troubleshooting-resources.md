## What's broken

There are pods that are `Pending` and as a result they are not running.

## Your mission: use your terminal to spot the issue

<details>
<summary>Hints</summary>
The pod list has a `STATUS` column telling you in which state the pod is.
<br/><br/>

If you `kubectl describe pod <POD_NAME>` you will see some more details about
the life of the pod and what is going wrong.
</details>

## Your mission: monitor it in Datadog

Add to your [notebook](https://app.datadoghq.com/notebook) a graph that
represents the number of pods that cannot be scheduled.

<details>
<summary>Hints</summary>
`kubernetes_state.pod.status_phase` is giving you the count of the containers currently reporting per `phase` of the pod lifecycle (pending, running, succeeded, ...).
</details>

## Your mission: fix the problem

Find a way to fix the issue and implement it, then look at your previously
created graph to see it fixed there too!

As a reminder, all of the manifests for the applications in this section are in
`assets/apps/manifests`.

<details>
<summary>Fix/Explanation</summary>
These pods failed to run because the pod is requesting an absurdly large amount of
resources: 5000 CPU millicores (5 whole CPUs) and 32GB of memory.<br/><br/> 

A metric query that identifies this issue is to look at pods in error
`kubernetes_state.pod.status_phase` filtered on
`phase:pending`<br/><br/> 

In this case because the pod comes from a cronjob, we see that we are getting
more and more scheduling errors over time as every minute a new pod is created
by the cronjob. We have to patch the cronjob and then purge the old pods that
will never be able to be scheduled. <br/><br/>

A more reasonable request for resources might be: 50 millicores and 50 MB.<br/><br/>

Then to delete all the pending pods you can find a label that matches on all
those pods: here `app=americano`.<br/><br/>

Then delete them with that filter: `kubectl delete pod
-lapp=americano`<br/><br/>

Wait for the newest pod coming from the cronjob to be scheduled
properly.<br/><br/>

We included a sample patch as a solution:<br/><br/>
`kubectl patch cronjob americano-job --patch="$(cat assets/apps/fixes/americano-fix.yaml)"`{{copy}}
</details>
