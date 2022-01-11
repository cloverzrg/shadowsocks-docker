# shadowsocks-docker

构建状态。  
[![Build Status](https://drone.jeongen.com/api/badges/cloverzrg/shadowsocks-docker/status.svg)](https://drone.jeongen.com/cloverzrg/shadowsocks-docker)

镜像仓库  
https://hub.docker.com/r/cloverzrg/go-shadowsocks2

示例:  
docker run -d -p 8488:8488 cloverzrg/go-shadowsocks2 -s 'ss://AEAD_CHACHA20_POLY1305:your-password@:8488' -verbose

详细参数。
https://github.com/shadowsocks/go-shadowsocks2
