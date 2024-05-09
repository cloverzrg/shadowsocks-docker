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
RUN git clone --branch ${VERSION} https://github.com/shadowsocks/go-shadowsocks2.git
WORKDIR /go/go-shadowsocks2

RUN go build -trimpath -ldflags "-s -w" -o bin/go-shadowsocks2 .
ENV V2RAY_PLUGIN_VERSION v1.3.2
RUN wget https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_PLUGIN_VERSION}/v2ray-plugin-${GOOS}-${GOARCH}-${V2RAY_PLUGIN_VERSION}.tar.gz -O v2ray-plugin.tar.gz
RUN tar -zxvf v2ray-plugin.tar.gz
RUN mv v2ray-plugin_* v2ray-plugin

FROM --platform=$TARGETPLATFORM alpine:latest
RUN apk update && apk add --no-cache git && apk add --no-cache ca-certificates tzdata
COPY --from=builder /go/go-shadowsocks2/bin/go-shadowsocks2 /bin/
COPY --from=builder /go/go-shadowsocks2/bin/v2ray-plugin /bin/
ENV TZ=Asia/Shanghai
RUN uname -a
ENTRYPOINT ["/bin/go-shadowsocks2"]
