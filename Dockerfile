# ---
# Stage 1: Install certs and build conformance binary
# ---
FROM docker.io/golang:1.13.6-alpine3.11 AS builder
RUN apk --update add git ca-certificates && \
    mkdir -p /go/src/github.com/bloodorangeio/opencontainers && \
    cd /go/src/github.com/bloodorangeio/opencontainers && \
    git clone https://github.com/opencontainers/distribution-spec.git && \
    cd distribution-spec/conformance && \
    CGO_ENABLED=0 go test -c && mv conformance.test /conformance.test

# ---
# Stage 2: Final image with nothing but certs & binary
# ---
FROM scratch AS final
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /conformance.test /conformance.test
WORKDIR /output
ENTRYPOINT ["/conformance.test"]
