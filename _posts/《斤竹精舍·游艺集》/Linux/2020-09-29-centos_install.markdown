---
layout:     post
title:      "CentOS 7 安装"
subtitle:   ""
date:       2020-09-29 15:13:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Linux
    - 2020

---
  

### 下载地址
1. 下载资源:https://www.jianshu.com/p/a63f47e096e8
1. 阿里云站点：http://mirrors.aliyun.com/centos/7/isos/x86_64/

### 虚拟机下安装
###### 分区
**除了SWAP分区外，其他分区的文件系统一律选择ext4类型,设备类型默认选LVM。**
1. `/boot`分区：引导分区，**建议分300-500M。**避免由于长期使用的冗余文件塞满这个分区。建议ext4格式，按需求更改。
1. `/`分区：可以比喻为Windows的C盘，但其实有区别。如果你有大量的数据在根目录下（比如FTP等）可以划分大一点的空间，**绝大部分空间都在这，建议15G以上**。看需求，根分区和home分区的大小就类似C盘和D盘的空间分布一样，主要占空间在哪儿就在那里分大容量。建议ext4格式，按需求更改。
1. `swap`分区：类似于Windows的虚拟内存，在内存不够用时占用硬盘的虚拟内存来进行临时数据的存放，而对于linux就是swap分区。swap格式。空间大小参见：[Swap交换分区概念](https://www.cnblogs.com/kerrycode/p/5246383.html)。
1. `/home`分区：存放用户数据，HOME的结构一般是 HOME/userName/userFile，**如果不分则默认在/目录下**。建议ext4格式，按需求更改。
1. `/var`分区：用于log日志的文件的存放，**如果不分则默认在/目录下**。建议ext4格式，按需求更改。**（不建议单独分出来，要不装软件时有时会空间不足，还需要再ln连接很麻烦。）**但如果安装的linux是用于服务器或者经常做日志分析，请划分var分区，避免日志文件不断膨胀塞满导致根分区而引发问题。

###### 安装
安装过程参见：[Linux-CentOs7 安装](https://zhuanlan.zhihu.com/p/26099288)  
注意虚拟机的网络选择“NAT模式，用于共享主机的IP地址”且在分区结束记得配置网络，将以太网ens33开启。（用动态ip就行，别用静态的。）



### 图形界面

1. yum命令安装图形界面：`yum groupinstall "X Window System"`
1. 安装GNOME桌面环境：`yum groupinstall "GNOME Desktop"`
1. 启动图形界面：`startx`
1. 切面界面：crt + alt + F1-F6
1. 设置系统启动后进入图形界面：`systemctl set-default graphical.target`
1. 设置系统启动后进入文本界面：`systemctl set-default multi-user.target`

### 装机
下载的iso文件直接放isos文件夹里安装会出现很多问题，建议用Rufus（绿色软件，在网盘里）直接把CentOS的系统直接做到U盘里然后来装，参见：[1分钟学会U盘启动安装Linux系统](https://www.linuxidc.com/Linux/2019-11/161337.htm)

![](/img/wc-tail.GIF)
