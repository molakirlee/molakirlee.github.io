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
1. 注册域名（要求可被cloudflare解析，cloudNS不能被cloudflare解析）.*注意:因为要用cloudfalre里的子域名，所以在coudflare解析阶段需要把子域名也添加到映射规则中*，如`app.xd.x10.mx中app`为子域名的话，除了映射`xd.x10.mx`到cloudflare的两个DNS外还需添加2个`app`到两个DNS的映射.
1. 创建Cloudflare Zero Trust服务: 注册Cloudflare账号（要求双币银行卡），然后开通Cloudflare Zero Trust服务，选择免费套餐。
1. 创建配置tunnel及connectors: 在Networks-->Connectors里创建一个tunnel，进去后，针对主控机和被控机的系统分别安装connector，然后在被控机运行connector指令(win系统用cmd/powershell，主控机不用安)，配置成功后就能在下方的Connectors列表中看到一个“连接者”
1. 配置映射规则: 在该tunnel的`published application routes`中创建一个新的route，填写子域名`subdomain`(如app)、`Domain`(你自己的域名，因为必须是cloudflare解析的域名，所以你之前已经解析过，此处就可以直接选择)、`Service type`(选择`RDP`)、`Service URL`(填`localhost:3389`)
1. 主控端电脑输入命令`cloudflared.exe access rdp-hostname app.xd.x10.mx --url rdp://localhost:3389`，即只用RDP协议访问localhost:3389时会被转发到云端app.xd.x10.mx上(此处3389是主控端的，与被控端的两回事，可与被控端不同)
1. 主控端电脑打开

参考资料:
1. [利用Cloudflare Tunnel实现远程桌面访问](https://longlovemyu.com/remote-desktop-connection-using-cloudfare-tunnel)
1. [使用cloudflare tunnel免费内网穿透，实现网站的外网访问和远程桌面](https://zhuanlan.zhihu.com/p/621870045)
1. [内网穿透：如何借助Cloudflare连接没有公网的电脑的远程桌面(RDP)](https://blog.csdn.net/Tisfy/article/details/143114828)
1. [官网的原理解释：无风险的 RDP Cloudflare 基于浏览器的第三方安全访问解决方案](https://blog.cloudflare.com/zh-cn/browser-based-rdp/)


1. 若采用cloudflare发布本地程序，则在映射规则配置过程将`Service type`选择`http`，`Service URL`填`localhost:8080`(本地程序运行的地址及端口)

参考资料:
1. [CloudFlare Tunnel 免费内网穿透的简明教程](https://sspai.com/post/79278)
1. [【白嫖 Cloudflare】之 免费内网穿透，让本地AI服务，触达全球](https://zhuanlan.zhihu.com/p/716891964)

### Frpc-Desktop
1. [Frpc-Desktop](https://github.com/luckjiawei/frpc-desktop)FRP跨平台桌面客户端，可视化配置，轻松实现内网穿透！支持所有frp版本 / 开机自启 / 可视化配置 / 免费开源
1. **需要公网IP**

### ngrok
1. 参见[如何远程登录家里的Ubuntu电脑(命令行模式)？](https://www.zhihu.com/question/27771692);
1. 不如FRP稳定

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
