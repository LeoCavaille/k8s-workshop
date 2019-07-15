Kubernetes uses a [special manifest](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#audit-policy) to configure what gets output into the audit
log file.

* Look at the policy currently in use in the environment:
`cat /etc/kubernetes/audit-policies/policy.yaml`

TODO leo
