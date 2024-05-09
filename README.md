# shadowsocks-docker

#### 支持的架构  
`linux/arm64,linux/amd64,linux/386,linux/arm` 需要其他架构可以提issue

#### 支持的plugin  
v2ray-plugin

#### 构建状态   
[![Build Status](https://drone.jeongen.com/api/badges/cloverzrg/shadowsocks-docker/status.svg)](https://drone.jeongen.com/cloverzrg/shadowsocks-docker)

#### 镜像仓库  
https://hub.docker.com/r/cloverzrg/go-shadowsocks2

### 示例

#### 原生
`docker run -d -p 8488:8488 cloverzrg/go-shadowsocks2 -s 'ss://AEAD_CHACHA20_POLY1305:your-password@:8488' -udp -verbose`

#### 使用 v2ray-plugin:  
v2ray-plugin 插件会到容器里面的 `/root/.acme/` 目录读取https证书
`docker run -d -p 8488:8488 cloverzrg/go-shadowsocks2 -s 'ss://AEAD_CHACHA20_POLY1305:your-password@:8488' -verbose -udp -plugin v2ray-plugin -plugin-opts "server;tls;host=your_domain"`

#### docker compose with traefik
https 证书由 traefik 自动更新  
```
services:
  ss-v2ray:
    image: cloverzrg/go-shadowsocks2
    command: -s 'ss://AEAD_CHACHA20_POLY1305:your-password@:8488' -verbose -udp -plugin v2ray-plugin -plugin-opts "server"
    networks:
      - traefik-net
    restart: always
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.ss-v2ray.rule=Host(`your_domain`)"
      - "traefik.http.services.ss-v2ray.loadbalancer.server.port=8488"

networks:
  traefik-net:
    external: true
    name: traefik-net
```

##### 详细参数  
https://github.com/shadowsocks/go-shadowsocks2  
https://github.com/shadowsocks/v2ray-plugin  
