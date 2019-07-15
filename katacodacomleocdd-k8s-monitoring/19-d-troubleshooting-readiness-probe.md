## Setup

* Deploy the probes service: 
`kubectl apply -f assets/apps/sample-pod-probes/service.yaml`{{copy}}

## What's broken

The `sample-pod-probes` pod is in `Running` state, but the `Service` has no backends. 

## Your mission: use your terminal to spot the issue

<details>
<summary>Hints</summary>
`kubectl get service` prints a list of services.<br/><br/>

`kubectl describe service <service-name>` prints details about a service. <br/><br/>

`kubectl get po` prints a list of pods, and their readiness status. <br/><br/>
</details>

## Your mission: monitor it in Datadog

Add to your [notebook](https://app.datadoghq.com/notebook) a graph that
represents the number of available endpoints for a service.

Here are the available metrics reported from the [kubernetes state metrics
integration](https://docs.datadoghq.com/integrations/kubernetes/#kubernetes-state)
we installed earlier.

<details>
<summary>Hints</summary>
`kubernetes_state.endpoint.address_available` reports the number of available endpoints for a service. <br/><br/>

`kubernetes_state.endpoint.address_not_ready` reports the number of "not ready" endpoints for a service.
</details>

## Your mission: fix the problem

Find a way to fix the issue and implement it, then look at your previously
created graph to see it fixed there too!

<details>
<summary>Fix/Explanation</summary>
The pod is failing readiness checks.<br/><br/> 

The application requires a header `X-Should-Pass-Readiness: true` to pass readiness checks.<br/><br/>

The probe definition allows setting a custom HTTP header:
```
        readinessProbe:
          httpGet:
            path: /ready
            port: 8080
            httpHeaders:
              - name: X-Should-Pass-Readiness
                value: true
```

Use `kubectl edit` to add the `httpHeaders` to your liveness check.

Verify that there are healthy endpoints for your service. <br/> <br/>
</details>

The service should respond to `curl http://<my-service-ip>/whoami` after you fix it.
