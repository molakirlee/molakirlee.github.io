---
layout:     post
title:      "gmx 电场"
subtitle:   ""
date:       2020-11-27 23:35:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2020

---
### 电场
###### 恒定电场
对于最基础的长方体模拟盒子，在某一个方向上（x或y或z）施加一个恒定强度的电场，只需要在mdp文件中添加下面一行：

```
E-z  =  1  1.8  0
```
 其中E-z表示在z方向上加电场；等号右边第一个数是余弦的数目，因为只实现了单个余弦项（频率为0），因此为1，不能写成1.0；第二个数为电场大小和方向，单位为V/nm，正数表示从z=0到z=max，负数则相反。

###### 余弦电场

###### 高斯脉冲电场

###### 方波
没法加方波


### 参考资料
1. [GROMACS电场的使用](https://jerkwin.github.io/2016/06/29/GROMACS%E7%94%B5%E5%9C%BA%E7%9A%84%E4%BD%BF%E7%94%A8/)
1. [加电场模拟](http://gainstrong.net/works/menhu/2018-06-25/109.html)
1. [gromacs加正弦交流电场或者方波电场问题](http://bbs.keinsci.com/thread-18476-1-1.html)
1. [gmx manual 5.1 : Electric fields](https://manual.gromacs.org/documentation/5.1/user-guide/mdp-options.html#electric-fields)
1. [gmx 2019 Reference manual: Electric fields](https://manual.gromacs.org/documentation/2019/reference-manual/special/electric-fields.html)

![](/img/wc-tail.GIF)
