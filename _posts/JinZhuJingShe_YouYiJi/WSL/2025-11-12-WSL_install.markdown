---
layout:     post
title:      "WSL 安装·硬盘迁移"
subtitle:   ""
date:       2025-11-12 07:39:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - WSL
    - 2025

---




### Win-WSL2版
1. [《记一次Lammps上GPU加速的折腾，和CPU核数越多越慢的奇特表现》](http://bbs.keinsci.com/thread-18771-1-1.html)一文有以下结论：1） WSL2已经非常好用。笔记本没必要刷Linux桌面了。2） LAMMPS就是单进程搭单卡，计算90%扔GPU上的架构。（具体来讲和对势、键势、接邻列表算法等有关）。
1. [《Gaussian 16在虚拟机和WSL中的相对效率 - 计算化学公社》](http://bbs.keinsci.com/thread-16405-1-1.html)提到"WSL效率确实不错，(相比ubuntu)只损失了10%多点的性能"


###### WLS2安装
1. 在Windows搜索栏中搜索控制面板，程序→启用或关闭Windows功能→勾选"开启Hyper-v"、"虚拟机平台"、"适用于Linux的Windows子系统"这3项（Hyper-v是用来提高性能的，家庭版window可能没这个选项，可参考[《Windows11家庭版上安装Hyper-V并导入虚拟机的方法》](https://blog.csdn.net/breaksoftware/article/details/135754808)）
1. 在微软应用商店中搜索Ubuntu，选择需要安装的发行版本（以Ubuntu 22.04.2为例），下载完成后即可在开始菜单中找到，点击运行，开始安装。随后根据提示设置用户名和密码。
1. 在PowerShell（在Win搜索栏中搜索打开）中输入wsl -l -v 即可查看WSL的运行状态和版本，如果version是2则说明是WLS2，否则就是WLS，参照资料进一步改为WLS2。






参考资料：
1. [在Windows上高效使用LAMMPS](https://leo-lyy.github.io/docs/WSL_LAMMPS_GPU.html)
1. [Win10+WSL2+Ubuntu22.04安装Lammps+GPU+Python](https://blog.csdn.net/apathiccccc/article/details/131538775)
1. [WSL2下gpu版lammps编译详细版](http://bbs.keinsci.com/thread-27603-1-1.html)
1. [从lib/gpu和src用make安装:lammps安装kokkos MPI实现GPU计算](https://blog.csdn.net/m0_55063425/article/details/136556312)
1. [在linux mint21.3上安装含kokkos以及deepmd的lammps & 4090的reaxff测试](http://bbs.keinsci.com/thread-46630-1-1.html)
1. [lammps gpu版编译（kokkos+cuda）](https://zhuanlan.zhihu.com/p/603892794)


###### WSL2迁移硬盘
1. WSL Ubuntu22.04 LTS作为Windows App默认被安装到了C盘，几十G，因此考虑转移到D盘。
1. `wsl -l -v`查看wsl虚拟机的名称与状态。了解到本机的WSL全称为Ubuntu-22.04，以下的操作都将围绕这个来进行。
1. `wsl --shutdown`使其停止运行，再次使用`wsl -l -v`确保其处于stopped状态。
1. 在D盘创建一个目录用来存放新的WSL，比如我创建了一个 D:\Ubuntu_WSL 。
1. 导出它的备份（比如命名为Ubuntu.tar):`wsl --export Ubuntu-22.04 D:\Ubuntu_WSL\Ubuntu.tar`
1. 确定在此目录下可以看见备份Ubuntu.tar文件之后，注销原有的wsl:`wsl --unregister Ubuntu-22.04`
1. 将备份文件恢复到D:\Ubuntu_WSL中去:`wsl --import Ubuntu-22.04 D:\Ubuntu_WSL D:\Ubuntu_WSL\Ubuntu.tar`
1. 这时候启动WSL，发现好像已经恢复正常了，但是用户变成了root，之前使用过的文件也看不见了。root下可以查看用户组，看看哪个是你原来的用户。简单的指令比如：`ls /home`
1. 在CMD中，输入 Linux发行版名称 config --default-user 原本用户名，例如：`Ubuntu2204 config --default-user xilock`。请注意，这里的发行版名称的版本号是纯数字，比如Ubuntu-22.04就是Ubuntu2204。这时候再次打开WSL，你会发现一切都恢复正常了。

参考资料：
1. [轻松搬迁！教你如何将WSL从C盘迁移到其他盘区，释放存储空间！](https://zhuanlan.zhihu.com/p/621873601)
1. [WSL存储位置迁移：从C盘到D盘的完整指南](https://comate.baidu.com/zh/page/o5wpl3ardhl)



![](/img/wc-tail.GIF)
