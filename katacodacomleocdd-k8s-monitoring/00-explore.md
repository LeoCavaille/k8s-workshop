Welcome to your personal workshop environment! Before we get started, let's explore.

First, a note on Katacoda:

* This is a "copy" command, clicking on it copies the command to your clipboard:
`export MY_ENV_VAR=<something-you-should-edit>`{{copy}}

* This is an "execute" command, clicking on it executes it directly in your shell:
`echo "I set my env var to ${MY_ENV_VAR}."`{{execute}}

Now, let's test out the cluster.

* First, test your client and server are configured properly: 
`kubectl version`{{execute}}

* You can view some basic information about the cluster: 
`kubectl cluster-info`{{execute}}

* And finally, make sure our cluster nodes are `Ready`: 
`kubectl get nodes`{{execute}}
