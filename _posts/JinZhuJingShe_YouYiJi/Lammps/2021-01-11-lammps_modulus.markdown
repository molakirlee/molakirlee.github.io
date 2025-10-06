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

###### 储能模量与损耗模量
1. 储能模量：实质为杨氏模量，表述材料存储弹性变形能量的能力。储能模量表征的是材料变形后回弹的指标。
1. 耗能模量：是模量中应力与变形异步的组元；表征材料耗散变形能量的能力, 体现了材料的粘性本质。

###### 切线模量和截面模量
1. 切线模量(Tangent Modulus): 塑性阶段屈服极限和强度极限之间的曲线斜率。是应力应变曲线上应力对应变的一阶导数。其大小与应力水平有关，并非一定值。切线模量一般用于增量有限元计算。切线模量和屈服应力的单位都是N/m2
1. 截面模量：是构件截面的一个力学特性。是表示构件截面抵抗某种变形能力的指标，如抗弯截面模量、抗扭截面模量等。它只与截面的形状及中和轴的位置有关，而与材料本身的性质无关。在有些书上，截面模量又称为截面系数或截面抵抗矩等。

###### [强度·硬度·刚度](https://zhuanlan.zhihu.com/p/265090501)
1. 强度 （Strength）：按外力作用的性质不同，强度主要有屈服强度、抗拉强度、抗压强度、抗弯强度等，工程常用的是屈服强度和抗拉强度，这两个强度指标可通过拉伸试验测出，其单位为Pa。常用的强度性能指标有拉伸强度和屈服强度（或屈服点）。铸铁、无机材料没有屈服现象，故只用拉伸强度来衡量其强度性能。高分子材料也采用拉伸强度。承受弯曲载荷、压缩载荷或扭转载荷时则应分别以材料的弯曲强度、压缩强度及剪切强度来表示材料的强度性能。抗压、抗拉、抗剪强度的计算式为：σ=F/A。其中：σ = 材料强度，Pa或者N/m2；F = 材料破坏时的最大荷载，N；A = 试件的受力面积，m2。
1. 硬度：指“固体材料抗拒永久形变的特性”。材料局部抵抗硬物压入其表面的能力称为硬度。固体对外界物体入侵的局部抵抗能力，是比较各种材料软硬的指标。一般硬度越高，耐磨性越好。由于规定了不同的测试方法，所以有不同的硬度标准。
1. 刚度：指零件在载荷作用下抵抗弹性变形的能力。零件的刚度（或称刚性）常用单位变形所需的力或力矩来表示，刚度的大小取决于零件的几何形状和材料种类（即材料的弹性模量）。刚度要求对于某些弹性变形量超过一定数值后，会影响机器工作质量的零件尤为重要，如机床的主轴、导轨、丝杠等。

### lammps的模量计算
1. [杨氏模量](https://molakirlee.github.io/2021/01/08/lammps_strain_stress/)
1. [体积/剪切模量](https://molakirlee.github.io/2021/01/08/lammps_elastic/)

### 问题
1. `"ERROR: Cannot change box tilt factors for orthogonal box > (../change_box.cpp:249)"`：对于方盒子没有设置格子的倾斜角度导致的（tilt factor），脚本想在xy、yz和xz方向改变盒子时不知道该咋办的，解决方案为在盒子尺寸后面添加一行`.0 0.0 0.0 xy xz yz`，具体见参考资料。（或者通过将晶胞转为立方晶胞，解决方法也见参考资料。）


### 参考资料
1. [怎么在分子动力学模拟中计算弹性常数](https://zhuanlan.zhihu.com/p/99009439)
1. [lammps:8.3.4. Calculate elastic constants](https://lammps.sandia.gov/doc/Howto_elastic.html)
1. [Re: [lammps-users] Elastic constants error, Mg hcp structure](https://lammps.sandia.gov/threads/msg55753.html#opennewwindow)
1. [如何从六角晶胞构建立方晶胞](http://www.52souji.net/how-to-convert-hexagonal-cell-to-cubic-cell.html)

![](/img/wc-tail.GIF)
