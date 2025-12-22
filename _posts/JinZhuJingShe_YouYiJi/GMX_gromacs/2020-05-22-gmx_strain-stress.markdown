---
layout:     post
title:      "gmx 应力应变分析"
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

1. LAMMPS可以对聚合物、金属等材料进行各种拉伸/剪切/压缩等应力应变模拟。对于聚合物等有机分子体系，同样也可以采用GROMACS进行（当前只支持deform方式，通过对box进行形变实现应力应变模拟）。


###### 拉伸/压缩

1. 建立聚合物分子模型，构建模拟体系，在目标温度和压力的NPT下充分弛豫（做形变之前必须，以免爆炸）    
2. mdp文件修改压力控制内容，并增加拉伸/剪切/压缩模拟所需内容：    
```
pcoupl    =  Parrinello-Rahman
pcoupltype  = anisotropic  
tau_p    = 1.0    
ref_p    = 1.0 1.0 1.0 1.0 1.0 1.0    
compressibility = 4.5e-5 4.5e-5 0.0  4.5e-5   4.5e-5  4.5e-5  ;
deform = 0.0 0.0 0.001 0.0 0.0 0.0
```
   
其中，压力控制算法采用Parrinello-Rahman（也可使用Berendsen）。压力耦合采用各项异性anisotropic ，因为压力张量有6个分量所以参考压力ref_p的6个值分别对应xx/yy/zz/xy/yx/xz/zx/yz/zy分量。压缩率compressibility同样与6个分量对应（**需要拉伸/剪切/压缩的方向对应值要设置为0**）。需要拉伸/剪切/压缩的方向由deform的值确定，非形变方向为0。上述示例为在zz方向上以正速度0.001nm/ps发生单轴拉伸（具体速率依据自己体系进行测试），所以compressibility在zz方向的值为0。    

3. 同理，如果想实现压缩过程，可以把deform中的0.001改为-0.001，即沿z轴方向进行压缩。    


### 剪切
以沿x和y方向剪切为例：    
```
pcoupl    =  Parrinello-Rahman
pcoupltype  = anisotropic  
tau_p    = 1.0    
ref_p    = 1.0 1.0 1.0 1.0 1.0 1.0    
compressibility = 0.0 0.0 4.5e-5  4.5e-5   4.5e-5  4.5e-5  ;
deform = 0.001 0.001 0.0 0.0 0.0 0.0
```

   

### 能量计算
1. 方法1：使用gmx energy提取各个方向的应力随模拟时间变化，结合拉伸速率绘制应力应变曲线，效果可参考文献[Molecular Dynamics Simulations on the Elastic Properties of Polypropylene Bionanocomposite Reinforced with Cellulose Nanofibrils](https://doi.org/10.3390/nano12193379)。在此基础上，可参考[Molecular dynamics simulations of uniaxial deformation of thermoplastic polyimides](https://doi/10.1039/C6SM00230G)。
1. 方法2：使用[GROMACS-LS and MDStress library](https://vanegaslab.org/software)。GROMACS-LS and the MDStress library enable the calculation of local stress fields from molecular dynamics simulations.



![](/img/wc-tail.GIF)
