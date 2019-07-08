1. Now let's start to configure the agent in a more specific way, we first want
   to be collecting all sorts of logs coming from our Kubernetes deployment. The
[official
documentation](https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/?tab=k8sfile#enable-capabilities) has some guidelines to bootstrap that
1. In this step you will need to:

  * add the `DD_LOGS_ENABLED` and `DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL`
    environment variables to the daemonset spec and set them to `"true"`
  * mount the two directories inside the agent pod `/var/log/pods` and
    `/var/lib/docker/containers` as we are using Docker as the container runtime
in this environment

1. Once you have edited the spec, re-apply the daemonset to rollout the agent.

+ add rolling update because nothing changed, default daemonset type is OnDelete

