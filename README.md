# shadowsocks-docker

支持的架构  
`linux/arm64,linux/amd64,linux/386,linux/arm` 需要其他架构可以提issue

构建状态   
[![Build Status](https://drone.jeongen.com/api/badges/cloverzrg/shadowsocks-docker/status.svg)](https://drone.jeongen.com/cloverzrg/shadowsocks-docker)

镜像仓库  
https://hub.docker.com/r/cloverzrg/go-shadowsocks2

示例:  
`docker run -d -p 8488:8488 cloverzrg/go-shadowsocks2 -s 'ss://AEAD_CHACHA20_POLY1305:your-password@:8488' -udp -verbose`

详细参数  
https://github.com/shadowsocks/go-shadowsocks2
