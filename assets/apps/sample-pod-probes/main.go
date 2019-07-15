package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/live", func(w http.ResponseWriter, r *http.Request) {
		if r.Header.Get("X-Should-Pass-Liveness") == "true" {
			w.WriteHeader(http.StatusOK)
			return
		}
		log.Println("X-Should-Pass-Liveness header not present, returning error.")
		w.WriteHeader(http.StatusServiceUnavailable)
		w.Write([]byte("Not live.\n"))
	})

	http.HandleFunc("/ready", func(w http.ResponseWriter, r *http.Request) {
		if r.Header.Get("X-Should-Pass-Readiness") == "true" {
			w.WriteHeader(http.StatusOK)
			return
		}
		log.Println("X-Should-Pass-Readiness header not present, returning error.")
		w.WriteHeader(http.StatusServiceUnavailable)
		w.Write([]byte("Not ready.\n"))
	})

	http.HandleFunc("/whoami", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte(fmt.Sprintf("You are %s.\n", r.RemoteAddr)))
	})

	log.Println("Starting server at :8080.")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
