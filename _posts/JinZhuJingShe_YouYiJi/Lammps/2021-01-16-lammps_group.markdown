---
layout:     post
title:      "LAMMPS 分组group"
subtitle:   ""
date:       2021-01-16 19:12:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2021

---


1. ID为10、25、50以及500到1000（含）: `group sub id 10 25 50 500:1000`
1. 原子id≤50: `group sub id <= 150`
1. MoleculeIdentifier在50到250之间（含）: `group polyA molecule <> 50 250`
1. include style with its arg molecule adds atoms to a group that have the same molecule ID as atoms already in the group: `group hienergy include molecule`
1. All atoms that belong to the first group, but not to any of the other groups are added to the specified group: `group boundary subtract all a2 a3`
1. All atoms that belong to any of the listed groups are added to the specified group: `group boundary union lower upper`
1. Atoms that belong to every one of the listed groups are added to the specified group: `group boundary intersect upper flow`

参考资料: [lammps command reference: group command](https://docs.lammps.org/group.html)



![](/img/wc-tail.GIF)
