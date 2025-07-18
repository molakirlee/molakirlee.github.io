---
layout:     post
title:      "Gaussian 自旋多重度"
subtitle:   ""
date:       2021-12-02 23:12:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Gaussian
    - 2021

---

### 自旋多重度
###### 如何判断体系的自旋多重度?
1. 基态的自旋多重度应根据经验、相关理论判断。如果自旋多重度设错,相当于计算的是激发态.
1. 普通有机分子、生物分子等,必无单电子,是闭壳层,自旋多重度为1.
1. 其它普通分子、自由基,大多是自旋多重度越低越稳定。但也有特例,如一部分卡宾、氧气都是三重态最稳定,这是由于轨道存在简并,根据Hund规则电子以自旋平行占据能里最低.
1. 含过金属的体系自旋多重度情况复杂,可以根据已有文献中类似的体系、晶体场理论等估计是高自旋还是低自旋稳定.
1. 如果凭经验、理论知识、相关文献判断不出来,最好把各种可能的自旋多重度都算算,电子数为奇数时算2,4,6.,偶数时算1,3,5,7.看哪种能里最低。对于含过渡金属体系,应当把金属的单电子都自旋平行的状态作为需要尝试的最高自旋多重度.
1. 阴、阳离子的自旋多重度都是1. -- [关于离子液体 自旋多重度](http://bbs.keinsci.com/thread-1414-1-1.html)



思想家公社
1. 总有些菜鸟、弱智文献说“体系的自旋多重度=单电子数+1”，这根本不对！碰见双自由基、反铁磁性耦合体系就瞎了。正确定义是“自旋多重度=alpha电子数-beta电子数+1”
1. 关于比较能量时是否需要优化结构，图省事就算单点比较，更严格是分别优化再比较能量.
1. 含有不止一个自旋中心的体系，应该用broken symmetry来算，除了最高自旋的态可以直接设自旋多重度以外，较低自旋的态都应该要么用片段波函数，要么用guess=mix等方法产生初猜，不能直接设个自旋多重度就跑。一定要直接设个自旋多重度就跑的话，也得做stable=opt。不收敛就解决不收敛的问题，按照[http://sobereva.com/61](http://sobereva.com/61)里的方法，没有任何遗漏地试一遍，仍然不收敛，才叫不收敛。不能一发现默认的SCF设置不收敛就放弃.这种体系应当用配体场理论预测自旋多重度，不然我们告诉你你也是死记硬背，换个体系你又不会判断了.
1. 注意看下文了解对称破缺计算是怎么回事.谈谈片段组合波函数与自旋极化单重态:[SCF不收敛和当前泛函适不适合计算没有必然关系](http://sobereva.com/82).



### 参考资料
1. [怎样确定体系的自旋多重度](http://bbs.keinsci.com/thread-4836-1-1.html)
1. [含Fe的离子团簇自旋多重度确定求助](http://bbs.keinsci.com/thread-25231-1-1.html)
1. [实例操作之自旋多重度判断](https://www.ceshigo.com/article/10422.html)


### 待看的自旋多重度确定资料
1. [What are the alpha orbitals and beta orbitals and their importance in DFT calculations?](https://www.researchgate.net/post/What_are_the_alpha_orbitals_and_beta_orbitals_and_their_importance_in_DFT_calculations)
1. [关于双自由基算法求助](http://bbs.keinsci.com/thread-4520-1-1.html)
1. [如何计算gaussian的自旋多重度](http://blog.sciencenet.cn/home.php?mod=space&uid=485752&do=blog&id=1115385)
1. [Gaussian量化模拟入门教程（三）：实例操作之自旋多重度的判断](https://zhuanlan.zhihu.com/p/272682337)
1. [谈谈片段组合波函数与自旋极化单重态](http://sobereva.com/82)


![](/img/wc-tail.GIF)
