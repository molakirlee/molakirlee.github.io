---
layout:     post
title:      "gmx 熵计算"
subtitle:   ""
date:       2025-10-05 22:12:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2025


---

1. 使用`gmx anaeig`计算熵时，会输出Schlitter's formula and QH analysis 两种方法的结果，但是在release-2024之前两种方法的结果可能会相差一个数量级，问题出在QH法上，新版本已修复，具体参见["Entropy calculation with gmx anaeig: inconsistent results with QH analysis"](https://gitlab.com/gromacs/gromacs/-/issues/5041#:~:text=Specifically%2C%20gmx%20anaeig%20%2Dentropy%20outputs,to%20an%20order%20of%20magnitude.)
1. Pathum M Weerawarna建议在分析蛋白的熵时只分析骨架，且通过分段分析的方式判断是否收敛，具体参见["How can I calculate configurational entropy along the complete trajectory of gromacs?"](https://www.researchgate.net/post/How_can_I_calculate_configurational_entropy_along_the_complete_trajectory_of_gromacs)
1. Q:我发现不管是MMPBSA还是另一类炼金术自由能计算方法计算结合自由能时，其中得到的熵（-TS）都是指的两个溶质结合过程的熵变，而计算的溶剂化自由能分为极性和非极性，里面是否包含了溶剂的熵变？有没有办法计算溶剂的熵变？ A from Sob:溶剂模型的非极性部分已经包含了溶剂的熵效应，因此求差得到的溶解自由能的变化里已经体现了结合过程中溶剂的熵变效应. 具体参见["分子动力学模拟如何计算溶剂的熵变"](http://bbs.keinsci.com/thread-50241-1-1.html)


1. [GROMACS用Schlitter方法算熵总会出现-nan(ind) ](http://bbs.keinsci.com/thread-20366-1-1.html)
1. [求助：gromacs计算体系的熵和焓随反应坐标的变化](http://bbs.keinsci.com/thread-17078-1-1.html):Q:1、如何计算体系随反应坐标变化的△H和-T△S？2、如何将△H或-T△S分解到体系中各单体分子？ A from sob: 
1 大抵是定义一个特殊的坐标ξ，把动力学每一帧都投影到ξ上，对落在每个ξ小区间内的帧，都按照标准的计算H、G、S的公式进行计算（例如U、H就是分别对这些帧的势能、势能+PV取时间平均）2 估计是用gromacs的energy. group功能，把势能分解成不同组分间的相互作用. ![](http://bbs.keinsci.com/forum.php?mod=attachment&aid=MzQyOTB8NWRmOWI5OTV8MTc1OTc4MTEwOXwwfDE3MDc4&noupdate=yes)
1. []()

其它参考：
1. [gmx anaeig: 分析简正模式](https://jerkwin.github.io/GMX/GMXprg/#gmx-anaeig-%E5%88%86%E6%9E%90%E7%AE%80%E6%AD%A3%E6%A8%A1%E5%BC%8F%E7%BF%BB%E8%AF%91-%E6%9D%8E%E7%BB%A7%E5%AD%98)
1. []()

![](/img/wc-tail.GIF)
