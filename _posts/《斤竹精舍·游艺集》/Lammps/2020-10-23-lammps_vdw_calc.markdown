---
layout:     post
title:      "LAMMPS 计算范德华相互作用能"
subtitle:   ""
date:       2020-10-23 21:06:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### 

```
compute vdwcalc all pair lj/cut evdwl
variable t equal step
variable VDW_system equal c_vdwcalc
fix vdwo all print 1 "$t ${VDW_system}" file VDW_of_System.dat screen no
run 10
unfix vdwo
```


### 参考资料
1. [compute pair command](https://lammps.sandia.gov/doc/compute_pair.html)


![](/img/wc-tail.GIF)
