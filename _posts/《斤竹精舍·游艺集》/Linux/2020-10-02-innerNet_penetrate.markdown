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
下载并添加网络ID：  
```
curl -s https://install.zerotier.com | sudo bash
zerotier-cli join 网络ID
```

之后：  
1. 登陆zerotier 官方网站同意加人网络注意是打“钩”注意要允许以太网桥接；
1. `ip addr`查看有无新增一个zerotier的ip地址；
1. `ping ip地址`，看互通否；
1. ZeroTier One服务将其配置和状态信息保留在其工作目录中：`/var/lib/zerotier-one`；

参考资料：
1. [linux 安装zerotier](https://yfcn.github.io/posts/dce2de1b/)
1. [ZeroTier One 内网穿透、组建虚拟局域网](https://blog.csdn.net/u010953692/article/details/78739509)
1. [内网穿透神器 ZeroTier 使用教程](https://www.hi-linux.com/posts/33914.html)
1. [无公网IP搞定群晖+ZEROTIER ONE实现内网穿透](https://post.m.smzdm.com/p/741270/)

### [inlets](https://github.com/inlets/inlets)
一个反向代理服务器，可以将内网的服务映射到公网。（xilock未测试）

![](/img/wc-tail.GIF)
