## What's broken

There is an application which is not running because it is in `ImagePullBackoff`
state.

## Your mission: use your terminal to spot the issue

<details>
<summary>Hints</summary>
The pod list has a `STATUS` column telling you in which state the pod is.
</details>

## Your mission: monitor it in Datadog

Add to your [notebook](https://app.datadoghq.com/notebook) a graph that
represents the number of pods pending to be scheduled.

Here are the available metrics reported from the [kubernetes state metrics
integration](https://docs.datadoghq.com/integrations/kubernetes/#kubernetes-state)
we installed earlier.

<details>
<summary>Hints</summary>
`kubernetes_state.container.status_report.count.waiting` is giving you the count of the containers currently reporting a in waiting state with the `reason` as a tag, using the `sum by` aggregator will give you the total number of containers matching this state.
</details>

## Your mission: fix the problem

Find a way to fix the issue and implement it, then look at your previously
created graph to see it fixed there too!

As a reminder, all of the manifests for the applications in this section are in
`assets/apps/manifests`.

<details>
<summary>Fix/Explanation</summary>
This pod failed to run because it was trying to use an image which does not
exist in the hub.<br/><br/> 

A metric query that identifies this issue is `kubernetes_state.container.status_report.count.waiting` filtered on `reason:errimagepull`<br/><br/> 

In this case the image is:
`k8s.gcr.io/pause:3.1-oops-i-did-a-typo-in-the-image-version` <br/><br/>

So if you just change the manifest to use something that exists and re-apply the
manifest you should be on your way!<br/><br/>

We included a sample patch as a solution:<br/><br/>
`kubectl patch deployment espresso --patch="$(cat assets/apps/fixes/espresso-fix.yaml)"`{{copy}}
</details>
