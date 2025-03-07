---
layout:     post
title:      "后台运行:nohup &或screen等"
subtitle:   ""
date:       2019-12-05 20:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Linux
    - 2019

---
  
### nohup &
nohup命令：如果你正在运行一个进程，而且你觉得在退出帐户时该进程还不会结束，那么可以使用nohup命令。该命令可以在你退出帐户/关闭终端之后继续运行相应的进程。nohup就是不挂断的意思( no hang up)。该命令的一般形式为：
```
nohup command &
```
如果使用nohup命令提交作业，那么在缺省情况下该作业的所有输出都被重定向到一个名为nohup.out的文件中，除非另外指定了输出文件：
```
nohup command > myout.file 2>&1 &
```
在上面的例子中:
1. 0 – stdin (standard input)；
1. 1 – stdout (standard output)；
1. 2 – stderr (standard error) ；
1. 2>&1是将标准错误（2）重定向到标准输出（&1），标准输出（&1）再被重定向输入到myout.file文件中。
 

### tail

tail -f      等同于--follow=descriptor，根据文件描述符进行追踪，当文件改名或被删除，追踪停止。  
tail -F     等同于--follow=name  --retry，根据文件名进行追踪，并保持重试，即该文件被删除或改名后，如果再次创建相同的文件名，会继续追踪。  

tailf        等同于tail -f -n 10（貌似tail -f或-F默认也是打印最后10行，然后追踪文件），与tail -f不同的是，如果文件不增长，它不会去访问磁盘文件，所以tailf特别适合那些便携机上跟踪日志文件，因为它减少了磁盘访问，可以省电。  



然后使用：
```
nohup command > myout.file 2>&1 &  
 tailf myout.file
```

### screen
screen命令更好用一些，但是需要额外安装。  
常用的screen命令：  
1. 创建session: `screen -S xilock_1`
1. 列出当前所有的session： `screen -ls`
1. 回到yourname这个session： `screen -r yourname`
1. detach当前session：ctrl + a + d
1. 强行关闭当前的 window: `screen -X -S yourname quit`


![](/img/wc-tail.GIF)
