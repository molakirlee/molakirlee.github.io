---
layout:     post
title:      "gmx 分子间相互作用分析"
subtitle:   ""
date:       2025-05-18 19:15:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2025

---

1. 在LAMMPS软件中，可以支持各种拉伸/剪切/压缩方式，也可以对金属等材料经行非常高精度的应力应变模拟。但是LAMMPS对于有机分子/聚合物来说比较麻烦，因为很多用户被困在了LAMMPS繁琐的有机分子/聚合物建模的截断。
1. 对于GROMACS，建立有机分子/聚合物的输入文件是非常简单的，所以可以采用GROMACS来计算有机分子/聚合物的拉伸/剪切/压缩情况。目前，GROMACS只支持deform方式对模拟盒子进行形变。


###### 具体计算流程

1. 建立有机分子/聚合物模型，使用NPT系综在目标温度和压强下充分弛豫（这一步是做形变之前必须的）    
2. 在mdp文件里面添加或者修改控压算法下面的关键字，即可实现拉伸/剪切/压缩模拟：    
```
pcoupl    =  Parrinello-Rahman
pcoupltype  = anisotropic  
tau_p    = 1.0    
ref_p    = 1.0 1.0 1.0 1.0 1.0 1.0    
compressibility = 4.5e-5 4.5e-5 0.0  4.5e-5   4.5e-5  4.5e-5  ;
deform = 0.0 0.0 0.001 0.0 0.0 0.0
```
   
这里的控压算法采用的是Parrinello-Rahman，也可以使用Berendsen。压力耦合方式是使用各项异性（anisotropic ），由于压力张量有6个分量，所以参考压力（ref_p）需要写6个值。分别对应：别对应 xx， yy， zz，xy/yx，xz/zx和yz/zy分量。压缩率（compressibility）也和6个分量一一对应，但是对于需要拉伸/剪切/压缩的方向对应值一定要设置为0。拉伸/剪切/压缩的方向由deform的值确定，如上述参数设置的即在zz方向上以正速度（即：0.001nm/ps）单轴拉伸材料。所以，压缩率（compressibility）的第三个值随之设置为0。    

3. 如果想实现压缩，把deform中的0.001改为-0.001，即为对z轴进行压缩。也可以对其他轴进行压缩或者拉伸。    
4. 基于上述设置，我们可以很灵活的实现拉伸/剪切/压缩。注：拉伸/剪切/压缩等速率根据自己的体系进行测试，不一定非要设置为本案例的0.001nm/ps。      


### 剪切
如果想实现剪切，比如往x和y方向剪切，那么相应的设置如下即可：    
```
pcoupl    =  Parrinello-Rahman
pcoupltype  = anisotropic  
tau_p    = 1.0    
ref_p    = 1.0 1.0 1.0 1.0 1.0 1.0    
compressibility = 0.0 0.0 4.5e-5  4.5e-5   4.5e-5  4.5e-5  ;
deform = 0.001 0.001 0.0 0.0 0.0 0.0
```

   

### 能量计算
对于GROMACS来说，可以使用gmx energy提取各个方向的应力随模拟时间变化数据，从而结合我们的拉伸速率绘制应力应变曲线（如文献：https://doi.org/10.3390/nano12193379），但是该命令计算的应力不是那么严谨，可以通过文献：Soft Matter, 2016, 12, 3972所提到的方式进行计算。也可以使用修改版本的gromacs来计算，相关教程见：https://vanegaslab.org/software （GROMACS-LS and MDStress library）。    

### 参考资料
1. [GROMACS拉伸、剪切、压缩模拟](https://www.fangzhenxiu.com/post/10989016/)

![](/img/wc-tail.GIF)
