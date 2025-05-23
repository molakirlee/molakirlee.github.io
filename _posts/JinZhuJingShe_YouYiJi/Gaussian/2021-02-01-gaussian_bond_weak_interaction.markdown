---
layout:     post
title:      "Gaussian 成键分析·弱相互作用计算"
subtitle:   ""
date:       2021-02-01 20:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Gaussian
    - 2021

---

### 化学键分析

参考：
1. [Multiwfn支持的分析化学键的方法一览](http://sobereva.com/471)
1. [谈谈原子间是否成键的判断问题](http://sobereva.com/414)

##### 键能
参考:
1. [求关于高斯计算具体键的键能的方法](http://bbs.keinsci.com/thread-2102-1-1.html)

###### liyuanhe版
1. 直接从这个键中间劈两半，分别opt freq，注意多重态设定。
1. 就整个结构劈两半，画两个圈，左边圈里原子的坐标粘到一个文件里，右边的粘到另一个文件里，当成初猜算就是了。
1. 要是打断的键不是环上的键，真的就碎成两个了，那就是两边都设2；如果打断了环上的键，整个分子还连着，按说应该还是0，我见别人算过，自己没算过，不清楚这种情况该怎么具体处理，结构上或许应该刻意拉远一点，以及可能涉及波函数初猜的问题？以及分子内的断键如何避免它算成异裂就不会了。

###### sob版

比如计算双氧水O-O键能，T是温度：

1. 对HOOH做opt freq，得到H(T)_HOOH
2. 对OH做opt freq，自旋多重度设2，得到H(T)_OH
3. 键能即2*H(T)_OH - H(T)_HOOH。

想得到更精确的结果建议用热力学组合方法。

上面的方式得到的具体来说是键解离能(BDE)，能和实验热力学数据对比。单纯的理论方式研究键能不需要优化片段，也不用振动分析，只需要整体的单点能减各个片段的单点能就够了，结构都用优化好的整体的结构。

对于打断环上的O-O时，把结构适当调整使两个O远离，此时当做双自由基来算，此时的能量和原本的能量差就是O-O键能。参见：[谈谈片段组合波函数与自旋极化单重态](http://sobereva.com/82)。

但最好还应当考虑调整结构过程造成的其它部分的能量变化，应当设计个过程估算出来从键能中扣除掉。

### 配位键

配位强度，一定程度上可以通过分子表面静电势在相应位置的负极值点数值大小、平均局部离子化能在相应位置的极值点数值，以及考察局部软度来讨论
参考: 
1. [使用Multiwfn的定量分子表面分析功能预测反应位点、分析分子间相互作用](http://sobereva.com/159)
1. [静电势与平均局部离子化能综述合集](http://bbs.keinsci.com/thread-219-1-1.html)
1. 强度的衡量参考:[通过柔性力常数考察键的强度](http://sobereva.com/364)


### 弱相互作用计算

#### 相互作用力分析
计算配合物主体对客体分子之间是否存在相互作用力（氢键等）以及类型、大小。

弱相互作用本质分为两大类：
色散作用：pi-pi堆积、范德华吸引
静电吸引主导，少量色散吸引参与：氢键、二氢键、卤键、pi-氢键、碳键、硫键、磷键等
色散作用起的比重越大，越需要弥散函数、考虑BSSE问题。


泛函和基组的选择看这2篇：
1. [简谈量子化学计算中DFT泛函的选择](http://sobereva.com/272)
1. [谈谈量子化学中基组的选择](http://sobereva.com/336)

###### 计算级别选择
1. 特困：PM6-D3 
1. 穷人：b3lyp-d3/6-31g*
1. 低保：m06-2x-d3 > b3lyp-d3/6-31+g**
1. 小康：m06-2x-d3 > b3lyp-d3/6-311+g**（可用counterpoise改进结果）

根据计算能力和体系大小确定计算级别；
优化和振动分析时完全可采用比计算能量时低1-2个档次的级别来节省时间，详见[浅谈为什么优化和振动分析不需要用大基组](http://sobereva.com/387)；
静电主导的体系在优化时不用带弥散；
优化和振动分析不要用counterpoise；
对于DFT-D3，def2-qzvp最理想（因为是在其基础上拟合的），没必要考虑弥散和BSSE；

###### 基组选择
几何优化：
色散主导：may-cc-pvtz足够理想，6-311+g**一般够用，6-311g**或tzvp也能接受；  
静电主导：tzvp足矣，6-31g**或def2-svp也可以接受。  
对于色散作用占主导的弱相互作用，如果计算能力尚有余裕，相互作用能计算时建议用counterpoise方式处理BSSE问题，所耗时间会是复合物单点计算时间的两倍多。

单电能：
1. 底线：DFT + 6-31+g**或ma-def2-svp；后HF + jun-cc-pvdz
1. 还成：DFT + 6-311+g**；后HF + may-cc-pvtz
1. 不错：DFT + ma-def2-tzvp；后HF + jun-cc-pvtz
1. 较理想：aug-cc-pvtz
1. 极理想：aug-cc-pvqz

1. **如何使用ma-def2**：[给def2以ma-方式加弥散函数的Gaussian格式的基组定义文件（含所有def2支持的元素）](http://sobereva.com/509)

###### 色散校正
1. DFT-D3常用的有零阻尼（EmpiricalDispersion=GD3）和BJ阻尼（EmpericalDispersion=GD3BJ）两种，BJ阻尼较好，但mx06-2x等明尼苏达泛函只能用零阻尼（因为其已经很很好处理中程）.
1. DFT-D3没法体现电子结构的不同对色散作用的影响。例如不能体现激发态和基态的区别、金属处于不同氧化态的区别。准确区分这样的差别适合用XDM、VV10等方法表现色散作用，或用m06-2x等自身能描述色散作用的泛函.
具体参见[DFT-D色散校正的使用](http://sobereva.com/210)

###### BSSE
1. [谈谈BSSE校正与Gaussian对它的处理](http://sobereva.com/46)
为抵消基组误差，在原有相互作用能公式基础上加上E_BSSE（正值）进行修正。

###### 溶剂环境
1. 在气相下做counterpoise，把BSSE校正能加到溶液下算的相互作用能上.或在液相优化的结构上，直接#p  m062x/6-31+g(d,p) counterpoise =2 得到BSSE校正能.
1. 在溶液下算两者间相互作用能，直接复合物的能量减单体能量.

###### 氢键
1. M06-2X-D3(0)/def-TZVP，即`M062X/TZVP EmpiricalDispersion=GD3`，但其实B3LYP-D3(BJ)够了
1. 对于氢键、卤键等静电主导的强度不很弱的作用，用了带弥散的3-Zeta级别的基组后，不做BSSE校正算出来的相互作用能也不错。


###### pi-pi相互作用
1. [谈谈pi-pi相互作用](http://sobereva.com/737)
1. [Pi-stacking](https://en.wikipedia.org/wiki/Pi-stacking#:~:text=Likewise%2C%20pi%2Dteeing%20interactions%20in,partially%20negatively%20charged%20carbon%20atoms.)
1. [Do Special Noncovalent π–π Stacking Interactions Really Exist?](https://onlinelibrary.wiley.com/doi/10.1002/anie.200705157)


###### 其它弱相互作用资料
1. [谈谈“计算时是否需要加DFT-D3色散校正？”](http://sobereva.com/413)  
1. [DFT-D色散校正的使用](http://sobereva.com/210)  
1. [乱谈DFT-D](http://sobereva.com/83)  
1. [大体系弱相互作用计算的解决之道](http://sobereva.com/214)  
1. [Multiwfn支持的弱相互作用的分析方法概览-考察类型、特征、本质](http://sobereva.com/252)  
1. [使用Multiwfn研究分子动力学中的弱相互作用](http://sobereva.com/186)
1. [探究18碳环独特的分子间相互作用与pi-pi堆积特征](http://sobereva.com/572)


### 参考资料
1. [一篇最全面介绍各种弱相互作用可视化分析方法的文章已发表！](http://bbs.keinsci.com/thread-37629-1-1.html)
1. [基组写法及相关知识Gaussian Basis Sets](https://gaussian.com/basissets/)

![](/img/wc-tail.GIF)
