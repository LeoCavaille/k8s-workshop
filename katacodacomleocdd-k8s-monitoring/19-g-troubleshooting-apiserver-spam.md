## What's broken

There is an application which is hammering our apiserver, our Kubernetes team
thinks a new application deployed recently is responsible for that.

## Your mission: use Datadog to find the issue

We are looking to graph the top requester, or whatever seems to
be spamming and overloading the apiserver on the `pods` endpoint.

<details>
<summary>Hints</summary>
The [Kubernetes audit logs](https://app.datadoghq.com/logs?cols=core_host%2Ccore_service&event&index=main&live=true&query=source%3Akubernetes.audit&stream_sort=desc) that we added earlier can be helpful to audit
whoever is making calls to the apiserver. You can use facets to filter on a
specific resources, URI or requester.<br/><br/>

Then click on "Analytics" in the logs view to display the log query as a metric.
</details>

## Your mission: fix the problem

Find a way to fix the issue and implement it! For this one you will have to find
the source code of this application in the `assets/apps` directory, and look at
a way to fix and replace this spammy call by something else.


<details>
<summary>Fix/Explanation</summary>
You can find in the application source code that it's listing pods with 2
methods: the first one is using a `List` request in a loop every second and the
other one is using a Kubernetes informer (a watch) which is only getting updates
whenever a pod is modified in Kubernetes, rather than requesting the list of all
pods all the time.<br/><br/>

In the source code this behavior is toggled by an env variable `USE_WATCH`, so
try to patch that in your `pod-lister` deployment and watch for the difference
in throughput to the apiserver.<br/><br/>

We included a sample patch as a solution:<br/><br/>
`kubectl patch deployment pod-lister --patch="$(cat assets/apps/fixes/pod-lister-fix.yaml)"`{{copy}}
</details>
