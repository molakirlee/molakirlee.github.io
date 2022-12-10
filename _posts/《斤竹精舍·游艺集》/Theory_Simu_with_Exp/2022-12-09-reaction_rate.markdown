---
layout:     post
title:      "S&T&E 反应速率常数计算"
subtitle:   ""
date:       2022-12-09 00:05:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - S&T&E
    - 2022

---

本文主要参考sob的资料[谈谈如何通过势垒判断反应是否容易发生](http://sobereva.com/506)


###### 能垒 barrier
能垒有多种：
1. 电子能垒：用过渡态结构的电子能量减反应物结构的电子能量。电子能量是指什么这里说了《谈谈该从Gaussian输出文件中的什么地方读电子能量》（http://sobereva.com/488）
1. 焓垒：用过渡态结构的焓减反应物结构的焓。
1. 自由能垒：用过渡态结构的自由能减反应物结构的自由能。

用电子能垒讨论往往可以接受，而且电子能量对自由能有主导性（虽然也有很多例外），但这种做法审稿人答不答应那就难说了，很可能届时会让你补算自由能再重新讨论。显然，当我们计算自由能的时候，你考察什么温度下的反应，自由能就应当在什么温度下计算，而使用0K下的自由能（等价于0K下的内能和焓，也等于电子能量加上ZPE）来讨论是没有什么实际意义的。

###### 反应速率常数k及活化能$E_a$
目前最常用，也比较省事的预测反应速率常数k的方法是Eyring的过渡态理论(transition state theory, TST)，它可以写为基于配分函数的形式和基于热力学量的形式。

**这个$k_{TST}$跟实验测得的k是两回事，计算所用的自由能跟Arrhenius方程里的活化能也是两回事。**  

阿伦尼乌斯公式$k=A*exp(-E_a/RT)$只是一个k随T变化的经验、宏观层面上的公式，其中的A和$E_a$都只是根据理论或实验得到的k随T的变化而拟合得到的，不要和过渡态理论混淆，过渡态理论才是直接算出k的方法。基元反应的$E_a$和$\Delta G_0$虽关系密切，有相似的物理意义，但来源完全不同。而对于多步反应，每步都能算出一个$\Delta G_0$，但根据阿仑尼乌斯公式拟合出的则是一个整体的宏观的$E_a$。(参见[使用KiSThelP结合Gaussian基于过渡态理论计算反应速率常数](http://sobereva.com/246))

[Transition state theory (Wiki)](https://en.wikipedia.org/wiki/Transition_state_theory)是这么说的Because the functional form of the Eyring and Arrhenius equations are similar, it is tempting to relate the activation parameters with the activation energy and pre-exponential factors of the Arrhenius treatment. However, the Arrhenius equation was derived from experimental data and models the macroscopic rate using only two parameters, irrespective of the number of transition states in a mechanism. In contrast, activation parameters can be found for every transition state of a multistep mechanism, at least in principle.

The free energy of activation, $\Delta G^{\ddagger}$, is defined in transition state theory to be the energy such that $\Delta G^{\ddagger } = -RTlnK^{\ddagger}$ holds（利用化学势推导，具体参见[Equilibrium constant (Wiki)](https://en.wikipedia.org/wiki/Equilibrium_constant)）. The parameters $\Delta H^{\ddagger}$ and $\Delta S^{\ddagger}$ can then be inferred by determining $\Delta G^{\ddagger} = \Delta H^{\ddagger} - T\Delta S^{\ddagger}$ at different temperatures.

TST理论中：
1. $\Delta H^{\ddagger}$与$E_a$相关：Although the enthalpy of activation, $\Delta H^{\ddagger}$, is often equated with Arrhenius's activation energy $E_a$, they are not equivalent. For a condensed-phase (e.g., solution-phase) or unimolecular gas-phase reaction step, $Ea = \Delta H^{\ddagger} + RT$. For other gas-phase reactions, $E_a = \Delta H^{\ddagger} + (1 - \Delta n^{\ddagger})RT$, where $\Delta n^{\ddagger}$ is the change in the number of molecules on forming the transition state. (Thus, for a bimolecular gas-phase process, $E_a = \Delta H^{\ddagger} + 2RT$.)
1. $\Delta S\ddagger$与指前因子A有关. For a unimolecular, single-step process, the rough equivalence $A = (k_BT/h) exp(1 + \Delta S^{\ddagger}/R)$ (or $A = (k_BT/h) exp(2 + \Delta S^{\ddagger}/R$) for bimolecular gas-phase reactions) holds. For a unimolecular process, a negative value indicates a more ordered, rigid transition state than the ground state, while a positive value reflects a transition state with looser bonds and/or greater conformational freedom.

活化能并非只能通过阿仑尼乌斯公式拟合。利用动力学模拟，对任何动态过程（如扩散）等也可以计算活化能，比如计算扩散过程的活化能（the activation energy for water diffusion is found to be $E_{a,D} = 3.48 \pm 0.16$ kcal/mol, in excellent agreement with $E_{a,D} = 3.49 \pm 0.20$ kcal/mol derived from an Arrhenius analysis），见[J. Phys. Chem. A, 123, 7185 (2019)](https://pubs.acs.org/doi/full/10.1021/acs.jpca.9b03967)。



###### 基于过渡态理论的反应速率常数$k_{TST}$
sob在[基于过渡态理论计算反应速率常数的Excel表格](http://sobereva.com/310)里

自由能垒（过渡态与反应物的自由能之差），或者反应物和过渡态的配分函数填进去，并且填入反应温度T、反应路径简并度σ和透射系数κ就可以得到反应速率常数


![](/img/wc-tail.GIF)
