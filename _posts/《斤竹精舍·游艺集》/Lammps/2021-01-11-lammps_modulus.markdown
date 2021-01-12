---
layout:     post
title:      "LAMMPS 模量"
subtitle:   ""
date:       2021-01-11 07:12:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2021

---

### 概念
###### 应变

###### 应力

###### 弹性模量 Elastic modulus
1. 杨氏模量E(Young's modulus,又称拉伸模量,tensile modulus)：衡量一个各项同性弹性体的刚度（stiffness），定义为在胡克定律适用的范围内，单轴应力(tensile stress)和单轴形变(tensile strain)之间的比。
1. 体积模量K(bulk modulus)
1. 剪切模量G(shear modulus)

E=2G(1+v)=3K(1-2v)

### 问题
1. `"ERROR: Cannot change box tilt factors for orthogonal box > (../change_box.cpp:249)"`：对于方盒子没有设置格子的倾斜角度导致的（tilt factor），脚本想在xy、yz和xz方向改变盒子时不知道该咋办的，解决方案为在盒子尺寸后面添加一行`.0 0.0 0.0 xy xz yz`，具体见参考资料。（或者通过将晶胞转为立方晶胞，解决方法也见参考资料。）


### 参考资料
1. [怎么在分子动力学模拟中计算弹性常数](https://zhuanlan.zhihu.com/p/99009439)
1. [lammps:8.3.4. Calculate elastic constants](https://lammps.sandia.gov/doc/Howto_elastic.html)
1. [Re: [lammps-users] Elastic constants error, Mg hcp structure](https://lammps.sandia.gov/threads/msg55753.html#opennewwindow)
1. [如何从六角晶胞构建立方晶胞](http://www.52souji.net/how-to-convert-hexagonal-cell-to-cubic-cell.html)

![](/img/wc-tail.GIF)
