---
layout:     post
title:      "gmx 界面张力"
subtitle:   ""
date:       2024-06-02 16:10:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2024


---

![](http://bbs.keinsci.com/forum.php?mod=attachment&aid=NTk5MjJ8ZGVlNTM1YWR8MTcxNzMxNjUwMXwwfDM0MzM%3D&noupdate=yes)

1. 体系界面需要垂直于Z方向，模拟一定时间.
1. 根据下式计算（不是用平均压力，而是把每一帧的压力分量代入式子，然后再对结果取平均）:γ=(1/n)*Lz*<P_zz-(P_xx+P_yy)/2>
1. 其中，n代表体系的界面数，比如一层水上下都是空气的体系n=2。Lz是盒子Z方向的长度。<>代表取时间平均。γ一般是mN/m单位，即毫牛每米。P_xx/yy/zz是各方向的压强。
1. 对于gmx，Lz以nm为单位，g_energy输出的P_xx/yy/zz以bar为单位。1bar=100000N/m^2=1D8 N/m^2，1nm=1D-9 m，因此把gmx的数值代入后，除以10就得到了nN/m单位下的表面张力

注：
1. 可以先算个水+气的表面张力确认过程无误。
1. 液体可压缩系数很小，压力波动很大很正常。
1. pcoupltype不用选择surface-tension。
1. 先用NPT把盒子跑平衡，然后NVT就可以，不控压，不用semiisotropic
1. 要么取平均z轴长度，要么先NPT平衡后再改用NVT。对于气液界面体系，一般都用NVT或者让z方向可压缩系数为0，所以不存在z方向长度的含糊性

### 参考资料：
1. [[GROMACS] 界面张力如何计算 ](http://bbs.keinsci.com/thread-3433-1-1.html)
1. [平衡时溶液的表面吸附(doi:10.3866/PKU.WHXB201506191)](https://sci-hub.scrongyao.com/10.3866/PKU.WHXB201506191)

![](/img/wc-tail.GIF)
