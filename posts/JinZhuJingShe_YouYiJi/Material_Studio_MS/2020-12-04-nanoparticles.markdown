---
layout:     post
title:      "MS 纳米颗粒模拟"
subtitle:   ""
date:       2020-12-04 13:31:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - MS
    - 2020

---


### 注意事项
使用COMPASS力场模拟金属纳米颗粒时Nanoparticles，要注意：  
1. 不要使用默认指定力场的方式，选中Nanoparticle中的原子指定好力场，因为默认指定的力场未必可行；
2. 如果没有使用默认指定力场，则其他分子计算也不会自动指定力场，故也需要对其他分子指定力场（可使用自动指定的方式）；
3. 一定要先对单个分子进行优化，要不后面直接做的话Nanoparticle会爆炸。


![](/img/wc-tail.GIF)
