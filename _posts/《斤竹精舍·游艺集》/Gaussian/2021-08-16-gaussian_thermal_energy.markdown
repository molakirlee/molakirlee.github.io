---
layout:     post
title:      "Gaussian 热力学量分析"
subtitle:   ""
date:       2021-08-16 13:51:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Gaussian
    - 2021

---

### gaussian输出说明

```
 Temperature 298.15 Kelvin. Pressure 1.0000 Atm.
  Zero-point correction= 0.029201
  Thermal corection to Energy= 0.032054
  Thermal correction to Enthalpy= 0.032999
  Thermal correction to Gibbs Free Energy= 0.008244
  Sum of electronic and zero-point Energies= -113.837130
  Sum of electronic and thermal Energies= -113.834277
  Sum of electronic and thermal Enthalpies= -113.833333
  Sum of electronic and thermal Free Energies= -113.858087
```


1. Zero-point correction= ZPE
1. Thermal correction to Energy= ZPE + U(0-->T)
1. Thermal correction to Enthalpy= ZPE + H(0-->T)
1. Thermal correction to Gibbs Free Energy= ZPE + G(0-->T)
  
后面四行的四个能量分别为E(0), E, H, G：  
1. E(0) = E(elec) + ZPE = H(0) = U(0)
1. E = E(elec) + E(tot) = E(elec) + ZPE + U(0-->T) = E(0) + E(vib) + E(rol) + E(transl)
1. H = E(elec) + H(corr) = E(elec) + ZPE + H(0-->T) = E + RT
1. G = E(elec) + G(corr) = E(elec) + ZPE + G(0-->T)= H - TS
1. G(corr) = H(corr) - T*S(tot)

![](http://bbs.keinsci.com/forum.php?mod=attachment&aid=NDAxNnxiYTBkZTI2ZXwxNjI5MDk4NjQyfDYxODJ8Mjg3MQ%3D%3D&noupdate=yes)

### 原始方法的热力学量校正
利用freqchk，就可以反复利用不同校正因子得到较准确的ZPE、ΔH和熵，并获得自由能G=H-T*S。freq任务会输出的四个量，为了省事用字母表示，使用不同校正因子时它们都会有变化。

```
 Zero-point correction= A
 Thermal correction to Energy= B
 Thermal correction to Enthalpy= C   注意这一项不是ΔH，而是ZPE+ΔH
 Thermal correction to Gibbs Free Energy= D
```
1. 在ZPE校正因子下得到ZPE（即A）;
1. 然后在熵校正因子下得到-T*S（即D-C）;
1. 之后在ΔH校正因子下得到ΔH（即C-A）;
1. 最终将这三个量加在一起，再加上高精度方法算的电子能量E，就得到了自由能G=E+ZPE+ΔH-T*S。

### 参考资料  
1. [谈谈谐振频率校正因子](http://sobereva.com/221)
1. [Gaussian计算中分子总能量各项的意义及怎样输出基组](http://bbs.keinsci.com/thread-215-1-1.html)
1. [两篇热力学数据计算的入门介绍文章](http://bbs.keinsci.com/thread-123-1-1.html)  
1. [Shermo：计算气相分子配分函数和热力学数据的简单程序](http://sobereva.com/315)  
1. [使用Shermo结合量子化学程序方便地计算分子的各种热力学数据](http://sobereva.com/552)
1. [有关零点能校正的问题](http://bbs.keinsci.com/thread-2871-1-1.html)



![](/img/wc-tail.GIF)
