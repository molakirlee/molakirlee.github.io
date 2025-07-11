---
layout:     post
title:      "LAMMPS 拉压曲线·杨氏模量"
subtitle:   ""
date:       2021-01-08 23:12:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2021

---

### deform法

1. [lammps command reference: fix deform command](https://docs.lammps.org/fix_deform.html)


### code
```
#模型初始化，模拟单位为metal，原子方式为atomic，3维模型
units  metal
atom_style   atomic
dimension  3

#定义边界条件，x和y方向为周期性边界，y为拉伸方向，z方向为固定边界
boundary     p p f

#定义邻域原子定义，1个原子的邻域原子列表是以该原子为中心，以力截断半径+缓冲值（也就是下面设置的0.3）为半径的圆内原子列表
neighbor      0.3 bin
neigh_modify    every 10 

#设置模拟步长为1fs
timestep        0.001

#生成模拟box，box内含有3种原子，这三种原子都是C原子，为了后期线上着色方便，原子类型分为上中下三种
region   box block 0 175 0 175 -5 5 units box
create_box 3 box

#自定义石墨烯晶格参数
lattice  custom 2.4768 a1 1.0 0.0 0.0 &
a2 0.0 1.732 0.0 a3 0.0 0.0 1.3727 & 
basis 0.0 0.33333 0.0 & 
basis 0.0 0.66667 0.0 &
basis 0.5 0.16667 0.0 &
basis 0.5 0.83333 0.0

#生成石墨烯原子，类型为1
region  gp block 10 120 10 120 -0.5 0.5 units box
create_atoms 1 region gp

#设置原子质量
mass * 12

#定义区域，上下两部分固定区域和中间活动区域mobile
region upper block INF INF 117 INF INF INF  units box
region lower block INF INF INF 13 INF INF units box
group upper region upper
group lower region lower
group boundary union upper lower
group mobile subtract all boundary

#设定最上端原子类型为2，最下端原子类型为3，为后期着色方便
set group upper type 2
set group lower type 3

#设置势函数，airebo常用于石墨烯的模拟
pair_style  airebo 2.0
pair_coeff  * * CH.airebo C C C

#初始化温度
velocity mobile create 300.0 8877528

#固定上下两端原子
fix  1 boundary setforce 0.0 0.0 0.0

#------------6 应力应变计算设置--------------------------------
# 应力
compute    1 all stress/atom NULL
compute    2 all reduce sum c_1[1] c_1[2]
variable   CorVol equal ly*lx*3.35
#variable   sigmaxx equal c_2[1]/(v_CorVol*10000)
variable   sigmayy equal c_2[2]/(v_CorVol*10000)
#variable px equal -pxx/10000
variable py equal -pyy/10000
#应变
#variable l_x equal lx
#variable lx0 equal ${l_x}
#variable strainx equal (lx-v_lx0)/v_lx0

#variable l_y equal ly
#variable ly0 equal ${l_y}
#variable strainy equal (ly-v_ly0)/v_ly0
compute 3 upper displace/atom
compute 4 upper reduce ave c_3[4]
variable strain equal c_4/110

#------------------------------------------------------


#以下四句代码，对模型在npt下进行弛豫，并将结果保存到文件中
thermo 100
fix  2 all npt temp 300.0 300.0 1 x 0 0 0.1 y 0 0 0.1
dump 1 all atom 100 gp_relax.lammpstrj
run 1000

#取消fix，dump设定，步数清零
unfix   2
undump 1
reset_timestep 0

#最上端设置y方向速度为1，沿y方向拉伸
velocity upper set 0.0 1.0 0.0

#按比例设置mobile部分的速度
velocity mobile ramp vy 0.0 1.0 y 8 52 sum yes

#在nvt下进行拉伸
fix  2 all nvt temp 300.0 300.0 0.01

#进行热力学输出，保存拉伸后原子坐标
#thermo_style custom step press v_strain v_px v_sigmaxx temp lx ly lz vol
thermo_style custom step press v_strain v_py v_sigmayy temp lx ly lz vol
thermo 100
thermo_modify lost ignore
dump  1 all atom 1000 gp_tension.lammpstrj
run  10000
```

注意：
1. `$`为临时变量immidiate variable；
1. Per-atom compute in equal-style variable formula：因为是矢量，所以不能直接equal，需用`compute reduce`转化成标量后才能`equal`，参见lammps的error messages；
1. 应变计算部分用lx是针对变盒子边界的方法(deform)，如果是velocity法的话则可用`displace/atom`计算位移来计算；

### 参考资料
1. [lammps案例分析（1）：石墨烯单轴拉伸之velocity方式](https://zhuanlan.zhihu.com/p/260759751)
1. [lammps案例分析（2）：石墨烯单轴拉伸之deform方式](https://zhuanlan.zhihu.com/p/260765732)
1. [lammps计算的应力的方法](https://blog.csdn.net/weixin_30865427/article/details/99338987)
1. [lammps教程：应力-应变数据的计算与输出](https://zhuanlan.zhihu.com/p/338608581)
1. [Re: [lammps-users] Tracking distance between two atoms](https://lammps.sandia.gov/threads/msg03807.html)
1. [compute displace/atom command](https://lammps.sandia.gov/doc/compute_displace_atom.html)
1. [Error messages](https://lammps.sandia.gov/doc/Errors_messages.html)
1. [Mechanical properties at nano-level: copper nanowire](https://core.ac.uk/download/pdf/41795277.pdf)
1. [LAMMPS及Al杨氏模量示例](https://andrewferguson.uchicago.edu/resources/ICME_Workshop_140723.pdf)
1. [LAMMPS中使用fix deform命令拉伸单层石墨烯的算例子+附in文件](http://blog.sciencenet.cn/blog-3388193-1125565.html)
1. [LAMMPS做拉伸与剪切](https://lammps.org.cn/zh/column/nemd/deform.html#%E6%8B%89%E4%BC%B8%E4%B8%8E%E5%8E%8B%E7%BC%A9)
1. [lammps案例分享：聚乙烯拉伸过程分子动力学模拟](https://zhuanlan.zhihu.com/p/339879645)
1. [lammps案例：SiC拉伸下的裂纹扩展](https://zhuanlan.zhihu.com/p/338870131)

![](/img/wc-tail.GIF)
