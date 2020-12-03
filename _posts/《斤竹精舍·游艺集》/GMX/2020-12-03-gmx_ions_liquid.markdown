---
layout:     post
title:      "gmx 离子液体"
subtitle:   ""
date:       2020-12-03 08:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2020

---

### 离子液体
1. 模拟离子液体时首先遇到的问题就是离子液体的力场. 文献中用的比较多的是CP&L力场, 基于OPLS-AA发展的, 与OPLS-AA兼容. 这个力场包含了多类离子液体的参数, 就是使用起来不太方便
1. GAFF也可以，但是不能有硼(参考DOI: 10.1021/acs.jpcb.5b00689)

### 参考资料
1. [离子液体CP&L力场参数-jerkwin](https://jerkwin.github.io/2020/05/02/%E5%88%86%E5%AD%90%E6%A8%A1%E6%8B%9F%E5%91%A8%E5%88%8A-%E7%AC%AC_17_%E6%9C%9F/)
1. [离子液体CP&L力场参数-github](https://github.com/agiliopadua)
1. [Ionic Liquid ff example-utkarsk github](https://github.com/utkarsk/Ionic-Liquid)
1. [求助模拟离子液体的分子力场的选择](http://bbs.keinsci.com/thread-14788-1-1.html)
1. [Ionic Liquid ff example-orlandoacevedo github](https://github.com/orlandoacevedo/IL)
1. [GAFF力场模拟离子液体论文](https://pubs.acs.org/doi/10.1021/acs.jpcb.5b00689)

![](/img/wc-tail.GIF)
