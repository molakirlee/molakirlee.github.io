---
layout:     post
title:      "gmx Martini力场粗粒化-蛋白模拟"
subtitle:   ""
date:       2020-05-06 09:57:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2020


---

**感谢李老师、Supernova和吴伟学长的指导，本文内容摘录整理自参考资料，以便用时翻阅**  

参考资料：
1. [MARTINI粗粒化力场简明教程](https://zhuanlan.zhihu.com/p/93216681)
1. [吴伟：auto-martini的安装和使用简介](https://jerkwin.github.io/2019/08/05/%E5%90%B4%E4%BC%9F-auto-martini%E7%9A%84%E5%AE%89%E8%A3%85%E5%92%8C%E4%BD%BF%E7%94%A8%E7%AE%80%E4%BB%8B/)
1. [Martini实例教程：蛋白质](https://jerkwin.github.io/2016/10/11/Martini%E5%AE%9E%E4%BE%8B%E6%95%99%E7%A8%8BPro/)
1. [Martini实例教程：新分子的参数化](https://jerkwin.github.io/2016/10/10/Martini%E5%AE%9E%E4%BE%8B%E6%95%99%E7%A8%8BMol/)

供参考用mdp文件：
1. [From martini官网](http://cgmartini.nl/images/parameters/exampleMDP/)
1. [From Supernova](https://github.com/supernovaZhangJiaXing/Excalibur/tree/master/MARTINI%E7%B2%97%E7%B2%92%E5%8C%96%E5%8A%9B%E5%9C%BA%E7%AE%80%E6%98%8E%E6%95%99%E7%A8%8B)

### 流程简述
###### 对pdb文件使用martinize.py创建粗粒化pdb和topol
`python martinize.py -f protein.pdb -o topol.top -x protein_CG.pdb -name protein -ff martini22 -nt`
注意：
1. 要使用不带电的末端(-nt)；
1. 对于蛋白要指定二级结构，使用-dssp或者-ss(dssp下载:http://swift.cmbi.ru.nl/gv/dssp/ );
1. 使用dssp的话指令为：`python martinize.py  -f  1UBQ.pdb  o  system-vaccum.top  -x  1UBQ-CG.pdb  -dssp  /pwd/to/dssp  -p  backbone  -ff  martini22`
1. 使用已准备的蛋白二级结构(ssd.dat)的话指定则变为:`python martinize.py  -f  1UBQ.pdb  -o  system-vaccum.top  -x  1UBQ-CG.pdb  -ss  ssp.dat  -p  backbone  -ff  martini22`；
1. 生成的top没有自定义残基，若分子中包括自定义残基，则需手动解决或使用auto-martini（见《Martini力场粗粒化-实操auto_martini》）；
1. 在蛋白质的模拟中，蛋白质的二级结构不仅影响粗粒化以后的珠子类型，还影响键、键角、二面角等参数。如果改变蛋白质的二级结构，可以通过两种途径：一种是基于标准的martini拓扑产生一个简单的弹性网络拓扑(在运行martimize.py时后面添加 -elastic  -ef  500  -el  0.5  -eu  0.9  -ea  0  -ep  0)；另一种是通过ElNeDyn网络方法(在运行martimize.py时后面添加 -ff  elnedyn22)(xilock尚未测试)；

###### 修改topol文件
用martinize.py得到的top文件如下：  
```
#include "martini.itp"
#include "protein.itp"

[ system ]
; name
Martini system from protein.pdb

[ molecules ]
; name        number
protein 	 1
```

1. 所得到的topol文件的首行指令没有指定力场的版本，若使用martini2.2则将其改为`#include "martini_v2.2.itp"`
1. 添加离子拓扑：`#include "martini_v2.0_ions.itp"`

###### 添加水分子
1. 获得单个肽的粗粒化坐标并创建其拓扑后，将该粗粒化肽加入盒子。
1. 之后添加水分子，可先添加10%的抗冻水（防止模拟过程中水结冰），然后添加普通水至合理密度。两种水的gro文件可以一样（water.gro为预先在300 K，1 bar下平衡好的普通水），但抗冻水原子名和残基名均为WF，普通水均为W。
1. 若用到极性水则一般为polarize-water.gro（预先在300 K，1 bar下平衡好的抗冻水）。

```
gmx solvate -cp p_box.gro -cs Fwater.gro -p topol.top -o p_w1.gro -radius 0.4
gmx solvate -cp p_w1.gro -cs water.gro -p topol.top -o p_w2.gro -radius 0.21
```

注：
1. -radius标志使肽最初保持一定程度的分离，抗冻水使用-radius 0.4 nm，以保证加得很稀疏；Martini水指定以保证密度大致正确；

一般添加5-10%的抗冻水，抗冻水BP4和普通水P4的VDW参数及电荷都一样，区别在于：  
1. 为了破坏水冻结的晶格结构，BP4和P4之间的$\sigma$为0.57nm而非0.47nm（BP4之间或P4之间为0.47nm）；
1. 为了避免抗冻水和溶剂水的相分离，BP4和P4之间的$\epsilon$要比两者各自单独的大一个级别（BP4之间或P4之间为1.195030 kcal/mol，BP4和P4之间为1.338434 kcal/mol）；

具体参见：
1. [Martini Bsics - Hands on: how to prepare a Martini](http://cgmartini.nl/images/stories/WORKSHOP2015/lecture-02.pdf)
1. [lammps - martini.lt](https://github.com/jewettaij/moltemplate/blob/master/moltemplate/force_fields/martini.lt)

###### 平衡电荷

```
gmx grompp -f em.mdp -c p_w2.gro -p topol.top -o em 
gmx genion -s em.tpr -p topol.top -o p_ions.gro -pname NA+ -nname CL- -neutral
```

1. 离子名称会在genion的命令行上显式添加，以确保它们与Martini中离子球的名称兼容（在文件martini_v2.0_ions.itp中定义）
1. 此处可能提示Note: For accurate cg with LINCS constraints, lincs-order should be 8 or more，故Supernova在em.mdp文件中将lincs-order设为8
1. 最优PME网格负载在0.25到0.33之间性能最好，可以通过调整PME的cut-off参数和格点间距实现（如果是大体系、耗时很长的话，恰当调整这两个参数可以显著降低耗时）

###### 模拟

grompp  
mdrun 

注意：
1. 根据Supernova的经验，随着体系的尺寸增加，范德华cut-off和静电cut-off两个参数也需要适当增加，否则体系容易崩溃，伴随大量LINC warning。
1. 如果体系本身就是电中性，没有添加抗衡离子，会提示不建议使用PME的警告。不要理会他，如果真的按照他的建议使用了Cut-off的话，体系极易崩溃。

对于大多数系统，肽的团簇通常分布在系统的周期性边界上。可以使用以下命令将最终帧定格在大型cluster上：
```
echo 1 1 1 | gmx trjconv -f md.gro -s md.tpr -pbc cluster -center -o md_fix.gro
```

### 自定义基团的处理
###### 使用auto-martini生成小分子/非标准残基拓扑 （暂未实操成功，推荐手动）
参见博文：《Martini力场粗粒化-实操auto_martini》

###### 手动划分拓扑结构

资料：[Parametrizing a new molecule based on known fragments](http://cgmartini.nl/index.php/tutorials-general-introduction-gmx5/parametrzining-new-molecule-gmx5)  


![](/img/wc-tail.GIF)
