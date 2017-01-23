FROM golang:alpine 

ADD ./server.go /ops/server.go

EXPOSE 3000

CMD go run /ops/server.go