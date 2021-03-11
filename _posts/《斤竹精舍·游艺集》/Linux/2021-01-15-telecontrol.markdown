---
layout:     post
title:      "Linux 远程控制"
subtitle:   ""
date:       2021-01-15 20:40:00
author:     "XiLock"
header-img: "img/in-post/2018-10-26-git-notes/post-bg-rwd.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Linux
    - 2021


---

### 远程软件

##### [MobaXterm](https://mobaxterm.mobatek.net/download-home-edition.html)
1. 免费版的就够用。
1. VNC的时候如果报错：“No configured security type is supported by 3.3 viewer”，则把远程机器的RealVNC的encryption选项选为prefer on，同时远端机器的VNC认证方式从windows认证改成了vnc认证。

##### Xshell/Xftp
###### 连接
1. 通过账号密码或者密钥均可连接。若通过密钥连接，则xshell在Public Key中导入公钥authorized_keys（id_rsa.pub），xftp中导入私钥id_rsa（id_rsa.pem），且务必注意用户名什么的有没有写错。服务器端可能已经有密钥，如果没有则需要自己生成后提交布置一下。
1. para的话地址可以在WinSCP的"Generate session URL/code"里的"Script"里查看sftp后面的地址.

###### 可视化
通过xshell+xmanager可以实现桌面的可视化（具体参见《Xshell显示图形化界面》），这个可视化实际上是个转发，即把服务器端弹出的可视化程序转发到控制端。此方法要求双向互通，否则信号回不来（比如某些在防火墙内的服务器，自己没有公网ipv4/ipv6地址，只有内网ipv4/ipv6地址，能通过跳板机访问到但直接访问的话访问不到；关键是它想直接出来也出不来，所以实现不了信号转发。）。

### 参考资料
1. [解决No configured security type is supported by 3.3 viewer问题](https://blog.csdn.net/gccman/article/details/105690889?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_title-3&spm=1001.2101.3001.4242)
1. [Xshell显示图形化界面](https://blog.csdn.net/kellyseeme/article/details/78700955)

![](/img/wc-tail.GIF)