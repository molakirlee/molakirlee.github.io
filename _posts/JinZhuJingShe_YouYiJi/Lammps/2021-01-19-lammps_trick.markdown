---
layout:     post
title:      "LAMMPS 教程+常用技巧"
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

###### 视频资料
1. [60分钟 实现LAMMPS素人逆袭：金属材料拉伸](https://www.bilibili.com/video/BV1YK4y1k7dX/?spm_id_from=333.337.search-card.all.click&vd_source=42d15d5f7bb7814555b23126c5a774fb)
1. [聚合物的LAMMPS分子动力学教学：建模+软势+退火+MSD扩散系数+压缩拉伸力学性能+链取向分析(Materials Studio、CharmmGUI建模)](https://www.bilibili.com/video/BV1zC4y1U7MU/?spm_id_from=333.337.search-card.all.click&vd_source=42d15d5f7bb7814555b23126c5a774fb)
1. [LAMMPS+VMD+Python：聚合物“交联”+石墨稀表面接枝，拉伸力学性能、聚合物链取向](https://www.bilibili.com/video/BV1uPpMeXE5t?spm_id_from=333.788.videopod.sections&vd_source=42d15d5f7bb7814555b23126c5a774fb)
1. [LAMMPS建模与MD分析教学 高熵合金、多晶、石墨烯、聚合物、复合材料建模，分子动力学MD轨迹分析](https://www.bilibili.com/video/BV1Xg4y1G7RL?spm_id_from=333.788.videopod.sections&vd_source=42d15d5f7bb7814555b23126c5a774fb)

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
