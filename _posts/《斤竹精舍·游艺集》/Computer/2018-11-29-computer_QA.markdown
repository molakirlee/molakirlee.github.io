---
layout:     post
title:      "电脑技巧Q&A"
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

### 优盘启动
推荐一款相对干净的启动盘安装软件：[微PE](http://www.wepe.com.cn/)

### 两个系统去掉一个
在已经存在一个操作系统的基础上，你再次运行过XP系统的安装，导致XP系统进行了一些安装的前期准备，但是由于某种原因而中止了该新的安装，导致系统误认为有两个系统的引导，实际上是只有一个系统的可引导文件存在（因为同一版本的操作系统不可以在计算机中进行重复的安装）。这样，你需要做的操作其实只是删除系统启动菜单而已。 通过在开始－>运行中输入“notepad c:\boot.ini”后回车，系统使用记事本程序打开启动配置文件。 我的系统配置文件内容如下： [boot loader] timeout=5 default=multi(0)disk(0)rdisk(0)partition(1)\WINDOWS [operating systems] multi(0)disk(0)rdisk(0)partition(1)\WINDOWS="Microsoft Windows XP Professional" /noexecute=optin /fastdetect multi(0)disk(0)rdisk(0)partition(1)\WINDOWS="Microsoft Windows XP Professional" /noexecute=optin /fastdetect 在这里，multi(0)disk(0)rdisk(0)这一部分的内容应该是一致的（如果使用了多个磁盘控制器，且磁盘分别挂在不同的控制器上的话，这内容可能与我描述的不一致，这里不详细解释，如果确实是不同，下次补充），partition(？)表示在第几个分区，带双引号的文字将出现在启动列表中，你可以将[operating systems]下的不正确的一个启动菜单删除就可以了，然后进行保存。 如果保存时系统提示文件为只读，不可以改写时，你可以在“开始－>运行”中输入“del c:\boot.ini /f”后确认，然后再保存你修改的文件就可以

前面写的太罗嗦了,只要把不想要的系统所在磁盘的(如D盘)"windows"文件夹和Documents and Settings文件夹及相关的文件删掉,再修改启动文件,C盘上的boot.ini文件既可.打开记事本，选择“文件”菜单，单击“打开”，然后在文件名中写入C:\\boot.ini，打开它，可以看到： [boot loader] timeout=10 default=multi(0)disk(0)rdisk(0)partition(1)\\WINDOWS [operating systems] multi(0)disk(0)rdisk(0)partition(1)\\WINDOWS="Microsoft Windows 2000 Professional" /fastdetect multi(0)disk(0)rdisk(0)partition(2)\\WINNT="Microsoft Windows 2000 Professional" /fastdetect C:\\="Previous Operating System on C:"] 其中multi(0)disk(0)rdisk(0)partition(1)就是指的您第一块硬盘第一个分区“partition(1)”就代表第一个分区也就是您的c盘，partition“partition(2)”就代表第二个分区也就是d盘。参照这个文件，找到删除“partition(1)”或“partition(2)”即可使问题得到解决。*就算把D盘格掉,也还是要修改boot.ini文件.

### "无法定位现有分区，也无法创建新的系统分区"
格式化U盘后用iso安装win7时总是出现提示“安装程序无法定位现有分区，也无法创建新的系统分区”。  
1. 重装系统前将WIN7.iso里面的内容全部拷贝到电脑上的逻辑分区里（一般来说，逻辑分区是，除了C盘的其他盘符）里面就行。
1. 通过装机盘进入winPE系统。
1. 把WIN7安装文件的存放位置找到，将里面的这三个文件（夹）BOOT、BOOTMGR、SOURCES拷贝到电脑里面的C盘根目录下（注意，一定是拷贝到根目录下面）。
1. 然后进入PE的CMD窗口，输入以下命令：“C:\boot\bootsect.exe /nt60 C:”（注意，exe和/nt60和C:这三个之间都有一个空格分开的）。然后回车，这时会出现successful字样提示（有可能画面很快闪过，来不及看；也有可能直接在CMD窗口里面的最后提示successful字样）。
1. 我们的第一步安装算是完成了。重启电脑，拔出U盘，**从硬盘启动（不用奇怪，就是从硬盘启动）**，然后出现在WIN7安装导入文件的“白道”，屏幕最下面；然后出现在WIN7的安装欢迎界面，选择地域、语言、键盘，点击”下一步“，‘选择分区（注意了，一定不能再格盘了，要不然又要重复第5步了），选择C分区，点击”下一步“（这时，不会出现提示”安装程序无法定位现有分区，也无法创建新的系统分区……“），安装OK。
1. 系统自动安装，收集信息，复制文件，安装功能，完成设置。然后机器会重启这时会出现两个启动选择，有一个是Windowns设置启动，那我们如何把这个删除呢。进入系统，以管理员身份进入CMD运行DOS窗口，输入msconfig打开展系统配置对话框，选择[引导]标签，在这里你可设置系统选择等待时间，默认的是30秒，你可自行设置；你也可以看到启动时出现的两上启动选择，你可以把Windowns启动设置删除掉，确定退出，就OK了，删除操作请谨慎选择。
1. 现在再装上自己的驱动和其他一些应用软件，杀毒软件，WIN7系统安装就完全OK了。


