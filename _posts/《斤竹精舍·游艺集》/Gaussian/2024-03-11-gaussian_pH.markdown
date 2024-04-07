---
layout:     post
title:      "Gaussian pH"
subtitle:   ""
date:       2024-03-11 23:18:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Gaussian
    - 2024

---

### [Calculation of pH dependence for small molecules](https://mattermodeling.stackexchange.com/questions/9602/calculation-of-ph-dependence-for-small-molecules?noredirect=1&lq=1)
No quantum chemistry program can directly give the dominant forms of a molecule under different pHs, but only Gibbs free energies of the relevant species, because it is trivial to calculate the pKa and then the pH dependence of the dominant form of your molecule from the Gibbs free energy data by hand.

1. calculate Gibbs free energies of the relevant species;
1. convert the pKa values to Ka values (equilibrium constants), and the pH value to [H+];
1. use the definition of the equilibrium constants to calculate the ratios of the different species;
1. converted the ratios to the relative proportions of each species with respect to all species;
1. If the one is the largest, it is the dominant form at the given pH;

#### 酸碱pK
1. [怎样计算一个有机分子中质子供体的酸性和质子受体的碱性?](http://bbs.keinsci.com/thread-19043-1-1.html)
1. [使用Multiwfn的定量分子表面分析功能预测反应位点、分析分子间相互作用](http://sobereva.com/159)


![](/img/wc-tail.GIF)
