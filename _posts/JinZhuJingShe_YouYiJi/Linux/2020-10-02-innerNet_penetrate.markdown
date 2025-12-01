---
layout:     post
title:      "内网穿透"
subtitle:   ""
date:       2020-10-02 07:13:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Linux
    - 2020

---

### Cloudflare Tunnel

### Frpc-Desktop
1. [Frpc-Desktop](https://github.com/luckjiawei/frpc-desktop)FRP跨平台桌面客户端，可视化配置，轻松实现内网穿透！支持所有frp版本 / 开机自启 / 可视化配置 / 免费开源
1. 需要公网IP

### ngrok
参见[如何远程登录家里的Ubuntu电脑(命令行模式)？](https://www.zhihu.com/question/27771692);

### FRP
（与ngrok相比更稳定）

### 蒲公英
氪金，免费版仅支持3个用户且限速严重（免费版只能用转发模式不能改为P2P？）  
参见：《蒲公英组网》

### ipv6
（参见《ipv6实现半内网穿透》）

### N2N
参见：[组建N2N VPN网络实现内网设备之间的相互访问](https://www.shuyz.com/posts/n2n-vpn-network-introduction-and-config/)

### [Zerotier](https://www.zerotier.com/)

###### 注册管理端 
1. 登陆zerotier 官方网站同意加人网络注意是打“钩”注意要允许以太网桥接；
1. 创建组，记住组的NETWORK ID，后面用

###### win端
1. 下载安装
1. join后添加<NETWORK ID>
1. 在官网的组内可以看到申请，授权

###### linux端
1. 最新指令见：[官网](https://www.zerotier.com/download/)
1. 下载并添加网络ID，其中网络ID在网站登录后的系统里找
```
curl -s https://install.zerotier.com | sudo bash
zerotier-cli join <NETWORK ID>
```
1. 然后，在官网的组内可以看到申请，授权
1. `ip addr`查看有无新增一个zerotier的ip地址；
1. `ping ip地址`，看互通否；
1. ZeroTier One服务将其配置和状态信息保留在其工作目录中：`/var/lib/zerotier-one`；


设置自动开机
```
sudo systemctl start zerotier-one.service
sudo systemctl enable zerotier-one.service
```

参考资料：
1. [超详细安装和使用免费内网穿透软件Zerotier-One](https://cloud.tencent.com/developer/article/2390573)
1. [linux 安装zerotier](https://yfcn.github.io/posts/dce2de1b/)
1. [ZeroTier One 内网穿透、组建虚拟局域网](https://blog.csdn.net/u010953692/article/details/78739509)
1. [内网穿透神器 ZeroTier 使用教程](https://www.hi-linux.com/posts/33914.html)
1. [无公网IP搞定群晖+ZEROTIER ONE实现内网穿透](https://post.m.smzdm.com/p/741270/)

### [inlets](https://github.com/inlets/inlets)
一个反向代理服务器，可以将内网的服务映射到公网。（xilock未测试）



![](/img/wc-tail.GIF)
