## What's broken

There is one application that is making requests to the apiserver but which is
failing to do so because it is missing permissions.

## Your mission: use Datadog to spot the issue

<details>
<summary>Hints</summary>
The [Kubernetes audit logs](https://app.datadoghq.com/logs?cols=core_host%2Ccore_service&event&index=main&live=true&query=source%3Akubernetes.audit&stream_sort=desc) that we added earlier can be helpful to audit
whoever is making calls to the apiserver. You can use facets to filter on a
specific resources, URI or requester.<br/><br/>

In this case we are looking for `403` HTTP response status codes.
</details>

## Your mission: fix the problem

Find a way to fix the issue and implement it!

As a reminder, all of the manifests for the applications in this section are in
`assets/apps/manifests`.

<details>
<summary>Fix/Explanation</summary>
The `pod-lister` application is making calls to the apiserver to ... list the
pods. However its service account is missing permissions to perform the `list
pods` API call.<br/><br/>

If you run `kubectl get clusterroles pod-lister -oyaml`{{copy}} you will see what the
service account permissions are.<br/><br/>

In this case you will need to add permissions for the `list` verb to the `/pods`
resource.<br/><br/>

We included a sample patch as a solution:<br/><br/>
`kubectl patch clusterroles pod-lister --patch="$(cat assets/apps/fixes/rbac-fix.yaml)"`{{copy}}
</details>
