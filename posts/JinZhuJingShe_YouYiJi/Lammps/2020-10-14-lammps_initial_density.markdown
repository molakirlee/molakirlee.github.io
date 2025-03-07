---
layout:     post
title:      "LAMMPS初始化密度"
subtitle:   ""
date:       2020-10-14 08:52:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

`fix deform`command是用来改变体系形状从而模拟非平衡动力学的，它可以通过多种方法产生非平衡行为。但也可以用它来设置体系的密度（数密度）命令格式如下：
```
fix 1 all deform 1000 x final -50.0 50.0 y final -50.0 50.0 z final -50.0 50.0 units box
```

1. 改变系统的体积就可以改变系统的密度，使用final style对于精确设定系统体积很有帮助；
1. 建模时把边界设置好，把初始的体系密度放的很 大，然后利用这个命令通过几步改变到自己所要的密度上，而不是再read.data中来改变边界值（这样对于跨边界的bond是会出错的）。这个对于需要通过改变密度来模拟不同体系非常方便，不用自己多次做初始话数据。
1. 在使用时，命名改变的长度单位一定要加上，最好不要默认，否则也可能出错。
1. 最好在开始使用此命令来设定密度，因为改变密度后还有个趋平过程，如果中间改变的话，以前的模拟步数都要舍弃，这样会增加模拟的时间。
1. 这个命令可能会使系统产生宏观速度，所以使用后最好用[velocity command](https://lammps.sandia.gov/doc/velocity.html)重新初始化速度，并令linear = zero the linear momentum。

### 参考：
1. [LAMMPS命令解读系列--fix deform command的另一个用处](https://zhuanlan.zhihu.com/p/24273784)
1. [fix deform command](https://lammps.sandia.gov/doc/fix_deform.html)


![](/img/wc-tail.GIF)
