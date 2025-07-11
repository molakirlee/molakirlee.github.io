---
layout:     post
title:      "LAMMPS 常用技巧"
subtitle:   ""
date:       2025-06-03 22:12:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2025

---

###### 统一输出文件名
```
# 笔者的习惯，开头先定义basename，之后用诸如${basename}.log使得输出的文件名都保持一致。

variable inname string "in"
variable basename string "pyrolysis"

read_data        ${inname}.data

dump            traj all atom 50000 ${basename}.lammpstrj
log             ${basename}.log
```


![](/img/wc-tail.GIF)
