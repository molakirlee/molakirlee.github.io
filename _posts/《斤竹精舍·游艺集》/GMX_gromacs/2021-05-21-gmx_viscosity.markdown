---
layout:     post
title:      "gmx 粘度viscosity"
subtitle:   ""
date:       2021-05-21 08:51:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2021

---

### 粘度
GROMACS可以计算体系的粘度（本体粘度和剪切粘度），计算粘度的方法有很多种，在Gromacs中就提供了三种，分别是
1. Green-Kubo/EINSTEIN RELATION：利用压力的XY、XZ、YZ计算粘度，gmx中无直接命令，需自己编程.
1. 横流自相关函数（TACF）方法：比Green-Kubo**并无优势**，用起来不方便.
1. 周期扰动法(一种NEMD）:gromacs支持的独特方法，模拟过程中对体系粒子施加外力，计算速度快.

周期扰动法属于NEMD，因为粘度 本身是反映流体流动阻力的量，所以给体系一个扰动，然后测体系的流动性质，就能反映出体系的粘度来，比如说给体系一个水平方向上的力，体系形成一个层流，然后测层间的速度梯度，那么力与速度梯度的比值就是剪切粘度.



另外粘度还分很多种：
1. Dynamic viscosity (or absolute viscosity) determines the dynamics of an incompressible Newtonian fluid;
1. Kinematic viscosity is the dynamic viscosity divided by the density for a Newtonian fluid;
1. Volume viscosity (or bulk viscosity) determines the dynamics of a compressible Newtonian fluid;
1. Shear viscosity is the viscosity coefficient when the applied stress is a shear stress (valid for non-Newtonian fluids);
1. Extensional viscosity is the viscosity coefficient when the applied stress is an extensional stress (valid for non-Newtonian fluids).

### gmx中的周期扰动法
在mdp中添加`cos-acceleration=g`，其中g代表不同z位置的粒子在x方向施加不同的加速度g（nm/ps2）,一般用0.05.将`nstenergy=100`，通常用扰动法模拟200ps足够得到统计误差较小的粘度值.使用`gmx energy -f vis.edr`，选1/viscosity，将结果取倒数得到粘度.

注意：
1. 一般来说，施加的加速度越小，计算得到的粘度越大.
1. 粘度越低，粘度受加速度影响越小，但总是需要外推得到零加速度下的粘度.
1. 对于大部分流体，可以计算0.01-0.04 nm/ps**2 加速度下的粘度，然后外推到零加速度.
1. 不要盲目追求和实验越近，影响误差的因素太多，明显不光是这个参数的事.对于考虑参数的选取问题，应当看的是什么数值和理论的极限值基本相符.原理上cos-acceleration越小越好，但需要越长时间的模拟.
1. mdp参数设置、力场参数、用的模型，都可能显著影响粘度的结果，本来粘度就对参数很敏感.要和文献对比应当把这些条件尽量弄相同.


### 参考资料
1. [使用GROMACS计算粘度](https://jerkwin.github.io/2018/03/08/%E4%BD%BF%E7%94%A8GROMACS%E8%AE%A1%E7%AE%97%E7%B2%98%E5%BA%A6/)
1. [【在线答疑】关于GROMACS](http://muchong.com/html/200812/1082439_2.html)
1. [[NAMD] 有大神知道如何在NAMD里计算溶液的粘度吗？](http://bbs.keinsci.com/thread-16557-1-1.html)
1. [[GROMACS] 求助模拟异丁烷的粘度误差很大](http://bbs.keinsci.com/thread-21724-1-1.html)


![](/img/wc-tail.GIF)
