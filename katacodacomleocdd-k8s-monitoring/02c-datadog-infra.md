With data flowing into Datadog, you can now see your hosts and containers in real time!

The [Host Map](https://app.datadoghq.com/infrastructure/map?node_type=host) shows a visualization of running hosts. The [Container Map]() shows a visualization of running containers. Host map and container map can group by any tag.

For example, [containers grouped by kube_namespace and pod_name](https://app.datadoghq.com/infrastructure/map?node_type=container&groupby=kube_namespace%2Cpod_name) for a high level view of the cluster, or [containers grouped by host and pod_name](https://app.datadoghq.com/infrastructure/map?node_type=container&groupby=host%2Cpod_name) to see the distribution of pods on nodes.
