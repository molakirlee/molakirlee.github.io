---
layout:     post
title:      "LAMMPS MS生成lmp输入文件 msi2lmp"
subtitle:   ""
date:       2020-12-06 22:03:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### 使用说明
###### 指定力场 
1. MS中对建好的*.cif模型文件指定力场。Modulus => Discover => Setup => Select => cvff；
1. 然后把Typing中,List all forcefield types前面的勾选去掉；
1. 最后点选,Calculate 
1. 把模型导出为*.car格式，将同时生成*.car 和*.mdf文件。 

###### 生成可执行程序msi2lmp.exe 
/lamps-30Jul16/tools/msi2lmp/src文件夹下执行make命令，将会生成msi2lmp.exe可执行文件。

###### 转化*.data 
1. 将lammps目录下tool/msi2lmp/frc_files文件夹拷贝到临时目录；
1. 将第一步生成的*.car和*.mdf文件（如benzene-class1.car和benzene-class1.mdf）和第二步得到的msi2lmp.exe拷贝到frc_files文件夹下；
1. 由于/frc_files中已经存在各种所需的力场，所以不再需要拷贝cvff.frc；
1. 然后在此文件夹下输入命令： `./msi2lmp.exe benzene-class1 -class I -frc cvff.frc`，生成的XXX.data就是需要的data文件。 

### 说明
1. 需要在src文件夹下执行make命令后才会生成msi2lmp.exe，否则无法找到。 
1. 不能把*.car和*.mdf文件和第二步得到的msi2lmp.exe拷贝到自己建的单独文件夹中，虽然有人说可以这么做，但实测发现会报错“/frc_files/cvff.frc cannot”。 
1. 第三步只生成*.data文件，并不像‘有些文档’所说的会生成两个文件。具体原因可能是版本不同？
1. 命令中“I”是罗马字母1，不是字符“|”或1。 
1. 具体命令的含义参见/lammps-30Jul16/tools/msi2lmp/中的README。 

### 参考资料
1. [msi2lmp生成data文件](https://wenku.baidu.com/view/4c764dbb03d276a20029bd64783e0912a2167c2e.html?re=view)

![](/img/wc-tail.GIF)
