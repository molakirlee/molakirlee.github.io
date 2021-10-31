---
layout:     post
title:      "aspen 收敛"
subtitle:   ""
date:       2021-10-31 13:59:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - aspen
    - 2021


---


###### 收敛方法
1. Wegstein方法：仅用于撕裂流股（Tear stream），是Aspen内默认的计算撕裂流的收敛方法。但该方法没有考虑变量之间的Interaction，所以对于变量之间有强烈耦合时并不适用。
1. Direct：收敛速度慢但很准确。the new value of the tear stream variable is the value resulting from the previous flowsheet calculation pass.
1. Newton:适用于循环Loop或设计规定highly interrelated的情况。可以用于同时计算撕裂流和设计规定。
1. Secant:只用于single design specification。
1. Broyden:可用于multiple tear streams and design specifications。
1. SQP:用于优化flowsheet（with constraints and tear streams）。




![](/img/wc-tail.GIF)
