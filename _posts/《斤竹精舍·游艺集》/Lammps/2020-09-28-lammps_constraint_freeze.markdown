---
layout:     post
title:      "LAMMPS中约束"
subtitle:   ""
date:       2020-09-28 22:23:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### 刚性约束

### 运动约束
##### 力约束
通过改变**粒子的受力**来调整其运动状态：

###### fix addforce, fix aveforce
1. `fix addforce`命令是在编组中原子当前受力的基础上给每个原子额外添加一个力；
1. `fix aveforce`命令则是首先对编组中每个原子的受力进行平均处理，然后再给每个原子额外添加一个力，作用结果会使编组内的每个原子受力情况均相同；


###### fix lineforce, fix planeforce
1. `fix lineforce`命令将只保留沿给定方向的力分量
1. `fix planeforce`命令则只保留法向为给定方向的平面内的力分量

###### [fix setforce](https://lammps.sandia.gov/doc/fix_setforce.html)
使用`fix setforce` 可以实现对组的冻结（使用freeze也可以，但freeze必须用于设定有torque的体系）：

```
fix freeze fixedboundaries setforce 0.0 0.0 0.0
velocity fixedboundaries set 0.0 0.0 0.0
```

**注意**
1. 建议像上述那样同时对force和speed来impose zero；
1. 使用setforce只是对某group的此刻清零，后续有fix作用于该group时还是会对其进行累加，使得被setforce zero的group移动，故后面fix nvt的时候不应包括此setforce 0的group，见下一条；
1. 如果既不想更新原子的位置，也不想更新其速度，最简单的做法是不对相应的编组进行动力学积分，其结果是该组原子在整个模拟中相对于盒子保持零温绝对静止，但由于力场是存在的，所以这组原子仍会对其它原子产生力的作用。
1. 关于非冻结部分的速度初始化，速度初始化时，`fix 1 all momentum 1000 linear 1 1 1`与`velocity all zero linear`等效，都是为了eliminate drift due to non-zero total momentum，具体参见[fix momentum command](https://lammps.sandia.gov/doc/fix_momentum.html)


##### 位置/速度约束
通过重标粒子的位置或速度来改变其运动状态：

###### fix move, fix nve/noforce
1. `fix move`命令可以按特定的要求更新原子的位置和速度，使用该命令中的variable关键字，原则上可以实现对编组中每个原子的位置和速度进行独立的控制。需要注意，由于该命令直接参与粒子位置和速度的更新，所以不能与fix nve、fix nvt、fix npt等动力学积分相关的命令联用，否则设定的运动状态会被动力学积分破坏掉。
1. `fix nve/noforce`命令则只更新原子的位置，不更新速度（即速度不发生变化，相当于没有力的作用），这个命令适用于模拟恒速运动的墙，速度可由velocity命令进行指定，或由fix nve/noforce命令被执行时刻的状态决定。该命令同样不能与动力学积分命令联用。

###### fix recenter, fix oneway, fix smd
1. `fix recenter`命令通过调整原子的坐标，可以使编组的质心固定到指定点，该命令需要放到动力学积分命令之后使用。
1. `fix oneway`命令可以控制粒子只能沿一个坐标方向移动，可用于模拟半透膜的特性。
1. `fix smd`命令可以将一个组的原子恒速或恒力拉向指定点或拉向另一个组，可用于进行伞形偏倚采样以计算平均力势。


### 参考资料：
1. [How can I fix group of atoms in graphene sheet in LAMMPS?](https://www.researchgate.net/post/How_can_I_fix_group_of_atoms_in_graphene_sheet_in_LAMMPS2)
1. [LAMMPS之约束方法](https://zhuanlan.zhihu.com/p/257811414)


![](/img/wc-tail.GIF)
