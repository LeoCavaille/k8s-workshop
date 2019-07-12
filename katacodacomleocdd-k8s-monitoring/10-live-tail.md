Live tail shows a realtime stream of all logs as they are ingested. In order to demonstrate live tail, we'll deploy a sample application that logs one message every second per replica.

* Deploy the sample application:
`kubectl apply -f assets/10-live-tail/log-a-lot.yaml`{{copy}}

* Observe logs flowing through live tail.

Visit the live tail page by click from the left navigation pane: Logs > Live Tail.

To demonstrate live tail sampling and streaming, let's increase the replica count.

* Increase the replica count:
`kubectl scale deployment log-a-lot --replicas 30`{{copy}}

* Validate your new pods are running.

* Observe traffic in live tail as it's sampled according to volume.
