---
layout:     post
title:      "Windows to Go"
subtitle:   ""
date:       2021-08-17 16:22:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-10-26-git-notes/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - CS
    - 2021


---

##### 概述
1. WinToGo用了好些年了，但经常遇到幺蛾子，整理一下。据说还有一个WinToUSB企业版（建议），暂时没试过。
1. [Windows To Go：功能概述](https://docs.microsoft.com/zh-cn/windows/deployment/planning/windows-to-go-overview)

##### 系统盘
1. 如果是直接买的固态硬盘而非固态移动硬盘，那么可以直接在里面做系统。
1. 用固态优盘或固态移动硬盘时，因为接口不支持，所以才需要用WinToGo。
1. 装入系统前，盘必须被格式化，且应为GUID格式而非MBR格式（可用DiskGenius处理）。

##### 第三方软件
1. 萝卜头等第三方软件都可以用来制作WinToGo系统，但有的做出来的不能用，比如引导存在问题。
1. Xilock实际使用[傲梅分区助手](https://www.disktool.cn/wintogo.html)口袋系统(WinToGo)

##### Win10镜像下载
1. 下载地址参见[电手](https://www.dianshouit.com/?thread-22.htm)或[这3个地方下载的都是：官网Windows 10镜像](https://www.dianshouit.com/thread-22.htm)
1. **镜像很重要，有的镜像不能做WinToGo**，据说是不低于1907??不好说。
1. 通过比较不同的镜像xilock实际上是从[win10官网](https://www.microsoft.com/zh-cn/software-download/windows10)上下载的“媒体创建工具（MediaCreationTool21H1）”，并用其生成了ISO文件“Windows.iso”

##### Win10激活
1. 参见[Windows 10 激活就只有这4种](https://www.dianshouit.com/thread-26.htm)

##### 备份/还原
用Dism++制备wim，然后还原到指定分区。

##### 使用注意
###### 可能搞烂本机系统的操作
1. 一定要屏蔽本机硬盘，要不会把系统搞烂，特别是原装系统，特别是萝卜头装的WTG。
1. 未关闭win10的快速启动。
1. 在启动/休眠的情况下关机。
1. 使用WTG/PE访问系统盘。

###### 其他
1. 禁用休眠功能，参考[Microsoft-Windows_To_Go常见问题](https://docs.microsoft.com/zh-cn/windows/deployment/planning/windows-to-go-frequently-asked-questions)
1. 在硬盘系统里访问WTG系统一般不会破坏WTG的系统（朋友一块机械盘装好几个WTG和PE且常年互访都没出过问题），只要屏蔽快速启动（WTG一般直接屏蔽），除非PE乱删文件，因为要删WTG文件是要有权限的。
1. 接上，但还是不建议在WTG系统里访问硬盘的系统分区，建议使用WTG时屏蔽本机系统分区，教程参见[Windows To Go屏蔽本机硬盘教程](https://bbs.luobotou.org/thread-6778-1-1.html)
1. WTG不能升级，如果想升级需要重新安装。
1. 完全关闭后才能拔下移动硬盘。

###### 如果没屏蔽本机硬盘把系统搞烂了
1. 常用方法为下载iso刻盘启动，“开始安装-->修复计算机”，但只有10%的情况可以修。
1. 找替换文件。
1. 如果能进安全模式，`chkdsk c: /f`和`sfc /scannow`修复磁盘。

##### 附录
###### 宿主电脑硬盘挂载
这是官方对于是否挂载宿主电脑硬盘的说明。尤其宿主操作系统版本Windows7或更早的，不建议挂载。

I’m booted into Windows To Go, but I can’t browse to the internal hard drive of the host computer. Why not?
Windows To Go Creator and the recommended deployment steps for Windows To Go set SAN Policy 4 on Windows To Go drive. This policy prevents Windows from automatically mounting internal disk drives. That’s why you can’t see the internal hard drives of the host computer when you are booted into Windows To Go. This is done to prevent accidental data leakage between Windows To Go and the host system. This policy also prevents potential corruption on the host drives or data loss if the host operating system is in a hibernation state. If you really need to access the files on the internal hard drive, you can use diskmgmt.msc to mount the internal drive.

警告

It is strongly recommended that you do not mount internal hard drives when booted into the Windows To Go workspace. If the internal drive contains a hibernated Windows 8 operating system, mounting the drive will lead to loss of hibernation state and therefor user state or any unsaved user data when the host operating system is booted. If the internal drive contains a hibernated Windows 7 or earlier operating system, mounting the drive will lead to corruption when the host operating system is booted.

![](/img/wc-tail.GIF)