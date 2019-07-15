## Setup

* Deploy the probes sample application: 
`kubectl apply -f assets/apps/sample-pod-probes/deployment.yaml`{{copy}}

## What's broken

The `sample-pod-probes` pod is in `CrashLoopBackoff` state.

## Your mission: use your terminal to spot the issue

<details>
<summary>Hints</summary>
The pod list has a `STATUS` column telling you in which state the pod is.
<br/><br/>

If you `kubectl describe pod <POD_NAME>` you will see some more details about
the life of the pod and what is going wrong. <br/><br/>

Also go to your [logs explorer](https://app.datadoghq.com/logs) and add filters
to your query to filter the logs of your pods. <br/><br/>

Pods logs are also visible using `kubectl logs`.
</details>

## Your mission: fix the problem

Find a way to fix the issue and implement it, then look at your previously
created graph to see it fixed there too!

<details>
<summary>Fix/Explanation</summary>
The pod is failing liveness checks.<br/><br/> 

The application requires a header `X-Should-Pass-Liveness: true` to pass liveness checks.<br/><br/>

The probe definition allows setting a custom HTTP header:<br/>
```
livenessProbe:
  httpGet:
    path: /live
    port: 8080
    httpHeaders:
      - name: X-Should-Pass-Liveness
        value: "true"
```

Use `kubectl edit` to add the `httpHeaders` to your liveness check.<br/><br/>

We included a sample patch as a solution:<br/><br/>
`kubectl patch deployment pod-probes --patch="$(cat assets/apps/fixes/pod-probes-liveness-fix.yaml)"`{{copy}}
</details>
