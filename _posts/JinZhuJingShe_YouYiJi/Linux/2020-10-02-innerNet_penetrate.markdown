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
###### win系统控制win系统
1. 注册域名（要求可被cloudflare解析，cloudNS不能被cloudflare解析）.*注意:因为要用cloudfalre里的子域名，所以在coudflare解析阶段需要把子域名也添加到映射规则中*，如`app.xd.x10.mx中app`为子域名的话，除了映射`xd.x10.mx`到cloudflare的两个DNS外还需添加2个`app`到两个DNS的映射.
1. 创建Cloudflare Zero Trust服务: 注册Cloudflare账号（要求双币银行卡），然后开通Cloudflare Zero Trust服务，选择免费套餐。
1. 创建配置tunnel及connectors: 在Networks-->Connectors里创建一个tunnel，进去后，针对主控机和被控机的系统分别安装connector，然后在被控机运行connector指令(win系统用cmd/powershell，主控机不用安)，配置成功后就能在下方的Connectors列表中看到一个“连接者”
1. 配置映射规则: 在该tunnel的`published application routes`中创建一个新的route，填写子域名`subdomain`(如app)、`Domain`(你自己的域名，因为必须是cloudflare解析的域名，所以你之前已经解析过，此处就可以直接选择)、`Service type`(选择`RDP`)、`Service URL`(填`localhost:3389`)
1. 主控端电脑输入命令`cloudflared.exe access rdp --hostname app.xd.x10.mx --url rdp://localhost:3389`，即只用RDP协议访问localhost:3389时会被转发到云端app.xd.x10.mx上(此处3389是主控端的，与被控端的两回事，可与被控端不同，`--url`的目的是将远端网址的隧穿映射到本地ip及接口)
1. 主控端win电脑打开远程，地址输入localhost:3389即可连接

