---
layout:     post
title:      "gmx 虚拟退火simulated annealling"
subtitle:   ""
date:       2020-04-26 10:22:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2020

---

###### 关于退火
ref-t是参考温度，热浴是指控温的算法，退火模拟不需要设置ref-t但需要设置热浴。应当溶剂和蛋白分别控温，否则容易造成热溶剂冷溶质现象，达不到想要的目的。

```
tcoupl           = v-rescale ; 
tc-grps          = Protein Non-Protein ; 
tau_t            = 0.1     0.1 ; 
;ref_t            = 298.15  298.15    ; 
;annealing
annealing = single single ; single or periodic
annealing-npoints = 5 5
annealing-time = 0 5000 5000 5000 5000 0 5000 5000 5000 5000 ; ps
annealing-temp = 273.15 288.15 277.15 298.15 310.15 273.15 288.15 277.15 298.15 310.15 ; K
```


![](/img/wc-tail.GIF)
