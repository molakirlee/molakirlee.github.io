---
layout:     post
title:      "MS 安装及使用问题"
subtitle:   ""
date:       2019-12-25 18:04:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - MS
    - 2018

---

### 下载地址

[Materials Studio 2017破解版 (附安装教程)](http://www.ddooo.com/softdown/93763.htm#dltab)    
有的电脑可能安装完某些模块不能运行，经测试有些win7不行，有的win8可以（再次测试后发现可能是因为处理器太旧或者太low不支持）。  

###### Cannot find licensing library: ls_license_vs2008.dll 
1. 问题描述：安装完打开时提示“Cannot find licensing library: ls_license_vs2008.dll  This Materials Studio product requires this licensing library to run.  This application cannot be run without it.”
1. 问题解答：修复一下
1. 参考资料：[出现Cannot find licensing library: ls_license_vs2008.dll问题的一种解决办法](http://bbs.keinsci.com/thread-10357-1-1.html)

###### Materials Studio无法选择原子和旋转图形
1. 问题描述：
1. 问题解答：tools-> options -> Graphics -> Disable hardware acceleration，勾选上Disable hardware acceleration就正常了。
1. 参考资料：[Materials Studio无法选择原子和旋转图形](http://muchong.com/html/201004/1932432.html)

###### materials studio，win10 一使用键盘就会卡死
1. 问题描述：进入软件后，画个结构都能卡死，但你关软件的时候发现很快出现让你保存的那个窗口，即实际没有卡死，但就是动不了。
1. 问题解答：在微软拼音输入法的“中”(或“英”)字上右击鼠标，然后点“设置”，在弹出界面中点“常规”，在新界面中向下滚动到底部，有个兼容性，打开兼容性，然后就OK了。
1. 参考资料：

###### CASTEP报错求助：forrtl：severe（168）：Program Exception - illegal instruction...
1. 问题描述：Xilock的小心pro14安装MS2017后，使用AC等都正常，使用CASTEP报错`forrtl：severe（168）：Program Exception - illegal instruction...`和`Routine Unknown`。  
1. 问题解答：sob说大概率没有解决办法，所以用AMD CPU破事多，买机子不能光想着性价比。也有人说换2019之后解决了。
1. 参考资料：[CASTEP报错求助：forrtl：severe（168）：Program Exception - illegal instruc...](http://bbs.keinsci.com/thread-19052-1-1.html#opennewwindow)

![](/img/wc-tail.GIF)
