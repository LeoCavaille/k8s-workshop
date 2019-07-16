DNS is one of the most frequently abused systems in Kubernetes clusters.

* By default, Kubernetes uses a combination of `ndots` and `search-path` to configure DNS for namespace-aware lookup paths.
* Kubernetes nodes are often configured with both IPv4 and IPv6.

These configurations lead to amplification of the number of DNS queries and may put strain on your CoreDNS deployment.

In this section, you'll instrument CoreDNS to find the most abusive DNS clients.

CoreDNS is running in your cluster already, in the `kube-system` namespace. The deployment is named `coredns`. CoreDNS is configured with a file named `Corefile`, mounted from a ConfigMap named `coredns`.

## Metrics

The CoreDNS integration is installed by default using autodiscovery based on the image name.

* Create a DNS [notebook](https://app.datadoghq.com/notebook).
* Add a graph to your notebook to display total request volume for each CoreDNS replica.
* Add a graph to your notebook to display the percentage of requests that result in an error.

<details>
<summary>Hint</summary>
The CoreDNS integration metrics can be found in the [official documentation](https://docs.datadoghq.com/integrations/coredns/#metrics).
</details>

## Logs

Metrics don't tell the whole story - we're missing information about individual clients. 

* Enable per-request logging in CoreDNS.
* Configure your log pipeline to extract the client IP into a facet.
* Use logs analytics to find the top DNS client by request count.
* Use logs to understand the DNs behavior of your heaviest DNS client.

<details>
<summary>Hint</summary>
The CoreDNS log plugin is documented [here](https://github.com/coredns/coredns/tree/master/plugin/log).
</details>

## Dashboard

With metrics and logs enabled for CoreDNS, you'll need a dashboard to bring a high level view of it's behavior.

* Build a dashboard incorporating logs and metrics to provide an overview of CoreDNS and it's clients.
