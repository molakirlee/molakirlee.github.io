---
layout:     post
title:      "LAMMPS polymatic"
subtitle:   ""
date:       2020-12-06 17:12:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### Polymatic 的安装
polymatic基于perl语言，因为Linux自带perl语言，所以直接从网站上下载下来就能用。需要注意的是要加上`Polymatic.pm`的路径，通过polym.pl等文件里的`use lib`指令：

```
use lib '/path/to/polymatic/module';
```
改为

```
use lib '/THFS/home/huse_fx/Desktop/polymatic_v1.1';
```

### 使用
参见Manual

### 问题
###### Can't located XML/Simple.pm in @INC...
把XML目录拷贝到家目录下的perl5/lib/perl5下就行了？（实测是拷到提示的路径，比如将XML拷贝到上面`use lib`指向的路径里）。

1. [perl5.rar](https://molakirlee.github.io/attachment/lammps/perl5.rar)

### 参考资料
1. [http://www2.matse.psu.edu/colinagroup/research/polymatic.shtml](http://www2.matse.psu.edu/colinagroup/research/polymatic.shtml)
1. [https://nanohub.org/resources/17278/](https://nanohub.org/resources/17278/)


![](/img/wc-tail.GIF)
