---
layout:     post
title:      "aspen 换热器"
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


##### 换热器
1. Heater-单流股换热器
1. HeatX-双流股换热器
1. MHeatX-多流股换热器
1. HXFlux-模拟穿过换热表面的对流或辐射热传递

###### HeatX模型
Calculation mode和Model Fidelity决定了计算方法。

Model Fidelity:如Shortcut, Shell&tube, Kettle Reboiler, Thermosyphon, Air Cooled, Plate等；

Calculation mode:
Shortcut（简洁）：指定其中一个流股的出口条件  
1. Design（设计）：利用固定的传热系数计算所需换热面积
1. Rating（校核）：确定指定的换热面积是否超过/低于必要换热面积
1. Simulation（模拟）：基于给定的换热面积或传热系数确定出口条件
1. Maximum fouling: “达到指定热负荷的换热器能承受的最大污垢热阻是多少?

Rigorous（严格）：利用 EDR 程序设计一个新的换热器或对现有换热器进行校核  

注：
1. 公用工程流股可以代替工艺流股放置于冷侧或者热侧
1. 对于纯水系统，请选择蒸气表物性方法，如 STEAMNBS。

###### MHeatX
MHeatX 可用于多个热流股和冷流股之间的热传递（如液化天然气工艺中的换热器）
1. 可执行详尽、严格的内部区域分析以确定夹点
1. MHeatX 利用多个 Heater 模块和热流股来加强工艺流程收敛
1. 双流股换热器亦可利用 MHeatX 建模（不考虑换热器几何结构）

###### 换热器收敛
1. 如果您收到温度交叉信息，请检查流股是否与正确端口相连（热流股与热端口相连，冷流股与冷端口相连）
1. 先以 Shortcut 模式运行 HeatX 模型，以便在切换至严格模式之前排除流率和物性错误
1. 如果闪蒸计算失败，切换至校核计算并规定出口温度，计算将更加稳定
1. 使用区域分析来诊断问题：转到 Options（选项）| Report（报告），并勾选“Include Detailed Zone Analysis profile in report”
1. 查看模块的文本报告，以获取完整的输入与结果摘要
1. 让热流股和冷流股通过 MHeatX 模块，并绘制组分加热／冷却曲线，以检查夹点和温度交叉情况
1. 如果有可能存在两种液相，将有效相选择汽-液-液相



![](/img/wc-tail.GIF)
