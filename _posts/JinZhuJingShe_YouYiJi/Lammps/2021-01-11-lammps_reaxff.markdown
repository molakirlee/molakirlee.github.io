---
layout:     post
title:      "LAMMPS reaxff"
subtitle:   ""
date:       2021-01-11 19:12:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2021

---

### 简介
1. ReaxFF反应力场适用于各类化学反应体系的模拟，特别是原理简单、动态复杂的反应/过程。利用合适的工具和工作方法，我们可以实现一定程度上的“虚拟实验”，得到一些实验室里无法得到的信息，例如燃烧、爆炸、分解反应的历程、连续复杂过程中物质的相互转化等。
1. 因为是多体势，运行的速度直接和密度相关，分子越大、越密集，产生的pair就越多，越慢。使用16核，5000原子左右的体系，0.2 fs的步长，极低密度的气相热解问题能跑到> 20 ns/day。而5000原子高密度凝聚态可能不到1 ns/day。虽然大多数用的上ReaxFF的问题几ns、几十ns肯定够了，但是反应力场是必然需要钻研调试的，所以需要特别注意模拟设计的合理性，免得白跑。因此，在性能调优时，需要综合权衡核数、neighbor、balance方式，避免因为原子跑出CPU核心的”包干区”而导致崩溃。

### 安装
1. Lammps中使用ReaxFF模块，需要在编译时包含REAXFF包，同时由于要计算动态电荷，还需要QEQ包。自己编译，用cmake编译非常方便，参考Lammps英文手册和[《WSL2下Kokkos版加速的Lammps的cmake编译》](http://bbs.keinsci.com/forum.php?mod=viewthread&tid=36559)

### 力场获取
1. scm网站是lammps官方推荐的一个反应势下载网站，网址为：[https://www.scm.com/doc/ReaxFF/Included_Forcefields.html](https://www.scm.com/doc/ReaxFF/Included_Forcefields.html)，打开之后，会列出应用于不同元素的反应势文件，并且给出了参考文献和简单介绍。以第一个H/O/N/B势为例，点击上图中红色框内文字，跳转到论文页面，在该页面找到“Supporting Information”，“Supporting Information”后面的就是反应势文件，点击右下角的“Download”即可下载该势函数文件。下载的反应势文件大多是pdf版本，需要把势函数文本复制出来，保存到txt文档，重新命名就可以在lammps中使用了。
1. ReaxFF模块可以用KOKKOS的方式使用GPU加速，前提是自行编译了GPU、KOKKOS包。GPU加速的效果和体系的大小有关。但是GPU加速有一个好处是，并行效率的烦恼比较小。这个体系模拟后期可能形成团簇，这样CPU域分解出来不平衡，拖累计算速度（不到刚开始的一半）。但是GPU特别是单卡，基本没有这个顾虑。


### 分析
1. [反应分子动力学（ReaxFF）模拟分析软件RMD_Digging](http://bbs.keinsci.com/thread-40775-1-1.html)
1. [利用Lammps ReaxFF研究反应动力学一例:热解乙炔](http://bbs.keinsci.com/thread-38799-1-1.html)
1. [LAMMPS从研一到延毕：ReaxFF反应力场统计产物分子](https://zhuanlan.zhihu.com/p/259646293)
1. []()

### 替代reaxff的方案
1. [Simulation_ReaxFF自建力场](https://warmshawn.github.io/2019/02/21/Simulation_ReaxFF%E8%87%AA%E5%BB%BA%E5%8A%9B%E5%9C%BA/)

### 参考资料
1. [用reaxff势给石墨建模](https://peachrl.github.io/2020/05/01/yong-reaxff-shi-gei-shi-mo-jian-mo/)
1. [利用Lammps ReaxFF研究反应动力学一例:热解乙炔](http://bbs.keinsci.com/thread-38799-1-1.html)
1. []()
1. []()

![](/img/wc-tail.GIF)
