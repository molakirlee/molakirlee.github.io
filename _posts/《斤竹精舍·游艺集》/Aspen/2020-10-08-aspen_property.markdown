---
layout:     post
title:      "aspen 物性·估算·分析"
subtitle:   ""
date:       2020-01-12 09:50:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - aspen
    - 2020


---


##### 物性估算
1. [物性估算在 ASPEN PLUS软件中的应用](https://molakirlee.github.io/attachment/aspen/aspen_property_estimation.PDF)
1. [Aspen入门篇4—物性方法选择及物性估算](https://www.jianshu.com/p/04ad791aa339)

##### 物性方法选择
1. 物性方法的选择将会影响到压力/密度关联性质的参数，如：焓值、熵值，而不是理想气体性质的参数。
1. P-R（广义P-R一般不用，因为仅通过临界温度、临界压力及偏心因子获得）、SRK等立方型EOS没有很高的精度，但足以描述汽液两相的状态。其对**非极性且无氢键作用的纯组分或混合组成**的热力学计算结果较准。
1. 与基于活度系数模型（UNIQAC, UNIFAC, NRTL, WILSON）和状态方程模型(P-R, SRK)来预测纯组分和混合物性质不同，NIST TDE提供的是纯组分和混合组分的实验数据。
1. Wilson模型对**常规的非理想混合物体系**的计算预测一般较准，但对于存在液液平衡的极度非理想体系混合物不准。
1. 对于简单体系，活度系数模型和EOS结果比较一致， 高压状态下选择EOS。但对于含极性组分或高压状态则情况不一样了。
1. 乙醇-正己烷低压状态下的汽液平衡：含极性组分、且为低压 ==> 活度系数模型。
1. 在`Methods --> Global --> Modify`里可设置`Vapor EOS`，实现汽相用EOS模型，液相用活度系数模型。可由于汽相和液相模型完全不同，因此不存在任何一种状态使这两个模型给出一样或是特定的结果，虽然在一个真实的混合物三相点，汽液相的混合组成是确定的。
1. 电解质模型ENRTL-RK的意思是液相采用电解质NRTL活度系数模型，汽相采用RK方程。
1. 在汽液平衡中，活度系数的细微差异对平衡的预测可能是有很小影响，但在液液平衡中则会造成巨大差异。故：在汽液平衡预测中使用不同的活度系数模型可能带来相似的模拟结果，但在液液平衡中，不同的活度系数模型会带来较大差异（不接受没有经过一定形式实验验证或利用相似混合物性质进行预测计算的结果。所以用液液平衡数据进行回归用于汽液液平衡会产生一些定量与定性的差异。所以在使用UNIFAC模型时分别存在一组仅用于预测汽液平衡的参数与一组独立用于预测液液平衡的UNIFAC-LLE参数。

以主要组分决定模拟方法：
1. 非极性：PENG-ROB & RK-SOAVE及其衍生
1. 极性、高度非理想：WILSON（爷爷辈）-->NRTL（爸爸辈）--UNIQUAC（孩子辈）
1. 压力接近10 bar时，需考虑是否接近临近状态，如果是接近或超过临界状态，则不能使用活度系数法，使用能处理极性的EOS（无压力限制），
1. 高级状态方程法适用范围广，但未必精确，用于高压极性：PC-SAFT


二元相互作用参数回归:  
1. 活度系数模型参数：Aspen数据库；UNIFAC官能团模型预测；实验数据拟合。
1. `Estimation`用于生成数据库中缺少的参数值，包括纯组分性质和混合物参数，通常因为这些组分是新的或不常见的。
1. `Property Estimination`可以通过无限稀释*活度系数数据*计算Wilson等模型的二元交互作用参数，或通过UNIFAC（不直接用UNIFAC一是因为慢，二是因为这样可以充分利用部分已有数据）。
1. 用NIST数据库获取的一些数据可能是含单一温度下的多组两液相的数据组成，或只含有单一液相中的组成，不适用于二元参数回归，因为二元参数回归需要实验数据集包含一定温度范围内两液相的组成。
1. 通过静态池法或沸点仪可测无限稀释活度系数数据以用于回归二院交互作用参数模型。
1. 用TPz回归二元交互作用参数时，数据通过静电电池（static method）测得则需输入`static-cell constant`。若未知则填入一个很小的数值（如1e-5）。


##### 性质分析
1. 除了`pure`中的默认的热力学性质，纯组分物性分析时（汽液平衡线），通过`Property Sets --> New`可以添加性质，并通过`PT-Envelope`分析（即：`Property sets` ==> 在`Property sets`的`Property`里选性质，在`Qualifier`里输入要显示的相态 ==> `PT-Envelope`里`system-->Tabulate`里选定物性集 ==> `Run`。非汽液平衡线，如某些性质如何随压力变化，则可通过`GENERIC`而非`PE-Envelope`。注意在`Generate`选`Point(s) without flash`，在`Variable`标签下设定变量，`Tabulate`里选定物性集，`Run`。
1. Property Analysis(Analysis --> Binary)计算VLE的优点是便于用来生成P-xy、T-xy和描述混合物的不同组分与吉布斯自由能之间的函数关系的图表。缺点：只能用于双组分；只能用于固定T或P下的计算，不能用于仅知道最终压力和焓值条件下的计算，如焦-汤节流膨胀。
1. 想在结果中显示活度系数等，可通过`Property Sets`实现，即`Setup --> Report Options--> Stream --> Property Sets --> New`。跟在`Properties`主菜单里找到的一样。

##### 液体比热容查看
 aspen 默认方法不显示液体比热容，需查阅时，要将`Method-Parameter-pure component`里的`THRSWT/6`改为100或114或124，（如改为100，此时采用DIPPR方法计算液体比热容；将纯组分焓值计算方法HL改为HL09同理）  

参考资料：[如何用Aspen调出甲醇的液体比热容公式系数](https://bbs.mahoupao.com/thread-158265-1-1.html)

![](/img/wc-tail.GIF)
