package main

import (
	"fmt"
	"os"
	"sync/atomic"
	"time"

	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/util/runtime"
	"k8s.io/client-go/informers"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/rest"
	"k8s.io/client-go/tools/cache"

	"gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer"
)

func main() {
	config, err := rest.InClusterConfig()
	if err != nil {
		panic(err)
	}

	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		panic(err)
	}

	tracer.Start(
		tracer.WithServiceName("sample-pods-lister"),
		tracer.WithDebugMode(true),
	)
	defer tracer.Stop()
	stopper := make(chan struct{})
	defer close(stopper)

	// Good job, you find whoever wrote this gem :-)
	// But as you can see we already implemented the solution so no need to recompile the
	// binary and you can just toggle the proper behavior by adding an environment
	// variable to this app's deployment manifest
	if os.Getenv("USE_WATCH") != "" {
		factory := informers.NewSharedInformerFactory(clientset, 0)
		informer := factory.Core().V1().Pods().Informer()
		defer runtime.HandleCrash()

		var pods int64

		informer.AddEventHandler(cache.ResourceEventHandlerFuncs{
			AddFunc:    func(obj interface{}) { atomic.AddInt64(&pods, 1) },
			DeleteFunc: func(interface{}) { atomic.AddInt64(&pods, -1) },
		})

		go informer.Run(stopper)
		if !cache.WaitForCacheSync(stopper, informer.HasSynced) {
			runtime.HandleError(fmt.Errorf("Timed out waiting for caches to sync"))
			return
		}
		go func() {
			for range time.Tick(1 * time.Second) {
				lpods := atomic.LoadInt64(&pods)
				fmt.Printf("found %d pods\n", lpods)
			}
		}()
	} else {
		for {
			select {
			case <-stopper:
				break
			default:
				pods, err := clientset.CoreV1().Pods("").List(metav1.ListOptions{})
				if err != nil {
					panic(err)
				}
				fmt.Printf("found %d pods\n", len(pods.Items))
				time.Sleep(1 * time.Second)
			}
		}
	}
	<-stopper
}
