FROM golang:1.22-alpine AS builder
WORKDIR /go/src/app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o /go/bin/app

FROM alpine:latest
WORKDIR /usr/local/bin
COPY --from=builder /go/bin/app .
EXPOSE 3003
CMD ["./app"]