参考资料:
1. [利用Cloudflare Tunnel实现远程桌面访问](https://longlovemyu.com/remote-desktop-connection-using-cloudfare-tunnel)
1. [使用cloudflare tunnel免费内网穿透，实现网站的外网访问和远程桌面](https://zhuanlan.zhihu.com/p/621870045)
1. [内网穿透：如何借助Cloudflare连接没有公网的电脑的远程桌面(RDP)](https://blog.csdn.net/Tisfy/article/details/143114828)
1. [官网的原理解释：无风险的 RDP Cloudflare 基于浏览器的第三方安全访问解决方案](https://blog.cloudflare.com/zh-cn/browser-based-rdp/)


1. 若采用cloudflare发布本地程序，则在映射规则配置过程将`Service type`选择`http`，`Service URL`填`localhost:8080`(本地程序运行的地址及端口)

参考资料:
1. [CloudFlare Tunnel 免费内网穿透的简明教程](https://sspai.com/post/79278)
1. [【白嫖 Cloudflare】之 免费内网穿透，让本地AI服务，触达全球](https://zhuanlan.zhihu.com/p/716891964)


###### win系统控制linux系统（rdp形式，待验证，**远程时需注销远端桌面，不建议**）
1. 与win系统不同，linux作为服务器端还需要安装xrdp，可参照以下代码安装。但是安装后虽然能进入系统且有鼠标但显示为黑屏，且检查过 Wayland 已彻底禁用(`echo $XDG_SESSION_TYPE`返回`
x11`)，初步分析是需要被控端在注销状态下才能以rdp的方式接入，因为黑屏只有鼠标的原因中有一条为“会话管理冲突：Linux 本地已登录，而 XRDP 要求独立登录会话，非桌面共享”，XRDP 在设计上不支持同一用户同时在本地和远程登录，这是一个系统级的强制限制，当尝试通过RDP连接已在本地登录的 Linux 用户时，systemd-logind 会话管理机制会检测到冲突并终止其中一个会话（通常是远程会话），即使会话未被完全终止，D-Bus 会话总线冲突也会导致图形界面无法正常加载，仅显示鼠标指针
1. 上述情况的报错log详见下附xrdp-sesman.log

```
# 安装 / 重启 xrdp（Ubuntu 默认 RDP 服务）：
# 安装xrdp（未装的话）
sudo apt update && sudo apt install xrdp -y
# 修改xrdp端口为3390（确认配置）
sudo sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini
# 重启xrdp并授权
sudo systemctl restart xrdp
sudo usermod -aG xrdp $USER  # 解决权限问题
sudo chown $USER:$USER ~/.Xauthority  # 解决登录黑屏
# 检查端口监听（关键）：
sudo ss -tulpn | grep 3390
# 输出需包含 LISTEN 且进程为xrdp，示例：tcp LISTEN 0 5 127.0.0.1:3390 0.0.0.0:* users:(("xrdp",pid=1234,fd=7))
# 开放防火墙：
sudo ufw allow 3390/tcp
sudo ufw reload

```

附报错信息(`sudo tail -f /var/log/xrdp-sesman.log`)
```
[sudo] password for hongchang: 
[20251206-21:43:10] [INFO ] Found X server running at /tmp/.X11-unix/X11
[20251206-21:43:10] [INFO ] Starting the default window manager on display 11: /etc/xrdp/startwm.sh
[20251206-21:43:10] [INFO ] Session started successfully for user hongchang on display 11
[20251206-21:43:10] [INFO ] Session in progress on display 11, waiting until the window manager (pid 1237211) exits to end the session
[20251206-21:43:10] [INFO ] Starting the xrdp channel server for display 11
[20251206-21:45:39] [INFO ] Socket 8: AF_INET6 connection received from ::ffff:127.0.0.1 port 35838
[20251206-21:45:39] [INFO ] ++ reconnected session: username hongchang, display :11.0, session_pid 1237210, ip ::ffff:127.0.0.1:47802 - socket: 12
[20251206-21:45:39] [ERROR] sesman_data_in: scp_process_msg failed
[20251206-21:45:39] [INFO ] Starting session reconnection script on display 11: /etc/xrdp/reconnectwm.sh
[20251206-21:45:39] [ERROR] sesman_main_loop: trans_check_wait_objs failed, removing trans
```


###### win系统远程linux (SSH)
1. 到配置映射规则前与rdp相同
1. 配置映射规则: 在该tunnel的`published application routes`中创建一个新的route，填写子域名`subdomain`(如remote)、`Domain`(你自己的域名，因为必须是cloudflare解析的域名，所以你之前已经解析过，此处就可以直接选择)、`Service type`(选择`SSH`)、`Service URL`(填`localhost:22`)
1. 主控端电脑输入命令`cloudflared access ssh --hostname remote.xd.x10.mx --url localhost:2222`，即将remote.xd.x10.mx映射到本地win系统的2222端口
1. 主控端win电脑打开命令行或xshell等ssh功能的程序，`ssh localhost:2222`即可连接。也可采用xftp等文件传输。
1. 方法二：若采用命令行的ssh，可不每次运行`cloudflared access ssh --hostname remote.xd.x10.mx --url localhost:2222`，而是创建`C:\Users\Xilock\.ssh\config`文件并添加以下内容，然后直接`ssh remote.xd.x10.mx`即可（但xshell等不行，因为缺乏隧穿remote.xd.x10.mx的过程，会直接解析ipv6，尚未想到很好的解决方法）

```
Host remote.xd.x10.mx
  # 把 D:\tools\cloudflared-windows-amd64.exe 改成你自己的目录
  ProxyCommand C:\Program Files (x86)\cloudflared\cloudflared.exe access ssh --hostname %h
```

1. **如果想直接通过浏览器实现SSH**，可以在cloudflared的application里创建一个针对以上子域名的`Self-host`，且其中`Browser rendering`设置为`SSH`,然后地址栏输入含子域名的地址即可。

Q&A:
1. 主控机位于校园网内时，`ssh ssh.xd.x10.mx -p 22`提示`tls: failed to verify certificate: x509: certificate is valid for landing.soc.ja.net, www.landing.soc.ja.net, not ssh.xd.x10.mx Connection closed by UNKNOWN port 65535`，这是因为采用`自动获得DNA服务器地址`可能会导致域名解析有问题，域名解析可能有问题，即便`ping ssh.xd.x10.mx`也会显示示`Pinging hv1-landing-001.dns.virt.ja.net [193.63.72.83] with 32 bytes of data`，经`nslookup ssh.xd.x10.mx`查看服务器地址解析到了其它地方可确定是DNS策略问题，因此将“网络”中的“Internet 协议版本 4（TCP/IPv4）”中“自动获得DNS服务器地址”改为指定首选`1.1.1.1`和备用`8.8.8.8`（谷歌DNS）即可。


参考资料：
1. [Cloudflare tunnel配置ssh连接](https://www.ha-box.xyz/network/cloudflare-tunnel-ssh/index.print.html)
1. [使用cloudflare tunnel打洞，随时随地访问内网服务](https://blog.yunyuyuan.net/articles/5896)
1. [基本同上·使用Cloudflare Tunnel内网穿透，随时随地访问内网服务](https://b.zzaiyan.com/course/154.html)
1. [Cloudflare Tunnel 内网穿透完整配置指南 - 零公网IP实现域名直连](https://www.wangxubin.site/Blogs/posts/cloudflare-tunnel-blog/)
1. []()


###### win系统远程linux (VNC)
1. 要求安装好VNC服务器端，见《vnc远程服务安装 ubuntu·centos7》一文，ubuntu建议安装tigervnc-standalone-server，如果用自带的默认的VNC会出现黑屏有鼠标的情况(尚未解决)
1. 与SSH区别在于：1)cloudflared端的映射，type为`tcp`，Service URL为`localhost:5900`(此处端口应根据服务器端实际的VNC端口填写，DISPLAY为0时通常为5900，DISPLAY为2时通常为5902)；2）主控端指令`cloudflared access tcp --hostname vnc.xd.x10.mx --url tcp://localhost:5901`
1. 主控端的VNC viewer软件中连接本地地址`localhost:5901`即可映射到vnc.xd.x10.mx 


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