### win7系统插4g+8g内存条显示12g(8g可用)
先检查系统版本，对于win7-64bt(upper RAM limits):
Starter : 2GB  
Home Basic : 8GB  
Home Premium : 16GB  
Professional: 192GB  
Enterprise : 192GB  
Ultimate : 192GB  
然后检查bios里的info看主板是否读出了内存，之后再考虑网上疯传的“msconfig里的最大内存”。

### windows系统下cmd中文乱码
1. win键+R，输入"regedit.
1. 按顺序找到"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor按顺序找到HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor按顺序找到HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor".
1. 新建"多字符串值"，命名为"autorun".
1. 内容分两行填入"set LANG=zh_CN.UTF-8" "set LC_ALL=zh_CN.utf8" .
1. 保存后重启.

参考：
1. [windows系统修改cmd窗口utf-8编码格式](https://jingyan.baidu.com/article/d7130635e8a38413fdf4753b.html) 
1. [win10 CMD ls 命令显示乱码](https://www.rxx0.com/motion/win10-cmd-ls-ming-ling-xian-shi-luan-ma.html) 

### 缺少xxx
###### 缺少MSVCP110.DLL
1. 安装Visual C++库：msvcp110.dll是一个c++的库，所以可以在http://www.microsoft.com/zh-CN/download/details.aspx?id=30679上下载跟系统对应的c++库进行安装； 
1. DirectX Repair：用“DirectX修复工具OL”进行修复；

参考:  
1. [Xshell打开报错缺少各种.dll文件(MSVCP110.DLL)以及报错0xc000007b万能解决方法](https://blog.csdn.net/code_love_yilian/article/details/107643504)
1. [windows下使用Xshell时出现丢失msvcr110.dll等dll](https://blog.csdn.net/Franck_Lou/article/details/78438268)

###### 缺少api-ms-win-crt-runtime-l1-1-0.dll
下载[系统丢失api-ms-win-crt-runtime-l1-1-0.dll的修复工具](http://www.51rgb.cn/download/page-64.html)并安装运行。  
参考：  
1. [PS提示丢失api-ms-win-crt-runtime-l1-1-0.dll 完美解决方法](https://zhuanlan.zhihu.com/p/34167899)

### C盘爆满
昨天C盘还有20G+，今天发现就剩10M了？？？检查了一下也没发现什么文件，偶然遇到了“软媒魔方”（感觉很是良心！见参考资料。），竟然给我找出问题来了！是虚拟内存！C盘下的pagefile.sys文件直接给干掉了20G。后来xilock就将虚拟内存配置到D盘了，具体操作见参考资料。  
参考：  
1. [C盘满了不用怕—简单几步，释放海量C盘空间！](https://post.smzdm.com/p/a6l89k20/)
1. [pagefile.sys是什么文件？pagefile.sys文件太大如何移动到D盘中？](http://www.lotpc.com/dnzs/7059_2.html)
1. [电脑已满的c盘该怎么清理无用的文件?](https://www.jb51.net/diannaojichu/691109.html)
1. [秘技：C盘满了怎么办？](https://zhuanlan.zhihu.com/p/62030272)


![](/img/wc-tail.GIF)
