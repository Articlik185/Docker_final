FROM golang:1.22 AS build
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 go build -o /out/parcel-tracker .

FROM alpine:3.22
WORKDIR /app
COPY --from=build /out/parcel-tracker /usr/local/bin/parcel-tracker
COPY tracker.db ./
ENTRYPOINT ["/usr/local/bin/parcel-tracker"]
