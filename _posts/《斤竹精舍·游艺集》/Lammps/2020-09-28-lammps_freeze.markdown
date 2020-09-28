---
layout:     post
title:      "LAMMPS中freeze"
subtitle:   ""
date:       2020-09-28 22:23:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

###### [fix setforce](https://lammps.sandia.gov/doc/fix_setforce.html)
使用`fix setforce` 可以实现对组的冻结：

```
fix freeze indenter setforce 0.0 0.0 0.0
```

![](/img/wc-tail.GIF)
