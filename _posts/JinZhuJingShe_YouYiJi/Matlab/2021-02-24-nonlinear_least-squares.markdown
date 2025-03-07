---
layout:     post
title:      "Matlab 最小二乘法"
subtitle:   ""
date:       2021-02-24 20:22:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Matlab
    - 2021


---

### 参考资料
1. [MATLAB 非线性最小二乘拟合 lsqnonline 和 lsqcurvefit](https://www.cnblogs.com/pupilLZT/p/13379691.html)
1. [数据拟合——非线性最小二乘法](https://zhuanlan.zhihu.com/p/83320557)

### 传参
因为有些函数需要额外的参数，具体参见[传递额外参数](https://ww2.mathworks.cn/help/optim/ug/passing-extra-parameters.html)或[遗传算法GA如何传递额外的参数](https://www.ilovematlab.cn/thread-583362-1-1.html),，推荐使用匿名函数，因为全局变量有时会有问题。

![](/img/wc-tail.GIF)
