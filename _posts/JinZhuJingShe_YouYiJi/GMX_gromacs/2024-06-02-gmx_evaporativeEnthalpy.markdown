---
layout:     post
title:      "gmx 蒸发焓"
subtitle:   ""
date:       2024-06-02 16:24:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2024


---

![](http://bbs.keinsci.com/forum.php?mod=attachment&aid=NjI5NzF8YjJkNmIwN2N8MTcxNzMxMzYzOHwwfDM1MzA1&noupdate=yes)


1.气相下的模拟就是一个盒子里吗只放一个链烃吗？【是】
2.液相下是同样大小的盒子里面放多个链烃吗?【是。具体来说，你先算凝聚相的烷烃，之后用同等尺寸的盒子去模拟单个烷烃】
3.每摩尔分子的平均势能就是模拟过后用gmx energy里面potential的选项吗？【是，但必须带着-nmol [体系里分子数]】
4. RT代表什么含义呢？【理想气体近似下PV=nRT。当前n=1】


### 参考资料：
1. [[GROMACS] Gromacs蒸发焓计算求助](http://bbs.keinsci.com/thread-35305-1-1.html)


![](/img/wc-tail.GIF)
