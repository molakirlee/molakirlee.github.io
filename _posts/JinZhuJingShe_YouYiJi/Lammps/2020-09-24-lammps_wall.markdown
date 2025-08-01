---
layout:     post
title:      "LAMMPS中wall的应用"
subtitle:   ""
date:       2020-09-24 15:09:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### 周期性
###### boundary
对于有wall的体系，不能使用全周期性的盒子，必须定义对应的boundary。如固定z方向壁面，则需设定：

```
boundary     p p f
```

其中`p`为周期性，`f`为固定壁面，意味着x/y方向为周期性而z方向上有一固定壁面。如果希望壁面移动，则将相应壁面设为`s`，如：

```
boundary     p p s
```

###### kspace
1. wall只能用在非周期边界上，但pppm除一种情况外只能用于全周期性条件，The only exception is if the slab option is set with kspace_modify,，参见：[kspace_style command](https://docs.lammps.org/kspace_style.html)
1. 对于非周期性体系，长程COU的计算也需要modify，不能仅仅指定`kspace_style`。对于`p p f`的体系而言，kspace部分应做如下修改：  
1. *建模时在壁面方向不能有跨周期的原子，比如Fe等基底*
1. npt不能采用该方法，因为npt必须是周期性的（`Cannot use fix npt on a non-periodic z dimension`）

```
boundary        p p f
pair_style      lj/charmmfsw/coul/long 11 12
kspace_style    pppm 0.001
kspace_modify   slab 3.0
```


### [fix wall/reflect](https://lammps.sandia.gov/doc/fix_wall_reflect.html)
Bound the simulation with one or more walls which reflect particles in the specified group when they attempt to move through them.  
Reflection means that if an atom moves outside the wall on a timestep by a distance delta (e.g. due to fix nve), then it is put back inside the face by the same delta, and the sign of the corresponding component of its velocity is flipped.   

### [fix wall/lj126](https://lammps.sandia.gov/doc/fix_wall.html#fix-wall-lj126-command)
Bound the simulation domain on one or more of its faces with a flat wall that interacts with the atoms in the group by generating a force on the atom in a direction perpendicular to the wall. The energy of wall-particle interactions depends on the style.  

```
# parameter value is epsilon, sigma, and cutoff respectively.
fix wall1 all wall/lj126 zlo EDGE 0.1 1.0 2.5
fix wall2 all wall/lj126 zhi EDGE 0.1 1.0 2.5
```


### 非平面wall
下面代码设置墙按正弦曲线运动，实现震动效果：

```
units       lj
atom_style  atomic
boundary    f f f
region      box block 0 30 0 30 0 30 units box
create_box 1 box
region      top block INF INF INF INF 10 INF units box
create_atoms 1 random 150 8989 top
mass 1 1
velocity    all create 1 9898
variable wiggle equal swiggle(10,8.0,8.0)
fix zwalls1 all wall/reflect zlo v_wiggle
dump  1 all atom 100 dump.xyz
fix  1 all nve
run 10000
```

效果为：
![](https://vdn3.vzuu.com/SD/98c958a8-ffd2-11eb-9364-a6582d929f33.mp4?auth_key=1753477994-0-0-aee4832cecebb8d596a09abe3304ba74&bu=078babd7&c=avc.0.0&disable_local_cache=1&expiration=1753477994&f=mp4&pu=078babd7&v=tx)


### 通过压缩壁面控制体系密度
###### soft势
首先利用soft势替换lj势来推开重叠原子，提供一个较好的初始结构：

```
pair_style     soft 2.0
pair_coeff     * * 50.0
```
###### 壁面压缩

之后通过运行步数来控制z方向的上壁面wall：
```
variable    z equal 311-0.001*elapsed
fix         1 all nvt temp 300.0 300.0 100.0
#fix         2 all langevin 300.0 300.0 80.0 699483	
fix         3 all wall/reflect zlo EDGE zhi v_z
timestep    1.0
run         267400
```

具体参见参考资料1和2.


###### lj势
将pair_style改回lj势后弛豫：
```
pair_style     lj/cut 10.0
pair_coeff     * * 0.112 4.01
```


### 参考资料
1. [moltemplate导出模型密度控制2.0](https://blog.csdn.net/qyb19970829/article/details/105189427)
2. [Liquid/Solid Surface-02](https://blog.csdn.net/qyb19970829/article/details/107012939)
3. [fix wall/reflect命令实现“振动墙”效果](https://zhuanlan.zhihu.com/p/400972463)

![](/img/wc-tail.GIF)
