FROM golang:1.12
WORKDIR $GOPATH/src/github.com/LeoCavaille/k8s-workshop/apps/sample-pod-probes
COPY . .
ENV GO111MODULE=on
RUN go install -v
CMD ["sample-pod-probes"]
