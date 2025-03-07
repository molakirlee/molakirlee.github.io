---
layout:     post
title:      "ML 关于机器学习的几点思考"
subtitle:   ""
date:       2025-02-25 23:50:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Machine_Learning 
    - 2025


---

1. 当前人们盲目热衷于大模型，其实跟算卦过程中增加内嵌逻辑（元素及其关系）一样，试图让模型通过训练自己归纳出一套内在逻辑，从而避免亲自去梳理复杂的关系。但这种打靶式（无论有无监督都有一定目标）的黑箱训练本质上与古人不断推演算卦模型是类似的。人们在口口声声反对迷信的同时披着科学的外衣做着类似的事情。不是说优化和发展大模型有问题，而是说不应盲目无脑喷传统的推演模型。应理性审视到时代局限性对模型的影响。同时我们也要从历史的发展进程中认识到，此类模型发展到一定阶段，是极有可能随着人们对客观环境世界的认识加深而从预测性上被理论模型所反超（如17-20世纪的科技大发展）。因此机器学习模型一定程度上更适合用来作为代理模型（训练后用来处理程式化的工作）或启发机理模型（因为其可以更发散）。

1. 所谓机器学习无非是让机器来做人的工作，但内容上本质相同。机器学习模型应依据其应用划分为两种，一种是应用于简化日常操作的代理模型，一种是用于探索的启发式模型，如同操作工和科学家的区别。
1. 单纯的数据训练得到的是玄学家，局部数据训练得到的是相对可靠的经验师傅，带有思考的训练可能得到科学家。
1. 人们日常发现的所谓规律本质上与算卦没区别，只是前者模型相对简单可靠而后者追求更大范围的泛化。
1. 机器学习模型的内在变量层次是不确定的，可能是基于宏观观测量，也可能是基于微观量，这增加了训练的复杂性和难度，但也为产生更好的机理模型提供了可能。
1. Although the current trend appears to be to explore the use of ML-based schemes for optimization and control, a more appealing use of AI can be to design, deploy and maintain MPC, RTO and other applications. The premise for using more complex ML algorithms is often stated as the strong nonlinearity in the process. In an industry which is designed and operated on “first principles”, it makes little sense to adopt a complete black box approach to modeling, control and optimization. Instead, AI and ML can be used for higher level complex tasks which are often impacted by a skills shortage in industry. For example, in future an MPC application be designed and deployed much faster by an MPC engineer working with a Generative AI assistant which has been trained on previous domain knowledge. The deployed application could then be maintained better by using a meta-RL approach which will look at a higher-level learning objective instead of trying to reinvent the control paradigm itself. -- [Machine learning & conventional approaches to process control & optimization: Industrial applications & perspectives](https://www.sciencedirect.com/science/article/pii/S0098135424002072)
1. 机器学习能否得到全局最优解（靠的是足够多的数据量），设计阶段是否事何使用机器学习是个问题。因为机器学习需要有充足的训练数据，但如果已经有充足的实验数据，设计雏形就已经出来了，机器学习变成了马后炮，所以机器学习更适合后期控制优化。如果想用于设计阶段，则模型要有思考的能力，可考虑训练一个专家模型。构建一个能思考的专家模型对于实际工业应用和多专家耦合的大模型都具有重要意义。
1. 人类也在不断学习，所谓站在巨人的肩膀上，那又为什么要求机器把所有的规则都从0开始自己学习探索呢？可以向其传输一些规则，让其像现在的人类一样在一定的基础上学习和发现。当然也不要放弃让机器从0学习的路线，或许会发现另一套规律。

![](/img/wc-tail.GIF)
