Now, let's test out your Kubernetes cluster.

* First, test your client and server are configured properly: 
`kubectl version`{{execute}}

* You can view some basic information about the cluster: 
`kubectl cluster-info`{{execute}}

* And finally, make sure our cluster nodes are `Ready`: 
`kubectl get nodes`{{execute}}

If your nodes are `NotReady`, give it a minute and try again until they become `Ready`.
