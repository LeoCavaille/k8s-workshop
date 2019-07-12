The agent should run on all nodes in our cluster, regardless of `taints`. 

The following patch adds a `toleration` for all taints: <br/>
```
# assets/03-datadog-agent-everywhere/tolerate-all.patch.yaml
spec:
  template:
    spec:
      tolerations:
        - operator: Exists
```

Apply the patch: <br/>
`kubectl patch daemonset datadog-agent --patch "$(cat assets/03-datadog-agent-everywhere/tolerate-all.patch.yaml)"`

Finally, verify that the agent is running on all nodes in the cluster.
