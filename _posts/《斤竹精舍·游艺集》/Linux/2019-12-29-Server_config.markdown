---
layout:     post
title:      "服务器配置"
subtitle:   ""
date:       2019-12-29 16:22:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Linux
    - 2019

---
  

### 其它电脑连接服务器

###### 网线直联
1. 保证其它电脑（如你的笔记本）跟服务器处于同一局域网内（直接将服务器的网线连接到你的电脑）；
1. 将笔记本的IP地址该为跟Server一致，如：server的IP为11.11.11.1-11.11.11.9则笔记本的IP地址可设置为11.11.11.0或类似11.11.11.109之类的，子网掩码设置为255.0.0.0；
1. 用putty/xshell测试是否连接成功。

###### 路由器连接
1. 将服务器的网线连接到路由器的任意LAN端口（WLAN为外网接口，用于输入；LAN为局域网接口，几个连接LAN的端口的电脑和连接该路由器的电脑将位于同一局域网）；
1. 将路由器的IP地址该为跟Server一致，如：server的IP为11.11.11.1-11.11.11.9则笔记本的IP地址可设置为11.11.11.0或类似11.11.11.109之类的，子网掩码设置为255.0.0.0；
1. 用其他电脑连接该路由器，用putty/xshell测试是否连接成功。

### VNC实现win端可视化控制Linux

参考资料：[VNC的安装和配置](https://www.cnblogs.com/jyzhao/p/5615448.html)  


![](/img/wc-tail.GIF)
