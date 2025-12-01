---
layout:     post
title:      "gmx Martini力场粗粒化-聚合物的模拟"
subtitle:   ""
date:       2020-08-25 09:57:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2020


---

**感谢李老师的指导，本文内容摘录整理自参考资料，以便用时翻阅**  

### 供参考用mdp文件：
1. [From martini官网](http://cgmartini.nl/images/parameters/exampleMDP/)
1. [From Supernova](https://github.com/supernovaZhangJiaXing/Excalibur/tree/master/MARTINI%E7%B2%97%E7%B2%92%E5%8C%96%E5%8A%9B%E5%9C%BA%E7%AE%80%E6%98%8E%E6%95%99%E7%A8%8B)



### 工具
##### pyCGtool
 [官网：PyCGTOOL](https://pycgtool.readthedocs.io/en/master/tutorial.html#atomistic-simulation)
###### 安装（注意：只能在linux下安装，win下simpletraj包的c++编译通不过）
需要的包：
1. Python 3；
1. [Numpy](http://www.numpy.org/)
1. [simpletraj](https://github.com/arose/simpletraj): `pip install simpletraj`

###### 使用
调用指令：  
```
pycgtool.py -g <GRO file> -x <XTC file> -m <MAP file> -b <BND file>
```
输入文件：gro文件、xtc文件、map文件、bnd文件。  
map文件为原子映射，如：
dppc.map
```
; comments begin with a semicolon
[ALLA]
C1 P3 C1 O1
C2 P3 C2 O2
C3 P3 C3 O3
C4 P3 C4 O4
C5 P2 C5 C6 O6
O5 P4 O5

[SOL]
W P4 OW HW1 HW2
```
bnd文件为拓扑：
```
; comments begin with a semicolon
[ALLA]
C1 C2
C2 C3
C3 C4
C4 C5
C5 O5
O5 C1

C1 C2 C3
C2 C3 C4
C3 C4 C5
C4 C5 O5
C5 O5 C1
O5 C1 C2

C1 C2 C3 C4
C2 C3 C4 C5
C3 C4 C5 O5
C4 C5 O5 C1
C5 O5 C1 C2
O5 C1 C2 C3
```


##### charmm-gui
1. [charmm-gui](http://www.charmm-gui.org/?doc=input/polymer)


##### [PolyPly](https://cgmartini.nl/docs/downloads/force-field-parameters/martini3/polymers.html)
1. Martini3力场建议的参考.
1. Martini 3 polymer topologies can be obtained using [PolyPly](https://github.com/marrink-lab/polyply_1.0). A helpful tutorial on how to use PolyPly to generate polymer topologies can be found [here](https://github.com/marrink-lab/polyply_1.0/wiki/Tutorial:-Martini-Polymers).Grünewald F., et. al.. Polyply; a python suite for facilitating simulations of macromolecules and nanomaterials. Nature Communications, 2022.(doi: 10.1038/s41467-021-27627-4)


##### [GPOLY(未测试)](https://github.com/jabl/cgpoly)

##### [PolySMart：粗粒化聚合物交联反应(未测试)](https://github.com/HMakkiMD/PolySMart?tab=readme-ov-file)
1. 原文见[《PolySMart: a general coarse-grained molecular dynamics polymerization scheme》](https://doi-org.manchester.idm.oclc.org/10.1039/D3MH00088E)

### 参考资料：
1. [Martini实例教程：新分子的参数化](https://jerkwin.github.io/2016/10/10/Martini%E5%AE%9E%E4%BE%8B%E6%95%99%E7%A8%8BMol/)
1. [英文版教程-Martini tutorials: polymers](http://cgmartini.nl/index.php/tutorials-general-introduction-gmx5/martini-tutorials-polymers-gmx5)
1. [中文版教程Martini实例教程：聚合物](https://jerkwin.github.io/2016/12/30/Martini%E5%AE%9E%E4%BE%8B%E6%95%99%E7%A8%8BPol/)
1. [珠子参数化英文教程-Parametrizing a new molecule based on known fragments](http://cgmartini.nl/index.php/tutorials-general-introduction-gmx5/parametrzining-new-molecule-gmx5)
1. [珠子参数化中文教程-Martini实例教程：新分子的参数化](http://t066v5.coding-pages.com/2016/10/10/Martini%E5%AE%9E%E4%BE%8B%E6%95%99%E7%A8%8BMol/)
1. [martini原文·Table.3为珠子类型](https://pubs.acs.org/doi/10.1021/jp071097f)
1. [The Martini Coarse-Grained Force Field](http://md.biol.rug.nl/images/stories/martini-chapter.pdf)

1. 另：gromacs粗理华建模程序PyCGTool，参见李老师博客

![](/img/wc-tail.GIF)
