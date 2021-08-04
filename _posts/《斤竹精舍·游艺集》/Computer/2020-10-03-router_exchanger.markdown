---
layout:     post
title:      "路由器配置成交换机"
subtitle:   ""
date:       2020-10-03 19:52:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-10-26-git-notes/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - CS
    - 2018


---

### 步骤
1. 将设置电脑连接到路由器的LAN口，确保电脑自动获取到IP地址和DNS服务器地址；
1. 登录管理界面；
1. 关闭“DHCP服务器”；
1. 将“LAN口”ip修改为和主路由器同一网段的不同IP地址，比如主路由器为`192.168.1.1`则二级路由器LAN口ip可设为`192.168.1.10`（建议记住路由器的IP地址，在浏览器中输入修改后的IP地址进行登录路由器管理页面）；
1. 将二级路由器的LAN口与主路由器的LAN口相连，至此已完成交换机的配置，

### 参考资料：
[如何设置路由器当无线交换机使用](https://service.tp-link.com.cn/detail_article_4145.html)


![](/img/wc-tail.GIF)