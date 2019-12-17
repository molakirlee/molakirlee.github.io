---
layout:     post
title:      "电脑技巧"
subtitle:   ""
date:       2018-11-29 08:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - CS
    - 2018

---

### 重装系统
1. [技术贴----系统安装篇](https://liuyujie714.com/43.html#more)  


### 两个系统去掉一个
在已经存在一个操作系统的基础上，你再次运行过XP系统的安装，导致XP系统进行了一些安装的前期准备，但是由于某种原因而中止了该新的安装，导致系统误认为有两个系统的引导，实际上是只有一个系统的可引导文件存在（因为同一版本的操作系统不可以在计算机中进行重复的安装）。这样，你需要做的操作其实只是删除系统启动菜单而已。 通过在开始－>运行中输入“notepad c:\boot.ini”后回车，系统使用记事本程序打开启动配置文件。 我的系统配置文件内容如下： [boot loader] timeout=5 default=multi(0)disk(0)rdisk(0)partition(1)\WINDOWS [operating systems] multi(0)disk(0)rdisk(0)partition(1)\WINDOWS="Microsoft Windows XP Professional" /noexecute=optin /fastdetect multi(0)disk(0)rdisk(0)partition(1)\WINDOWS="Microsoft Windows XP Professional" /noexecute=optin /fastdetect 在这里，multi(0)disk(0)rdisk(0)这一部分的内容应该是一致的（如果使用了多个磁盘控制器，且磁盘分别挂在不同的控制器上的话，这内容可能与我描述的不一致，这里不详细解释，如果确实是不同，下次补充），partition(？)表示在第几个分区，带双引号的文字将出现在启动列表中，你可以将[operating systems]下的不正确的一个启动菜单删除就可以了，然后进行保存。 如果保存时系统提示文件为只读，不可以改写时，你可以在“开始－>运行”中输入“del c:\boot.ini /f”后确认，然后再保存你修改的文件就可以

前面写的太罗嗦了,只要把不想要的系统所在磁盘的(如D盘)"windows"文件夹和Documents and Settings文件夹及相关的文件删掉,再修改启动文件,C盘上的boot.ini文件既可.打开记事本，选择“文件”菜单，单击“打开”，然后在文件名中写入C:\\boot.ini，打开它，可以看到： [boot loader] timeout=10 default=multi(0)disk(0)rdisk(0)partition(1)\\WINDOWS [operating systems] multi(0)disk(0)rdisk(0)partition(1)\\WINDOWS="Microsoft Windows 2000 Professional" /fastdetect multi(0)disk(0)rdisk(0)partition(2)\\WINNT="Microsoft Windows 2000 Professional" /fastdetect C:\\="Previous Operating System on C:"] 其中multi(0)disk(0)rdisk(0)partition(1)就是指的您第一块硬盘第一个分区“partition(1)”就代表第一个分区也就是您的c盘，partition“partition(2)”就代表第二个分区也就是d盘。参照这个文件，找到删除“partition(1)”或“partition(2)”即可使问题得到解决。*就算把D盘格掉,也还是要修改boot.ini文件.


![](/img/wc-tail.GIF)
