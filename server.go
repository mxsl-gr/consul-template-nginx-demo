package main

import (
	"net/http"
  "fmt"
  "os"
)

func main() {
  http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request){
    fmt.Fprintf(w, "Hi, I am [%s]!", os.Getenv("SERVER_NAME"))
  })
  http.ListenAndServe(":3000", nil)
}
