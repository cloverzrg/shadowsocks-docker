FROM --platform=$BUILDPLATFORM golang:alpine as builder
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG DRONE_TAG
ENV CGO_ENABLED 0
ENV GOOS $TARGETOS
ENV GOARCH $TARGETARCH
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM, GOOS $GOOS, GOARCH $GOARCH"
RUN apk update && apk add --no-cache git build-base make
ENV VERSION $DRONE_TAG
RUN git clone --branch v${VERSION} https://github.com/shadowsocks/go-shadowsocks2.git
WORKDIR /go/go-shadowsocks2

RUN go build -trimpath -ldflags "-s -w" -o bin/go-shadowsocks2 .

FROM --platform=$TARGETPLATFORM alpine:latest
RUN apk update && apk add --no-cache ca-certificates tzdata
COPY --from=builder /go/go-shadowsocks2/bin/go-shadowsocks2 /bin/
ENV TZ=Asia/Shanghai
RUN uname -a
ENTRYPOINT ["/bin/go-shadowsocks2"]
