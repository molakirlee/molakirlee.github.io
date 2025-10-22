---
layout:     post
title:      "GAMS pyomo gamspy 安装及介绍"
subtitle:   ""
date:       2024-12-13 20:06:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GAMS
    - 2024

---

### Pyomo
###### GAMS和Pyomo区别
1. 求解难易度和方程个数无关，和离散变量个数、方程非线性程度有关
1. 离散变量少但方程非线性程度高，pyomo的sip求解器合适（虽然相同条件下GAMS更强）
1. 离散变量多但方程非线性程度不高(比如换热网络、氢气网络、精馏序列)，GAMS的baron合适
1. 离散变量多且方程非线性程度高，两者都不理想


###### 安装
```
conda install -c conda-forge pyomo
conda install -c conda-forge ipopt=3.11.1
conda install -c conda-forge glpk
```

1. [Pyomo Installation](https://pyomo.readthedocs.io/en/6.8.0/installation.html)




### Gamspy
1. 版权：学术免费（GAMSPy comes with a demo license. If you have an academic email, you can just go to academic.gams.com and get your license for free. All open source solvers and most commercial solvers are free with the academic license, https://gams.com/academics/）
1. 典型示例: [https://github.com/GAMS-dev/gamspy-examples/blob/master/models/trnsport/trnsport.py](https://github.com/GAMS-dev/gamspy-examples/blob/master/models/trnsport/trnsport.py)
1. gamspy v.s. pyomo: What are the differences between GAMSpy and Pyomo when using the same solver? GAMSPy is much faster than Pyomo in general and has a more convenient syntax. You can see the difference here: https://gamspy.readthedocs.io/en/latest/user/whatisgamspy.html#why-is-gamspy-fast
1. gamspy v.s. scipy: GAMSPy supports more than 30 different solvers. You write your model once and you can send it to many solvers. You can turn your GAMSPy model into LaTeX format if you want to use it in your paper. There are many more features that gamspy support and scipy doesn't. You can check our documentation for more details (python script): [https://gamspy.readthedocs.io/en/latest/user/examples.html](https://gamspy.readthedocs.io/en/latest/user/examples.html) You can just click to "Open in Colab" and execute it on Google Colab.
1. Q: How are the upper and lower bounds for the objective function retrieved in Gamspy? Gamspy always provides these bounds regardless of the solver. (Even if the solver does not provide these bounds). A:You can print "<name_of_your_objective_variable>.records"
1. Q:Where can I find more resources about EMP in Gamspy? A: EMP models are still something we are working on. You can implement EMP models in GAMSPy but it's not as convenient as we like at the moment. You can find EMP examples at: https://github.com/GAMS-dev/gamspy-examples



![](/img/wc-tail.GIF)
