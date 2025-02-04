---
layout:     post
title:      "便携软件下载及自制 Portable Software"
subtitle:   ""
date:       2018-12-02 15:00:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - CS
    - 2018

---

### 下载
1. [难道直接安装软件不香么?我为什么还在用 portable apps绿色便携软件](https://zhuanlan.zhihu.com/p/158241303)
1. [https://portableappk.com/](https://portableappk.com/)


### 自制

#### 原理

先来了解一些绿色软件的工作原理：[链接](https://www.jianshu.com/p/1fcd663319a8)  

#### 方法
###### 软件下载
下载安装**Total Uninstall**软件: https://pan.baidu.com/s/1kVCG2az 密码: 3fbb，安装完成后，把CK文件夹里的程序复制粘贴覆盖你安装程序的文件夹里的主文件。
###### 分析已安装程序
我们打开刚安装好的Total Uninstall软件，软件自动分析你电脑已经安装的所有程序。软件是自动分析的，不需要操作，等待分析完成就可以了。时间大概不到一分钟，电脑配置好的几秒钟就OK 了。
###### 分析待绿化程序
点击程序窗口左面待绿化的程序，点击后Total Uninstall自动分析软件的安装信息，包括注册表信息，分析完成后再右面显示。有绿色加号的是该软件的信息，此外还有注册表项。
###### 导出注册表
下面开始真正的绿化过程。我们点程序窗口的,文件--导出--注册表修改，**选择“全部”然后点确定**。然后点保存，保存注册表文件到某个文件夹备用。
###### 导出文件
导出文件项。我们返回程序窗口，在右面找到已经分析好的程序项，一般有几处，我们找到**主程序所在的文件夹**，在文件夹上点鼠标右键，弹出窗口点复制，然后粘贴到你之前保存注册表文件的文件夹里面。我们打开刚刚复制的文件夹，我们所要绿化的文件都在里面了。
###### 测试运行
测试运行。我们打开刚刚复制的文件夹里面的主程序，看看能不能运行，运行前要先把之前绿化的程序卸载，可以用程序自带的卸载程序卸载，也可以用Total Uninstall卸载，用Total Uninstall卸载会自动创建程序备份，如果我们绿化不完全，可以用Total Uninstall对程序进行恢复。很方便。我们已经看到绿化后的程序完美运行，到此我们的绿化工作基本结束。
###### 其他
如果软件有注册信息，我们可以把之前导出的注册表文件重新导入注册表，重启电脑就可以了。  
参考：[链接](https://jingyan.baidu.com/article/1709ad807819a14635c4f043.html)  

![](/img/wc-tail.GIF)
