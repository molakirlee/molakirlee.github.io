---
layout:     post
title:      "Gaussian 泛函与基组的选择"
subtitle:   ""
date:       2023-03-29 22:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Gaussian
    - 2023

---

### 泛函选择

1. [简谈量子化学计算中DFT泛函的选择](http://sobereva.com/272)
1. [谈谈量子化学研究中什么时候用B3LYP泛函优化几何结构是适当的](http://sobereva.com/557)
1. [坚持使用B3LYP算有机体系的人的下场](http://bbs.keinsci.com/thread-12773-1-1.html)：用M06-2X算有机体系极为推荐，B3LYP算有机体系早该淘汰了；鼓励使用def或def2基组代替尺寸相近的Pople基组。
1. [B3LYP-gCP-D3BJ在Gaussian 09中的关键字](http://bbs.keinsci.com/thread-1990-1-1.html)


### 基组选择

1. 对几何优化和振动分析不需要大基组，比如def2-SVP一般就够满足需要了，除非精度要求颇高，但是这绝对不意味着可以偷工减料到使用连重原子的极化都没有的6-31G之流。还要注意的是，不同体系对基组的敏感性是有差异的，比如优化过渡金属的配位键键长，def2-SVP和def2-TZVP的结果差异往往挺明显。
1. 对于一般问题没有必要给氢加极化，但是和氢有密切相关的问题则应当给氢加极化。
1. 由于给氢加p极化对耗时增加其实不算太多（相对于给重原子增加高角动量极化函数而言），因此有必要给氢加p极化时不要吝啬，即起码用def2-SVP或6-31G**这个档。再看超恶心的连重原子的极化都没有的6-31G，误差比def2-SV(P)又明显进一步增大，键能误差已经快100kJ/mol了。
1. 对比def-TZVP和def2-TZVP的结果，虽然后者比前者昂贵很多（很大程度上是因为对F加了f极化所致），但是各方面精度都差不太多，因此def2-TZVP无福消受时用def-TZVP是很好选择。



1. [谈谈量子化学中基组的选择](http://sobereva.com/336)
1. [浅谈为什么优化和振动分析不需要用大基组](http://sobereva.com/387)
1. [谈谈赝势基组的选用](http://sobereva.com/373)
1. [使用Gaussian做镧系金属配合物的量子化学计算](http://sobereva.com/581)
1. [计算化学键键能时考虑BSSE不仅是多余的甚至是有害的](http://sobereva.com/381)





![](/img/wc-tail.GIF)
