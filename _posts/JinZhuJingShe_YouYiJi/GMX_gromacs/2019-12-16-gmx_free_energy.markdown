---
layout:     post
title:      "gmx 自由能计算"
subtitle:   ""
date:       2019-12-16 21:25:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2019

---

参考资料：
1. [GROMACS教程：自由能计算：水中的甲烷](https://jerkwin.coding.me/GMX/GMXtut-6/#%E6%A6%82%E8%BF%B0)
1. [教程翻译----使用GROMACS计算乙醇分子溶剂化自由能](https://liuyujie714.com/44.html)
1. [Gromacs结合自由能计算教程-筱朗](https://zhuanlan.zhihu.com/p/60963446)
1. [Introduction to free energy and cases- gmx 3.1](http://compbio.biosci.uq.edu.au/education/Free-Energy_Course/0.introduction.html)
1. [[文献推荐] 结合自由能计算：MD vs. QM](http://bbs.keinsci.com/thread-13377-1-1.html)
 
### 原理
[Free Energy Calculations - TEXAS](http://biomachina.org/courses/modeling/091.pdf)

### 蛋白与水之间的结合能 
跟李老师的对话：  
Q:求问如果计算蛋白跟水的结合自由能的话是不是可以用mmpbsa然后只取mm部分呢？还是说也需要像甲烷水那样用热力学积分的方法呢？  
A:你要先清楚算什么自由能，是和单个水分子的作用自由能，还是溶剂化能。如果是前者，那mm部分只是作用能，没有熵的贡献，而且具体还和水分子的位置有关  
Q:是想评价一下两个蛋白和水结合的能力，老师，因为算出来氢键数一致，不知道强度有没有差别，您觉得对于这种需求的话哪一种合适呢？另外，您刚才的解释里面，关于熵的理解了，和水分子位置有关是指什么呢？两个方法中水不都是自由运动的吗，老师？  
A:你算溶剂化能就好了, 用自由能的方法算只能处理小蛋白（看你的机器, 一般一百个残基之内吧）, 但精确, mmpbsa可以处理大蛋白, 但不太准确。

###### 简正分析(eigenvectors)
[Manual-gmx anaeig](http://manual.gromacs.org/documentation/2018/onlinehelp/gmx-anaeig.html)
`gmx anaeig`

###### TPI方法
参考资料：
1. [Excess chemical potential of methane using test particle insertion](https://www.svedruziclab.com/tutorials/gromacs/6-tpi/)

### 几种方法的比较
###### researchgate
In general no, MM/PBSA does not give more accurate binding free energy -- in fact quite the opposite. ABF and FEP are more rigorous free energy methods that formally give you the "exact" free energy for the force field in the limit of infinite sampling. MM/PBSA does not (at times not even close).  In fact, MM/PBSA is notoriously bad for absolute binding free energies unless done very carefully with numerous corrections. It is almost always used to estimate relative binding free energies of related systems.
By contrast, FEP gives you quite accurate free energies as long as you do the calculations well (i.e., if you have enough lambda windows and enough sampling for each window, maybe using a soft-core vdW potential if necessary). It is, however, a much more expensive technique that takes much longer to get a converged answer than MM/PBSA (which explains MM/PBSA's popularity).
ABF is quite different than either of the other two methods. It is a free energy method based on a reaction coordinate -- in the same family as umbrella sampling, steered MD, or metadynamics.  So what you get is technically a PMF (potential of mean force), which is basically a reduced-dimensionality energy surface -- a kind of free energy along a path.  Comparing it to end-state, path-independent methods like FEP, thermodynamic integration (TI) or MM/PBSA does not always make sense.

###### PMF比隐式溶剂模型准确
1. [PNAS - Calculation of absolute protein–ligand binding free energy from computer simulations](https://www.pnas.org/content/pnas/102/19/6825.full.pdf)
2. [Calculation of Absolute Protein-Ligand Binding Affinity Using Path and Endpoint Approaches](https://core.ac.uk/download/pdf/82377825.pdf)

###### FMAP
1. [Nature Protocols 计算配体结合自由能的新工具FMAP](https://www.wecomput.com/nature-protocols-a-new-tool-for-calculating-ligand-binding-free-energy-fmap/)
1. [FMAP新闻](https://www.sohu.com/a/422998736_120335697)

### 其他相关阅读
1. [杂谈自由能计算，PMF，伞形抽样，WHAM](http://bbs.keinsci.com/thread-13225-1-1.html)
1. [接上：从文献中总结的三种PMF计算方法](http://bbs.keinsci.com/thread-13969-1-1.html)

![](/img/wc-tail.GIF)
