---
layout:     post
title:      "Shell 脚本等待上一行执行完成再执行下一行的方法"
subtitle:   ""
date:       2020-05-11 09:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Linux
    - 2020

---
  
有时候想要先后执行几个命令，并希望前一个命令执行完再执行下一个命令。但有时候后一命令会不等前一命令执行完就开始。  
tiwoo提供了一个tricky可以解决这个问题：

例如：假设现有3个命令，命令1执行瞬间完成而命令2耗时较长，希望等命令2执行完再执行命令3.  
Shell 默认提供了获取命令执行输出的方法，即用 ` 号将需要获取输出的操作括起来，并赋值给一个变量，则 Shell 会在等待命令执行完成后把输出内容用于赋值，所以，这就是实现了我们需要的等待效果，并且时间精准性很高。

```
#!/bin/sh
command 1
output=`command 2`
command 3
```



![](/img/wc-tail.GIF)
