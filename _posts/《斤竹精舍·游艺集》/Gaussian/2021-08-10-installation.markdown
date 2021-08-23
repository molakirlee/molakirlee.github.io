---
layout:     post
title:      "Gaussian 安装"
subtitle:   ""
date:       2021-08-10 17:24:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Gaussian
    - 2021

---

### 安装

###### Gaussian版本
先查看指令集：
```
cat /proc/cpuinfo
```
1. 如果包含有avx2字眼，建议您使用支持AVX2指令集的Gaussian版本；
1. 如果包含有avx字眼（无论有无sse4_2或sse4a字眼），建议您使用AVX指令集的Gaussian版本。
1. 如果包含有sse4_2或sse4a字眼而没有avx字眼，建议您SSE4.2指令集的Gaussian版本；
1. 如果您的集群既有Legacy又有AVX等机器，为了避免出错，建议您用Legacy版本。
1. 如果什么都不出现或仅有空白行，则您的机器不能支持SSE4.2或AVX指令集，需要使用Legacy版本进行安装；


###### 解压缩
把Gaussian压缩包解压到/public3/home/sc55652/Desktop/G16_install/目录下



不同格式解压缩文件解压方式
```
tar -Jvxf foo.tbj
tar -jxf foo.tbz
tar -zvxf foo.tgz
```

###### 创建临时文件夹
建立一个文件夹用于储存Gaussian运行过程中产生的临时文件，位置随意。比如：/public3/home/sc55652/Desktop/G16_install/g16/scratch。

###### 添加环境变量
```
# Gaussian 16
export g16root=/public3/home/sc55652/Desktop/G16_install
export GAUSS_SCRDIR=/public3/home/sc55652/Desktop/G16_install/g16/scratch
source /public3/home/sc55652/Desktop/G16_install/g16/bsd/g16.profile
```

`source ~/.bashrc`使环境变量生效

###### 设置计算核数和内存
Gaussian目录下的Default.Route用来设定默认用的计算资源（如果没有此文件就新建一个），-M-设置默认用的最大内存量（一般用MB或GB为单位），-P-设置默认用多少CPU核数来并行计算。比如我们想默认用36个核心、最大60GB内存做计算，就在/home/sob/g09/Default.Route里面写入以下内容
```
-M- 60GB
-P- 36
```
此文件中的设置优先级低于输入文件里的%mem和%nproc设置。

###### 修改权限
切换到`/public3/home/sc55652/Desktop/G16_install/g16/`目录，运行`chmod 750 -R *`命令，对当前目录下所有文件和所有子目录下的文件都设置权限。

### 问题
###### Error: illegal instruction , illegal opcode
这说明Gaussian和你的CPU不兼容，确切来说，是你的CPU太老，不支持Gaussian在开发者编译程序的时候使用的指令集。换Gaussian版本吧。

### 参考资料
1. [Gaussian的安装方法及运行时的相关问题](http://sobereva.com/439)
1. [Gaussian教程 | Gaussian16的安装](http://blog.molcalx.com.cn/2017/04/12/gaussian16-installation.html)
1. [Linux查看CPU支持的指令集](https://blog.csdn.net/qq_41565459/article/details/82991691)



![](/img/wc-tail.GIF)
