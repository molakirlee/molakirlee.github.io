---
layout:     post
title:      "aspen 塔"
subtitle:   ""
date:       2020-01-12 09:50:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Aspen
    - 2020


---



##### 塔
1. 设计中考虑每块塔板有0.5 psi（或更小，1 psi=6.89 kPa）的压降更符合实际情况。
1. 再沸器、分凝器各算作一个平衡级；全凝器不算平衡级，但在Aspen中被视为一个平衡级。
1. 离开某块塔板的汽液相是呈热力学平衡的，但与下降进入该塔板的液相、上升入该塔板的汽相是不平衡的。
1. 引入板效率因子是为了表征实际塔板上不可能达到完全的汽液平衡。
1. 由经典热力学可知，精馏无法得到纯组分，因为塔顶/塔底的产生为单一组分时deltaG无穷大。
1. 精馏塔的校核模式相对设计模式计算较为简单且易于收敛，但是需要大量的人工干预来调整塔的参数以满足塔顶塔底的组成指标。
1. 简捷计算中，每块板上的组成是在恒定相对挥发度和恒摩尔流的假定前提下，经物料衡算得出的。
1. HCl、NH3吸收电离的过程用电解质模型，并将HCl、NH3设为Henry组分。因为此二者是对应于水溶液中的HCl和NH3分子，不算离子！换言之，HCl和NH3是通过溶解进入液相而非通过冷凝。回顾一下Henry组分的定义（在操作条件下表现为不凝气体的组分，其在液相中的溶解度用亨利定律描述），所以是否定义为Henry组分的关键不在于其是否是进入液相，而是其本身在操作条件下是否冷凝！（醋酸就不能设为Henry组分，因为其挥发度不够大，无法出现在汽相中。）
1. 默认条件下，板式塔和填料塔的计算结果不会对塔的分离效果产生影响，这些计算都是额外的。

###### RadFrac收敛
1. 确保塔的操作条件合理；
2. 检查物性问题（物性方法、参数的可用性等）；
3. 如果塔设备误差一直下降，则增大max iteration；
4. 在添加Design Spec之前先保证塔已经收敛并作为初值；
5. 在RadFrac--Convergence--Estimates--Temperature里提供温度的估算；
5. 在RadFrac--Convergence--Estimates--Liquid Composition and Vapor Composition里提供组成的估算（可用于高度非理想体系）；
6. 在RadFrac--Specifications--Setup--Configuration里选不同收敛方法；
7. 记得初始化。


![](/img/wc-tail.GIF)
