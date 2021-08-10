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
###### 解压缩
把Gaussian压缩包解压到/public3/home/sc55652/Desktop/G16_install/目录下

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


### 参考资料
1. [Gaussian的安装方法及运行时的相关问题](http://sobereva.com/439)

![](/img/wc-tail.GIF)
