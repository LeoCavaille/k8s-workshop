Configuring a pipeline for audit logs in Datadog

1 - Define stageTimestamp as the official log date
Go to the logs/Configuration page
Add a new pipeline "Kubernetes Audit"
Filter on `source:kubernetes.audit`{{copy}}
![Create pipeline](https://raw.githubusercontent.com/LeoCavaille/k8s-workshop/master/assets/img/audit-logs-pipeline.png)

Add DateRemapper processor that uses stageTimestamp
![Date remapper](https://raw.githubusercontent.com/LeoCavaille/k8s-workshop/master/assets/img/audit-logs-date-remapper.png)

2 - Remap attributes to standard ones
We want to remap attributes to standard ones in order to
- have a a single facet for attributes that mean the same ("http.status_code")
- benefit from UI features that rely on them

Add Remapper to remap responseStatus.code to http.status_code
![Status remapper](https://raw.githubusercontent.com/LeoCavaille/k8s-workshop/master/assets/img/audit-logs-status-remapper.png)

Do the same to  remap verb.code to http.method

Add UrlParser to parse `RequestURI` and get details on the URL
![URL parser](https://raw.githubusercontent.com/LeoCavaille/k8s-workshop/master/assets/img/audit-logs-url-parser.png)

3 - Compute API call durations
In the logs, for the `ResponseComplete` stage we have both `stageTimestamp` and `requestReceivedTimestamp` which allows us to compute the duration of each call. To do that, we need first to parse these timetamps as epoch to be able to compute the difference.

Create a Grok Parser to parse `stageTimestamp` into epoch as new field `stageTimestamp_ms`
Set the parsing rule to `parsing_date %{date("yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"):stageTimestamp_ms}`{{copy}}
In advanced settings, set "Extract From" to `stageTimestamp` (the field we want to parse

![stageTimestamp Grok parser](https://raw.githubusercontent.com/LeoCavaille/k8s-workshop/master/assets/img/audit-logs-stage-timestamp-parser.png)

Do the same to parse `requestReceivedTimestamp` into `requestReceivedTimestamp_ms` using this parser: `parsing_date %{date("yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"):requestReceivedTimestamp_ms}`{{copy}} (Don't forget to set extractFrom to `requestReceivedTimestamp`.

Finally, create the duration attribute, using an Arithmetic processor. The formula is `(stageTimestamp_ms - requestReceivedTimestamp_ms)*1000000`{{copy}}. (We convert the duration to nanoseconds).

![Compute duration attribute](https://raw.githubusercontent.com/LeoCavaille/k8s-workshop/master/assets/img/audit-logs-duration.png)

4 - Facets
Now that we have remapped the fields we were interested in we are going to create facets on some fields to make them searchable and give them units (when it applies).

Create facets in group `Web Access` for the method attribute:

![Create method facet](https://raw.githubusercontent.com/LeoCavaille/k8s-workshop/master/assets/img/audit-logs-method-facet.png)

Do the same for these two attributes
- status_code
- url_details.path

Create "measure" for duration and set the unit to nanoseconds.

![Duration measure](https://raw.githubusercontent.com/LeoCavaille/k8s-workshop/master/assets/img/audit-logs-duration-measure.png)

Create a Kubernetes facet in group K8s Audit for `objectRef.name`{{copy}}.

![Object name facet](https://raw.githubusercontent.com/LeoCavaille/k8s-workshop/master/assets/img/audit-logs-name-facet.png)

Do the same for the following attributes:
- `objectRef.namespace`{{copy}}
- `objectRef.resource`{{copy}}
- `user.username`{{copy}}
- `user.group`{{copy}}

5 - Now that audit logs are parsed, look at them again
Here is a few examples of things you can look at logs Analytics:
- API calls by User: [here](https://app.datadoghq.com/logs/analytics?agg_m=count&agg_q=%40user.username&agg_t=count&cols=core_host%2Ccore_service&event&index=main&live=true&panel=%22%22&query=source%3Akubernetes.audit+&step=auto&stream_sort=desc)
- List calls by User
- Delete/Create/Update/Patch by Resource type
- Calls from user: `kubernetes-admin`

You can run a few kubectl commands and see them.
