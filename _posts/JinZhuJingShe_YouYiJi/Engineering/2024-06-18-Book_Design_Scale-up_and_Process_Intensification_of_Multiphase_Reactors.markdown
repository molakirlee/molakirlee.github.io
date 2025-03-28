---
layout:     post
title:      "化学工程·书 多相反应器的设计、放大和过程强化"
subtitle:   ""
date:       2024-06-18 20:33:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Engineering
    - 2024


---

### 第三章 多相搅拌反应器
1. 搅拌槽通常包含一个或多个安装在轴上的搅拌桨叶轮，优势还包括挡板和其它内部构件，比如分布器、换热管和导流筒等。
1. 搅拌反应器的CFD模拟包括：1）解决工艺要求间的相互冲突。2）处理连续反应器的批次数据。3）反应器放大的分析。4）探索新概念的反应器。5）发展传热和传质理论。
1. 对于搅拌槽内的多相流动和输运，在大多数工程应用中，通常采用欧拉多流体方法（数值方法）和k-epsilon湍流模型（标准、重整化群RNG或可实现的k-epsilon模型）来数值模拟。基于各向同性的k-epsilon模型（Boussinesq假设），在预测桨叶区域的流动特性方面不够精确。实际上湍流黏性应力应是各向异性的，应该用“雷诺应力模型”来计算应力的各个分量，与其它基于雷诺平均（RANS）的湍流模型相比，它的精度更高，模拟结果与实验测量更接近。大涡模拟（LES）的基础是：在一个流场中，湍流涡流发生在多个尺度上，通过滤波方法将顺势变量分解成大尺度和小尺度两部分。大尺度量通过数值求解运动微分方程直接计算出来；小尺度运动对大尺度的运动的影响将在运动方程中表现为类似于雷诺应力一样的应力项。但与RANS模型相比，LES的巨大计算成本仍然是其工业应用的一个限制。因此，集合欧拉方法的RANS模型是工业反应器多相流动模拟的最常用方法。
1. RANS：虽然k-epsilon模型被证明具有预测能力、计算效率高，多年来为工程界广泛采用，但不推荐用于强旋流流动，如搅拌槽中的强旋转流动。为了考虑湍流的各项异性，常使用雷诺应力模型（RSM）和代数应力模型（ASM），已在单相流动中得到很好的应用。由于雷诺应力分量由微分方程或代数方程直接求解，而不是由k-epsilon模型等各项同性假设进行建模，因此可以成功地预测各向异性湍流。但是RSM和ASM在实际计算中使用不太方便，很难得到收敛地解。EASM在湍流模拟中与实验数据吻合优于k-epsilon，可称为工业搅拌反应器地有效替代工具。
1. LES模型：与k-epsilon模型相比，RSM由模型参数非桶用和数值计算困难等缺点，计算量也要高出一个数量级。此外，RSM模型无法捕捉到瞬时流动特性，这一限制可用LES方法克服。LES仅在计算网格上对更趋近各向同性地湍流最小尺度建模，同时在其他地大尺度上直接求解湍流，从而得到更精确地模拟结果。
1. 搅拌桨的处理：1）黑箱模型，将平均速度分量和湍流量的实验值作为边界条件，施加在搅拌桨叶片扫过的区域表面上，然后在不包括搅拌桨区域的整个反应器中求解流动方程。边界条件很大程度上依赖于从实验数据中获得的知识，搅拌桨设计、槽体集合结构、操作条件、物理化学性质等对规定的边界条件有很大影响。不能用来进行没有可靠实验数据的搅拌流场的预测。2）快照法：在搅拌桨区域用空间倒数来对时间相关项进行近似，并忽略桨区之外区域时间相关项。3）内-外迭代法：将容器分为两个部分重叠的区域，包含搅拌桨的内部区域、包含挡板到容器壁和底部的外部区域。4）多重参考系：与内-外迭代法有一个重叠区域（宽度和边界的精确位置很大程度上是任意的）不同，内部和外部稳态解沿一个封闭的边界曲面匹配，这个表面不是任意的而是先验的，在这个表面上，流动变量不会随着角位置或时间发生明显的变化。由于没有重叠区域所以计算量小于内-外迭代法。5）滑移网格：将计算区域划分为两个不重叠的子区域，一个与叶轮一起旋转，另一个与多重参考系法不同，允许移动网格对相对于固定网格沿界面剪切和滑动。计算单元之间滑动界面的耦合，是通过每次滑动发生时重新建立单元连接来考虑的。6）轴流桨处理方法
1. 数值求解控制方程的方法，包括有限元法FEM、有限差分法FDM、有限体积法FVM。近年来，有限体积法由于数据结构简单，得到了广泛的应用。
1. 对于槽壁、槽底、挡板、轴、桨和圆盘等固体表面，无滑移条件适用于速度分量的条件。如采用高雷诺数的k-epsilon或EASM湍流模型，壁面函数对于求解固体壁附近节点处的流速和湍流量是必要的。
1. Rushton圆盘涡轮桨由于能够提供强大的剪切力，将气泡破碎成较小的起泡，所以常被用于气液搅拌槽中。
1. 搅拌槽的气泛是指气体没有很好的分散到全槽，而是在浮力的驱使下上升，直接从液相中溢出。
1. 数值方法和湍流模型的改进对搅拌槽的准确模拟至关重要。通常文献中分析的量有：流场和能量耗散、气含率和气泛、气泡尺寸分布和传质、表面曝气（在气液搅拌反应器中，气体从液体的自由表面被卷吸进入液相成为气泡，称为表面曝气，其优势之一就是通过直接将反应器内顶部空间未反应完的气体重新带到液体中，从而提高气体反应物的转化率和减少气体回收、循环费用，表征表面曝气效率的关键因素是从液体表面上方卷吸气体的速率。表面曝气的机理与表面剪切速率、最大气泡直径、湍流涡流频率、湍流长度尺寸、局部能量耗散等几个流体特性相关。）
1. 展望：

