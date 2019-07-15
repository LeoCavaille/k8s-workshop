To get a more realistic environment and start troubleshooting issues with
Kubernetes we included some sample applications to deploy in your cluster.

* Apply the various manifests and start getting some more pods running in the
  cluster:
`kubectl apply -f assets/apps/manifests/`{{copy}}

The sample apps include:

* a dummy web server called `hello-web` with a bunch of serving replicas and
  several versions of the container
* a redis cache deployment cluster with one master and several slaves
* some custom made Go applications for the workshop

Before moving on to the next step and start finding issues with those
applications, spend a couple minutes describing and listing the resources that
have been created in the environment.

Go see your [container map](https://app.datadoghq.com/infrastructure/map?fillby=avg%3Aprocess.stat.container.io.wbps&sizeby=avg%3Anometric&groupby=host&nameby=name&nometrichosts=false&tvMode=false&nogrouphosts=true&palette=green_to_orange&paletteflip=false&node_type=container) and look at your newly deployed containers.

<details>
<summary>Additional question: you can see that your redis slave pods are created sequentially,
  why?</summary>
`kubectl get pods -owide` prints a list of all the pods in the current namespace. <br/> <br/>

`kubectl get statefulsets` or `kubectl get sts` prints a list of all the statefulsets in the current
namespace. <br/> <br/>

*Answer: redis is a statefulset and by definition pods with a higher ordinal can
only be deployed if all the pods with lower ordinals are marked as `Ready`.*
</details>
