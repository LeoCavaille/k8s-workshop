apiVersion: apps/v1
kind: Deployment
metadata:
  name: sample-app-clb
  labels:
    app: sample-app-clb
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sample-app-clb
  template:
    metadata:
      labels:
        app: sample-app-clb
    spec:
      containers:
      - name: alpine
        image: alpine:latest
        command: ["/bin/false"]
