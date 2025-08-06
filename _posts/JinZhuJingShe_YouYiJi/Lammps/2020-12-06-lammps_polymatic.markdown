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

模拟聚合物单体交联的perl脚本, 基于LAMPPS的实现, 没法直接用于GROMACS，Jerkwin老师的[《分子模拟周刊：第 18 期》](https://jerkwin.github.io/2020/05/09/%E5%88%86%E5%AD%90%E6%A8%A1%E6%8B%9F%E5%91%A8%E5%88%8A-%E7%AC%AC_18_%E6%9C%9F/)有介绍

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
###### type文件
1. type文件的格式和内容在manual和example里都有，但是要如何获取是一个问题。注意用msi2lmp生成data文件时不要加`-o`，否则不会输出原子类型、成键类型等type。之前xilock尝试过msi2lmp时加`-o`然后用topotool重命名原子名称和类型的方式，但发现retype之后成键类型的编号变了，跟原来不一致，没法直接调用原来的coeffs，很是蛋疼！当时最后还是手撕type文件。所以记住不要乱加`-o`
1. 因为生成新的成键需要在原有成键基础上定义新的成键、角度、二面角等，如果二面角参数太多但不重要，在pl文件里将二面角相关部分注释掉来临时通过以便测试。

### 问题
###### Can't located XML/Simple.pm in @INC...
把XML目录拷贝到家目录下的perl5/lib/perl5下就行了？（实测是拷到提示的路径，比如将XML拷贝到上面`use lib`指向的路径里）。


1. [perl5.rar](https://github.com/molakirlee/Blog_Attachment_A/blob/main/lammps/perl5.rar)

### 参考资料
1. [http://www2.matse.psu.edu/colinagroup/research/polymatic.shtml](http://www2.matse.psu.edu/colinagroup/research/polymatic.shtml)
1. [https://nanohub.org/resources/17278/](https://nanohub.org/resources/17278/)


![](/img/wc-tail.GIF)
