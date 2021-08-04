---
layout:     post
title:      "VMD在LAMMPS中的应用"
subtitle:   ""
date:       2020-09-12 22:03:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### 用VMD转换data文件

convert.tcl
```
package require topotools
package require pbctools
## Select atoms and asign info
set atomS [atomselect top {name S}]
$atomS set mass 80
$atomS set charge -1
$atomS set radius 1.7
$atomS set name S
$atomS set type Qa
#$atomS delete

## guess bonding from atomic radii 
mol bondsrecalc top 

## resets all bond types
topo clearbonds
topo clearangles
topo guessbonds
topo guessangles
topo retypebonds 
topo retypeangles

## check info and output
mol reanalyze top
pbc set {50.0 50.0 50.0 90.0 90.0 90.0}
topo writelammpsdata data.poly1B
#topo readlammpsdata data.poly100B
```

### 显示
###### 超出周期性box
```
pbc wrap -compound res -all
pbc box
```

### 参考：
1. [TopoTool-Tutorial - Part 1](https://sites.google.com/site/akohlmey/software/topotools/topotools-tutorial---part-1)
1. [water molecules out of box boundary](https://lammps.sandia.gov/threads/msg42779.html)
1. [lammps建模方法，即生成data文件](http://bbs.keinsci.com/thread-18520-1-1.html)
1. [TopoTools Command](http://www.ks.uiuc.edu/Research/vmd/plugins/topotools/#TOC-bondtypenames)
1. [[lammps-users] bond-angle-Dihedral Coeffs](https://lammps.sandia.gov/threads/msg74622.html)

![](/img/wc-tail.GIF)
