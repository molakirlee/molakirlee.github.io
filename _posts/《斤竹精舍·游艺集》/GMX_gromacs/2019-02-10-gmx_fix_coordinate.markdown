---
layout:     post
title:      "gmx Gromacs坐标固定"
subtitle:   ""
date:       2019-02-10 20:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2019

---

### 坐标约束
#### 坐标的restrain、freeze和constraint
（参考自sobereva）gromacs有三种限制坐标的方式：限制（restrain）、冻结（freeze）、约束(constraint)。冻结和约束是完全去掉体系某些自由度，而限制则只是让某些自由度的运动受限。

- 限制（restrain）：一般是用**谐振势**将某些**原子间距离、分子中某些内坐标、或者某些原子的笛卡尔坐标系**限制在指定数值上，**允许有一定波动**。限制势力常数越大则限制效果越明显、波动范围越小。此做法相当于修改势能面来让被限制的自由度在额外施加的势阱中。【内坐标、笛卡尔坐标都在小范围内变化】
- 冻结（freeze）：令某些原子的**笛卡尔坐标系固定在初值**。例如模拟水穿越碳纳米管时将碳纳米管坐标完全固定住以免乱跑。【笛卡尔坐标完全固定】
- 约束（constraint）：令分子的某些**内坐标或原子间距离**一直固定在特定值，用于实现特殊的目的，如保持水分子的刚性、避免与氢有关的键振动。约束需要特殊的算法来实现。【内坐标不变】

**restrain可以用于NPT，但freeze和一些constraint则不可以。因为NPT会调整盒子大小，分子坐标同时也会变化，但freeze和一些constraint却要限制住，所以存在矛盾，体系、盒子可能爆炸。所以对于有freeze的体系只能用NVT不能用NPT，若非要用NPT则看看用restrain能否满足要求。**

参考：[解析gromacs的restraint、constraint和freeze](http://sobereva.com/10)  
参考：[Re: Freeze + NPT + constraints - 1](https://www.mail-archive.com/gmx-users@gromacs.org/msg62889.html)；[Re: Freeze + NPT + constraints -2](https://www.mail-archive.com/gmx-users@gromacs.org/msg32246.html)  


#### pull固定坐标

Case of Xilock:

```
pull            = yes
pull-ngroups    = 1
pull-ncoords    = 1
pull-group1-name = frozen
pull-coord1-type     = constraint
pull-coord1-geometry = distance
pull-coord1-groups = 0 1 ; 0是指远点，故此处是指group1相对于原点
pull-coord1-dim      = N N Y
pull-coord1-start    =yes
pull-nstxout    = 0
pull-nstfout    = 0
```


Case from paper: Atomistic Study of Zwitterionic Peptoid Antifouling Brushes(DOI: 10.1021/acs.langmuir.8b01939)  
```
pull            = constraint ;Center of mass pulling using a constraint between the reference group and one or more groups. The setup is identical to the option umbrella, except for the fact that a rigid constraint is applied instead of a harmonic potential.
pull_geometry   = distance ;Pull along the vector connecting the two groups. Components can be selected with pull-dim.
pull_dim        = N N Y ;the distance components to be used with geometry distance and position, and also sets which components are printed to the output files
pull_start      = yes ;add the COM distance of the starting conformation to pull-init. If choose "no", it do not modify pull-init.

pull-nstxout    = 0 ;frequency for writing out the COMs of all the pull group
pull-nstfout    = 0 ;frequency for writing out the force of all the pulled group
pull-ngroups    = 6 ;The number of pull groups, not including the reference group. If there is only one group, there is no difference in treatment of the reference and pulled group (except with the cylinder geometry). Below only the pull options for the reference group (ending on 0) and the first group (ending on 1) are given, further groups work analogously, but with the number 1 replaced by the group number.
pull-ncoords    = 6 ;The number of pull coordinates. Below only the pull options for coordinate 1 are given, further coordinates simply increase the coordinate index number.
pull-group1-name = frozen1 ; The name of the pull group, is looked up in the "index" file or in the default groups to obtain the atoms involved.
pull-coord1-groups = 0 1 ;The two groups indices should be given on which this pull coordinate will operate. The first index can be 0, in which case an absolute reference of pull-coord1-origin is used. With an absolute reference the system is no longer translation invariant and one should think about what to do with the center of mass motion. 
pull-group2-name = frozen2
pull-coord2-groups = 0 2
pull-group3-name = frozen3
pull-coord3-groups = 0 3
pull-group4-name = frozen4
pull-coord4-groups = 0 4
pull-group5-name = frozen5
pull-coord5-groups = 0 5
pull-group6-name = frozen6
pull-coord6-groups = 0 6

```

在5.1.2及之后的版本中 `pull=yes` 然后在 `pull-coord1-type`中设置每个coord是哪种约束类型（umbrella，constraint，constant-force，flat-bottom）， `pull_geometry` `pull_dim`和 `pull_start` 分别变成 `pull-coord1-geometry` `pull-coord1-dim` `pull-coord1-start`  
若不设定 `pull-coord1-origin` 或 `pull-origin` 则默认设置为（0,0,0）。  
参考[gromacs manual 5.1](http://manual.gromacs.org/documentation/5.1/user-guide/mdp-options.html#com-pulling)  

#### freeze

在mdp中添加：  
```
freezegrps      = bas SG
freezedim       = Y Y Y Y Y Y
```


![](/img/wc-tail.GIF)
