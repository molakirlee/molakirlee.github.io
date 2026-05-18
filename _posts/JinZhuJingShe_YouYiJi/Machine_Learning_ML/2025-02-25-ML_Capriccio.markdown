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
1. AI只是学的快且不会累，但并非一开始就会，这与蒸汽机一样只是提高生产力。其思考力才是最大差异。
1. AI只是学习能力、执行能力强，本质上有些像你身边的天才，与人类的关系本质上就是教会徒弟，但会不会饿死师傅？
1. 专业知识领域的人员不要去跟做计算机的人抢饭碗，以避之短与人之长争，要利用好你的专业知识，将AI驯化到你的领域。
1. AI像一个学生一样需要你教，然后需要你检查，然后超越你。

###### 强化学习RL
1. RLVR并没有真正拓展这个边界，而只是在边界内高效寻找到了解决问题的路径而已。RL同时收窄了推理路径的范围（coverage），所以在K较大时，反而没有基础模型的表现更好。更进一步分析模型的精确度分布，我们发现RL的模型呈现两极分化的特征：在高精确度上特别集中，而在低精确度上的表现不如基模，精确度为零的概率反而较高。RL训练后的模型就像是一个严重偏科的学生，会做的题目都能打满分，但是对于不会做的题目，猜对的概率还不如普通的学生。对于两种模型表现的比对可以进一步证明上面的结论：有很多题目RL没有解决，但是基模能解决；但是反过来，基模不能解决，RL能解决的题目几乎不存在。与RL学习不同，Distillation学习（SFT）方式可以拓展模型的能力，让模型学会解决原来不能解决的问题。RL学习这种限制的主要原因被认为是在语言广阔的探索空间中，预训练先验（prior）存在“双刃剑”效应。虽然先验使强化学习训练变得可行，但它也限制了探索，因为任何偏离都可能导致低奖励输出。因此，强化学习算法会强化先验内的解决方案，而不是发现其外的创新路径。这篇文章只是验证了一个假设，并没有否定RL学习方法本身的价值。基础模型和RL模型的对比，就像是通才（generalist）和专才（specialist）的对比，在解决具体领域问题的时候，往往还是专才能堪大用，我们也会容忍专才的偏执和狭窄的视野。当然，文章最后也提出，也许我们能找到一种训练方法，平衡模型的exploration和exploitation，让模型在提高效果的同时，不收窄探索的范围。为什么RL训练会有这样的效果呢？研究者认为，RL训练有一个特征，参数更新高度局部化。文章把它称为model-conditioned optimization bias。文章用两个很形象的图来表示了这个特征：SFT训练的过程就像是越野，走的路径百无禁忌，可以爬山下谷；而RL训练的过程像是带着一个指南针，按照这个指南针的指引，在相对平坦的地面上谨小慎微地前行。现有的一些RL训练方法，比如PiSSA，没有考虑到RL存在这种参数更新的特征，所以效果不好。我们应该可以设计一些适用于RL的参数更新方法，比如冻结主要权重，而更新“非主要、低幅度的权重。”我们可能需要研究一些"RL-native, geometry-aware" 的算法，来适配RL学习的这种特征。这项研究使我们从‘黑箱’视角转向对RL如何学习的‘白箱’理解。RL这种“循规蹈矩”的特点，就大体上解释了第一篇论文中“RL为什么没有真正提高模型能力”的问题。既然RL不能真正提高模型的能力，而SFT可以，那我们为什么不用SFT方式来做所有的训练呢？这就不得不提到灾难性遗忘的问题。RL's razor的论文指出，SFT训练会导致严重的灾难性遗忘，而RL训练却不会。 -- [wangleineo:近期关于RL学习的研究总结](https://zhuanlan.zhihu.com/p/1972781108128155202)

###### 迁移学习


![](/img/wc-tail.GIF)
