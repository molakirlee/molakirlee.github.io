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

###### slab体系
![](http://bbs.keinsci.com/forum.php?mod=attachment&aid=NTk5MjJ8ZGVlNTM1YWR8MTcxNzMxNjUwMXwwfDM0MzM%3D&noupdate=yes)
![](http://bbs.keinsci.com/forum.php?mod=attachment&aid=MTAzMjA0fGVhMTk5OTBhfDE3NTkyNTUwNzJ8MHwyMjQ1MQ%3D%3D&noupdate=yes)

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
1. 不控压，就NVT。之前先用NPT把盒子跑平衡（不在npt下计算的原因：npt下所得各个压力分量是通过外界调控所得而不是体系本身表现出来的）。

### 参考资料：
1. [[GROMACS] 界面张力如何计算 ](http://bbs.keinsci.com/thread-3433-1-1.html)
1. [平衡时溶液的表面吸附(doi:10.3866/PKU.WHXB201506191)](https://sci-hub.scrongyao.com/10.3866/PKU.WHXB201506191)


###### 球形体系

第一种：借助压力张量的概念，使用Irving-Kirkwood方法计算得到相应的压力向量法向分量（gromacs是否也可以得到类似的压力向量法向分量？），然后带入公式计算表面张力，具体的细节请见[Irving-Kirkwood方法-球形纳米液滴表面张力的计算](https://zhuanlan.zhihu.com/p/625120353)。
第二种：使用gromacs的energy命令，选择SurfTen，直接得到表面张力的数值，但是sob老师在一个帖子中提到这样得到的表面张力是表面积和表面张力相乘，推荐参照手册中Surface-tension部分直接自行提取压力(见[界面张力如何计算](http://bbs.keinsci.com/thread-3433-1-1.html))；
第三种：使用gromacs的energy命令提取压力，Pxx,Pyy,Pzz，然后使用gromacs手册给出的表面张力计算公式去计算相应的表面张力，但是这个方法好像只适用于界面平行于XY平面的体系。


参考资料：
1. [使用gromacs计算液滴体系表面张力的相关问题](http://bbs.keinsci.com/thread-43172-1-1.html)
1. [gromacs可以模拟液体表面张力吗](http://bbs.keinsci.com/thread-22451-1-1.html)
1. [GROMACS表面张力单位,计算及其长程校正](https://jerkwin.github.io/2014/09/24/GROMACS%E8%A1%A8%E9%9D%A2%E5%BC%A0%E5%8A%9B%E5%8D%95%E4%BD%8D,%E8%AE%A1%E7%AE%97%E5%8F%8A%E5%85%B6%E9%95%BF%E7%A8%8B%E6%A0%A1%E6%AD%A3/)


![](/img/wc-tail.GIF)
