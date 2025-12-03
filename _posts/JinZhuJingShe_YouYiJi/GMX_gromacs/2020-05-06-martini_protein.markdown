---
layout:     post
title:      "gmx Martini力场粗粒化-概述及蛋白模拟"
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


### Martinize2/Vermouth
**202511200更新：martinize.py开发者重写了程序，现为Martinize2/Vermouth，可见其官网[Topology/Structure Generation](https://cgmartini.nl/docs/downloads/tools/topology-structure-generation.html)**

###### Win系统anaconda环境安装
1. 详细流程参见：[Readme](https://github.com/marrink-lab/vermouth-martinize#vermouth)
1. 要求python 3.9以上
1. `pip install vermouth`
1. 此时已将Martinize2和Vermouth安装到了其conda环境下，如`C:\Users\Xilock\.conda\envs\py310env\Scripts\`，`martinize2`也在该文件夹下
1. 教程说可以直接使用`martinize2 -h`，但xilock测试发现虽然Scripts这个路径在激活环境后是添加到PATH中的，但直接输入`martinize2 -h`会提示让你选择应用，需要用`python C:\Users\Xilock\.conda\envs\py310env\Scripts\martinize2 -h`才行（`echo %CONDA_PREFIX%`可查看环境的位置，所以可以`python %CONDA_PREFIX%\Scripts\martinize2 -h`）
1. 使用`-dssp`需要`mdtrj`（Martinize2 and vermouth have mdtraj as optional dependency as an alternative to dssp.），可以通过`conda install -c conda-forge mdtraj`安装

###### [官网教程: Hands-on Tutorials Step by step tutorials to get you started with Martini](https://cgmartini.nl/docs/tutorials/Martini3/tutorials.html)

###### 测试例[GROMACS Tutorial: Coarse-Grained Simulations with Martini 3 Force Field](https://www.compchems.com/gromacs-tutorial-coarse-grained-simulations-with-martini-3-force-field/#convert-the-structure-to-cg-with-martinize)
1. `wget http://www.pdb.org/pdb/files/1AKI.pdb`
1. `grep -v HETATM 1AKI.pdb > 1aki_clean.pdb`
1. `python %CONDA_PREFIX%\Scripts\martinize2 -f 1aki_clean.pdb -dssp -x 1aki_cg.pdb -o topol.top -ff martini3001 -cys auto -p backbone -elastic -ef 700.0 -el 0.5 -eu 0.9` ，This will generate three files: the CG structure (1aki_cg.pdb)、The corresponding topology (topol.top)、The parameters file for the protein (molecule_0.itp).

1. The command begins with martinize2, which is the executable for the martinize2 tool.
1. The -f flag is used to specify the input atomistic structure file in PDB format. In this case, it is 1aki_clean.pdb.
1. Provide the secondary structure via the -dssp flag (More info below).
1. The -x flag is used to specify the output file name for the converted CG structure. Here, the name 1aki_cg.pdb is chosen for the coarse-grained structure file.
1. Select the -o flag and name the topology (topol.top). The topology file will contain all the information about the system
1. Select the Martini 3 force field with -ff martini3001
1. The -cys flag is set to auto, which allows the program to automatically detect disulfide bonds in the protein and create appropriate constraints.
1. The -p backbone option defines position restraints on the backbone.
1. The -elastic flag activates the elastic network model. Elastic networks are used to introduce harmonic constraints between pairs of atoms within a certain cutoff distance, simulating the connectivity and flexibility of the protein.
1. The -ef, -el, and -eu flags control the parameters for the elastic network. -ef 700.0 sets the force constant for the elastic network springs to 700 • kJ/mol/nm$^2$, -el 0.5 defines the lower cutoff for interactions, and -eu 0.9 specifies the upper cutoff. These parameters determine the strength and range of the harmonic constraints in the elastic network.

1. 下载用于构建体系system的[insane.py](https://www.compchems.com/gromacs_cg/insane.py)
1.`python2.7 insane.py -f 1aki_cg.pdb -o system.gro -p topol.top -d 7 -sol W:100 -salt 0.15 ` 

1. -f 1aki_cg.pdb: This option specifies the input CG structure file in PDB format, which in this case is 1aki_cg.pdb.
1. -p topol.top: The -p flag is used to provide the topology file (topol.top).
1. -o system.gro: The -o flag sets the name of the output file for the solvated system in the gro format (system.gro)
1. -d 7: builds the periodic box such that the distance between two periodic images is greater than 7 nm.
1. -sol W: The -sol flag specifies the solvent type to add to the system. Here, W represents water molecules. By specifying -sol W, we indicate that we want to solvate the system with water.
1. -salt 0.15: The -salt flag is used to add salt ions to the system. The value 0.15 indicates the desired salt concentration in moles per liter (M).

1. 从Martini3官网下载[拓扑文件martini_v300.zip](https://cgmartini.nl/docs/downloads/force-field-parameters/martini3/particle-definitions.html)并解压缩
1. 修改topol文件，添加`#include`的路径
```
#include "martini_v300/martini_v3.0.0.itp"
#include "martini_v300/martini_v3.0.0_solvents_v1.itp"
#include "martini_v300/martini_v3.0.0_ions_v1.itp"
#include "molecule_0.itp"




[ system ]
; name
Insanely solvated protein.

[ molecules ]
; name  number
Protein        1
W            10672
NA            113
CL            121
```

1. mdp文件参考格式可见[官网MD parameters](https://cgmartini-library.s3.ca-central-1.amazonaws.com/1_Downloads/example_input_files/mdps/martini_v3.x_example.mdp)，或者参考[GROMACS Tutorial: Coarse-Grained Simulations with Martini 3 Force Field](https://www.compchems.com/gromacs_cg/minim.mdp)
1. 按照min->npt->md
```
mkdir minim
cd minim
gmx_mpi grompp -f minim.mdp -c ../system.gro -r ../system.gro -p ../topol.top -o em.tpr
gmx_mpi mdrun -v -deffnm em

mkdir npt
cd npt
gmx_mpi grompp -f npt.mdp -c ../minim/em.gro -r ../minim/em.gro -p ../topol.top -o npt.tpr
nohup gmx_mpi mdrun -v -deffnm npt &

mkdir md
cd md
gmx_mpi grompp -f md.mdp -c ../npt/npt.gro -t ../npt/npt.cpt -p ../topol.top -o md.tpr -n ../index.ndx
nohup gmx_mpi mdrun -v -deffnm md &
```
1. 检查rmsd


 
###### 使用 SAMSON 平台 (图形界面)
1. [Create coarse-grained models for the MARTINI force field.](https://www.samson-connect.net/extensions/0753f4e9-00ce-ae5b-eefd-d95f3e0c29bd)
1. [Create coarse-grained models for the MARTINI force field using Martinize2](https://documentation.samson-connect.net/tutorials/martinize2/martinize2/)

1. `-dssp`等指令在`Martinize-->Martinize2 options-->Additional options`里添加


附录：
1. [简介：Discover SAMSON, your integrative platform for molecular design](https://www.samson-connect.net/)
1. [Samson Blog: 一些使用说明](https://blog.samson-connect.net/)

### martinize.py及其流程简述

**感谢李老师、Supernova和吴伟哥的指导，本文内容摘录整理自参考资料，以便用时翻阅**  



参考资料：
1. [MARTINI粗粒化力场简明教程](https://zhuanlan.zhihu.com/p/93216681)
1. [吴伟：auto-martini的安装和使用简介](https://jerkwin.github.io/2019/08/05/%E5%90%B4%E4%BC%9F-auto-martini%E7%9A%84%E5%AE%89%E8%A3%85%E5%92%8C%E4%BD%BF%E7%94%A8%E7%AE%80%E4%BB%8B/)
1. [Martini实例教程：蛋白质](https://jerkwin.github.io/2016/10/11/Martini%E5%AE%9E%E4%BE%8B%E6%95%99%E7%A8%8BPro/)
1. [Martini实例教程：新分子的参数化](https://jerkwin.github.io/2016/10/10/Martini%E5%AE%9E%E4%BE%8B%E6%95%99%E7%A8%8BMol/)
1. [github库：cgmartini/martinize.py](https://github.com/cgmartini/martinize.py)
1. [github库链接](https://github.com/molakirlee/martinize.py)
1. [示范教程：Training school from eCOST: Coarse-Grained Tutorial](https://github.com/DanielCondeTorres/Coarse-Grain-Tutorial)

供参考用mdp文件：
1. [From martini官网](http://cgmartini.nl/images/parameters/exampleMDP/)
1. [From Supernova](https://github.com/supernovaZhangJiaXing/Excalibur/tree/master/MARTINI%E7%B2%97%E7%B2%92%E5%8C%96%E5%8A%9B%E5%9C%BA%E7%AE%80%E6%98%8E%E6%95%99%E7%A8%8B)

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


### 水分子类型选择
1. 何时使用? 首先我们指出, 极化Martini水模型并不意味着要代替标准的Martini水模型, 而应视为某些性质有所改进的替代模型, 但在其他应用中行为类似时效率更低. 由于极化水珠子包含三个粒子, 所以它比标准的Martini水模型贵2~3倍. 当极化水模型与PME联合使用时, 速度会更慢. 然而, 若研究体系或过程中涉及低介电常数介质中的电荷或极性粒子(如, 双层内部, 或蛋白质), 极化水模型是更真实, 因为它考虑了体系电介质的不均匀性. 另外, 对静电场(外部和内部)的影响的模拟也更真实. 事实上, 你甚至可以模拟出像电穿孔这样很酷的现象。 参见[李老师博客:Martini粗粒化力场使用手册：2常见问题](https://jerkwin.github.io/2016/08/31/Martini%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98/)，原文参见[Frequently Asked Questions](https://cgmartini.nl/docs/faq/#how-do-i-use-the-martini-2-polarizable-water-model-and-when-should-i-use-it)
1. [Coarse-GrainedMolecularDynamicsSimulationsoftheSpheretoRod Transition in Surfactant Micelles](dx.doi.org/10.1021/la2006315): 极化水和非极化水的组装形貌不同
1. [Short Peptide Self-Assembly in the Martini Coarse-Grain Force Field Family](https://doi.org/10.1021/acs.accounts.2c00810): 极化水不利于组装
1. [Scaling Protein−Water Interactions in the Martini 3 Coarse-Grained Force Field to Simulate Transmembrane Helix Dimers in Different Lipid Environments](https://doi.org/10.1021/acs.jctc.2c00950): 疏水为主的过程用了非极化水
1. 什么时候用BMW水？

![](/img/wc-tail.GIF)
