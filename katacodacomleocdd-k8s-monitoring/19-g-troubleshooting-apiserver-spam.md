## What's broken

There is an application which is hammering our apiserver, our Kubernetes team
thinks a new application deployed recently is responsible for that.

## Your mission: use your terminal to spot the issue

<details>
<summary>Hints</summary>
The [Kubernetes audit logs](https://app.datadoghq.com/logs?cols=core_host%2Ccore_service&event&index=main&live=true&query=source%3Akubernetes.audit&stream_sort=desc) that we added earlier can be helpful to audit
whoever is making calls to the apiserver. You can use facets to filter on a
specific resources, URI or requester.
</details>

## Your mission: monitor it in Datadog

TODO

<details>
<summary>Hints</summary>
TODO
</details>

## Your mission: fix the problem

Find a way to fix the issue and implement it!

As a reminder, all of the manifests for the applications in this section are in
`assets/apps/manifests`.

<details>
<summary>Fix/Explanation</summary>
TODO
</details>
