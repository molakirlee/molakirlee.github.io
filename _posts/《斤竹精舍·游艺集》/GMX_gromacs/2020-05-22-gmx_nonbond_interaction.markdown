---
layout:     post
title:      "gmx 分子间非键相互作用力分析"
subtitle:   ""
date:       2020-05-03 19:15:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2020

---

参考资料：
1. [使用GROMACS计算分子间相互作用](https://jerkwin.github.io/2019/09/06/%E4%BD%BF%E7%94%A8GROMACS%E8%AE%A1%E7%AE%97%E5%88%86%E5%AD%90%E9%97%B4%E7%9B%B8%E4%BA%92%E4%BD%9C%E7%94%A8/)
1. [提取 GMX 轨迹中两个 group 之间的静电和范德华相互作用](https://blog.chembiosim.com/extract-vdw-elec-in-gmx/)
1. [《平均力势----以石墨烯-甘氨酸体系为例》附录部分](https://liuyujie714.com/41.html)

步骤：
1. 分别提取分子A、分子B和分子A-B的xtc轨迹及gro文件；
1. 利用gro文件生成分子A、分子B和分子A-B的tpr文件；（理论上可以通过convet-tpr实现，但可能因为原tpr中能量组、温度组等的设置而出现问题，所以建议重新生成tpr文件）
1. 利用xtc来-rerun分子A、分子B和分子A-B的tpr，命令如：`gmx mdrun -v -deffnm lys -rerun lys.xtc`；
1. 将分子A-B的LJ(SR)+Coulomb(SR)+LJ.Disp+Coulomb.recip减去分子A和分子B的。



![](/img/wc-tail.GIF)
