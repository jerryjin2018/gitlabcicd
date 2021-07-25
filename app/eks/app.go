package main

import (
        "fmt"
        "os"
        "net/http"
)

func main() {
        name, err := os.Hostname()
        if err != nil {
                panic(err)
        }
// ver 2		
        http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
                fmt.Fprintf(w, "Hello, World! And Hostname is:", name)
        })

// ver 1
//        http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
//                fmt.Fprintf(w, "Hello, World!)
//        })

        http.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
                fmt.Fprintf(w, "Healthy!")
        })

        http.ListenAndServe(":8080", nil)
}
