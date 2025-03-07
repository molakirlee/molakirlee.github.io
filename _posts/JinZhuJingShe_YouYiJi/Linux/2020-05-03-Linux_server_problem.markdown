---
layout:     post
title:      "服务器使用过程中遇到的问题"
subtitle:   "发现自己总忘，就整理了一下贴在这里了"
date:       2020-05-03 10:30:00
author:     "XiLock"
header-img: "img/in-post/2018-10-26-git-notes/post-bg-rwd.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Linux
    - 2020


---

### 天大曙光Linux Redhat 7
###### ECC error

常见ECC错误：

```
step 9782000, will finish Fri May 15 05:58:54 2020vol 0.59  imb F  7% pme/F 1.58 
Message from syslogd@node8 at May 13 18:01:09 ...
 kernel:[Hardware Error]: MC4 Error (node 2): L3 data cache ECC error.

Message from syslogd@node8 at May 13 18:01:09 ...
 kernel:[Hardware Error]: Error Status: Corrected error, no action required.

Message from syslogd@node8 at May 13 18:01:09 ...
 kernel:[Hardware Error]: CPU:16 (15:2:0) MC4_STATUS[-|CE|MiscV|-|AddrV|-|Poison|CECC]: 0x9c0a4d20011c010b

Message from syslogd@node8 at May 13 18:01:09 ...
 kernel:[Hardware Error]: MC4_ADDR: 0x0000000000011244

Message from syslogd@node8 at May 13 18:01:09 ...
 kernel:[Hardware Error]: cache level: L3/GEN, tx: GEN, mem-tx: GEN
step 12514300, will finish Fri May 15 03:15:10 2020^Cl 0.61  imb F  6% pme/F 1.55 
```

这个错误就是ECC校验错误，但提示“no action required”，意思是校验的时候有可能是校验没过去，卡了一下，然后它自己修复了这事可修复的ECC校验错误。
这个是老的redhat7的操作系统的一个也不能说bug吧，就是他有时候他会和那个内存混剪。参考曙光工程师统计，包括问了产品什么的，一般1000次左右的这种校验报错才会是ECC颗粒有问题。


![](/img/wc-tail.GIF)