### 气升式环流反应器

### 两相微反应器
1. 微反应器最典型的是微通道反应器。对于分析和环境监测、在线过程优化测量装置、催化剂筛选、微型燃料电池，已经非常重要，尤其针对制药工业中的微量有机合成，药物开发不需要大批化学品的试验阶段。
1. 传统的基于NS方程和湍流模型的CFD技术很难准确描述微尺度上的相互作用，而微尺度上的相互作用，比如相界面润湿特性、固液界面速度滑移等，对于微反应器至关重要。微观模拟能够很好地表示微观相互作用，但由于其计算量大，只能应用在非常小空间和时间尺度上。在微尺度多相流的数值计算方法中，LBM处理的对象介于宏观和微观尺度之间，是一种很有前途的数值方法。特别适用于多组分、不混溶多项流体的直接数值模拟。
1. 不混溶多相流模型的挑战之一是确定相界面的位置，因为其位置回在时空域中演化。
1. 微反应器的实验研究：1）流型，表面张力主导区、惯性张力主导区、过渡区域，流体物理性质如表面张力、黏度都会影响流型转变。2）压降。3）传质性能，总传质系数与雷诺数、施密特数、表观速度、压降具有一定关联。4）微观混合。
1. 微流体装置中低雷诺数下的层流，意味着难以利用湍流来增强热量/质量传递和化学反应，为了强化被动混合和传递速率，可以将微混合器的几何形状改进为能诱发二次流动和混沌对流的形式。
1. 微结构混合器的发展，应致力于将其建成为中试和工业规模的生产设备，在单个设备中集成多个功能（如加热、传感）的能力。

### 结晶过程模型与数值模拟
1. 结晶是从非晶态、液态或气态到结晶态生产一种或几种物质的最佳和最经济的方法之一。根据过饱和度的产生方式不同，可分为冷却结晶、蒸发结晶、反应结晶、沉淀、溶析结晶。实际工业生产中也用到多种过饱和度产生方式的组合。
1. 粒数衡算方程PBE的数值方法一般可分未四大类：矩方法（method of moment）、粒度区间法或离散法（multi-class method, MCM）、加权残差法（weighted residueal method）、随机方法（stochastic method）
1. 在工业结晶过程中，过饱和度、流场性质和警惕颗粒浓度等的空间分布非常重要。
1. 绝大多数反应结晶和溶析结晶是一个快速过程，其成核特征时间往往小于混合特征时间，因此结晶器内的混合可能是过程的控制步骤。
1. 微观混合效率一般用离集指数XQ来表征，如果微观混合完全，XQ为0，如果是完全离集，XQ为1。
1. 为了强化溶析与反应结晶体系的混合，不同类型的结晶器，尤其是微混合器已经被研究和用于颗粒物质的控制生产，如T混合器、Y混合器、涡流混合器、受限撞击射流混合器、共轴结晶器和径向结晶器。
1. 药物结晶动力学主要是成核速率和生长速率。热力学数据如溶解度、介稳区、杂质或添加剂对药物结晶的影响。热力学数据是动力学测定和计算的基础，也能够为过程设计和优化提供重要依据。
1. 对晶体形态的控制和晶习机理的研究还不够，特别是化学工程方面的操作对获得理想晶体形态的研究。
1. 设计结晶器的目的是通过宏观工艺条件和操作的控制，时间实验室结晶研究所选出的化学工程条件。应实现有利于结晶过程控制的宏观尺度上多相流体力学环境。目前，准确的描述宏观环境和宏观模型中的微观尺度现象，仍然是化学家和化学工程师共同面临的巨大挑战。

![](/img/wc-tail.GIF)
