---
layout:     post
title:      "双网卡电脑同时上内外网"
subtitle:   " "
date:       2020-07-31 13:52:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - CS
    - 2020


---

**感谢嘉桢的技术指导**

### 问题描述
有时候希望实验室电脑能同时登陆内外网，内网控制实验室服务器，外网与其他计算机远程。同时连接内外网可通过有线和无线来实现，但有时会出现内外网的ip冲突而出现无法连接外网或者无法连接内网的情况，如外网连接不上向日葵等。  
为了解决这种问题，则需要手动修改一下路由器表。
### 方法
1. 查看内外网的ip地址段（网关），如xilock内网服务器（及其路由器）的网关为11.11.11.109（ip地址段为11.11.11.0-x），实验室外网路由器的网关为192.168.10.1，校园网的ip地址为172.23.55.178（xilock后面设定时选择网关为172.23.0.1）；
1. 用 `route print` 来查看路由器表；
1. 用 `route delete 0.0.0.0` 来删除所有的0.0.0.0的缺省路由；
1. 接下来以有线连接内网，无线网卡连接外网为例；
1. 用 `route add 11.0.0.0 mask 255.0.0.0 11.11.11.109 -p`来设置内网的静态路由（即`route add 网络目标 mask 网络掩码 网关`，-p的意思是永久有效，防止重启电脑后配置的这条静态路由消失。）；
1. 用 `route add 0.0.0.0 mask 0.0.0.0 172.23.0.1 -p` 来设置外网静态路由，设置缺省路由的下一跳为172.23.0.1；
1. 用 `route print` 来检查配置完的路由器表。

使用实验室路由器连接外网配置：  
![](/attachment/computer/dinet_lab_route.png)  
使用tju连接外网配置：  
![](/attachment/computer/dinet_tju.png)

### 因路由器表变动而无法联网
有时路由器表会自动添加上一条将缺省路由链接到内网的记录，导致无法连接外网，使用下面的脚本可以定时查找这条记录并删除。  

delete_route_table.bat
```
@echo off

:start
route print | findstr 0.0.0.0 | findstr 11.11.11.109 >nul && route delete 0.0.0.0 mask 0.0.0.0 11.11.11.109

choice /t 300 /d y /n >nul
goto start
```

### 参考
1. [如何设置双网卡电脑同时上内外网](https://jingyan.baidu.com/article/cbf0e500ac8b232eaa289339.html)

![](/img/wc-tail.GIF)