---
layout:     post
title:      "化学工程 笔记"
subtitle:   ""
date:       2019-05-09 06:37:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Engineering
    - 2019


---

###### 实例：[乙烯氧化反应器系统设计](https://molakirlee.github.io/attachment/Engineering//Ethylene_Oxide_Reactor_System/Ethylene_Oxide_Reactor_System.html)

###### 压力
1. 聚酯缩聚冷凝器热阱/真空液封罐：破真空时液封，冷凝器液体通过泵回流喷淋，喷淋塔内为负压，如果没有热阱，泵需要抵消喷淋塔的负压，功率大。
1. 压力表的弯管：给气体留足冷凝的空间，防止气体流速太快损伤压力表（冷凝液很少，压降基本可以忽略）。
1. 压力表的变径管：压力表管路如果太细，采用变径管增大管径后接压力表。

###### 储罐
1. 储罐回流管：1）液体储罐的出口泵有两个去处，一个是去目标容器，一个是回流回储罐。回流回储罐的管路是为了防止去目标容器的管路关闭时泵中液体排不出而损坏泵。2）泵的出口有很大的压力，一般储罐出口的回流管是为了平衡泵出口压力。
1. 垫料：为避免罐子干烧（或低温下固体析出），储罐开车前要垫料到一定液位，需留有一个垫料用的进料口。
1. BDO设有回用罐（打浆等使用）、低点回收罐（待精馏/提纯的 BDO，过滤器排净口排出的液体）

###### 管路
1. 波形补偿器：防止热收缩/碰撞对管路损坏
1. 膨胀节（U形弯管）：防止热收缩/碰撞对管路损坏
1. 反应器顶部气相出口采用弯管：
1. 排气口哪里布置（缩聚二）：
1. 如果设备出口是焊接不是法兰，且通过弯管连接其它管路，为了方便检修，可将出口管与其它管连接的地方改为三通，多出的一通为出口管延长线，增设法兰，便于检修时拆开。
1. 管路Y型过滤器：枝杈处斜插入过滤网，一定时间后拔出清洗。

###### 换热器
1. 为提高管内流体的速度，可在两端封头内设置适当隔板，将全部管子平均分隔成若干组。这样，流体可每次只通过部分管子而往返管束多次，称为多管程。同样，为提高管外流速，可在壳体内安装纵向档板使流体多次通过壳体空间，称多壳程。
1. 当管束和壳体温度差超过 50℃时，应采取适当的温差补偿措施，消除或减小热应力。

###### P&ID
1. [一文教你成为PID识图、制图、工艺流程图设计高手](https://www.jishulink.com/post/1805076)
1. [P&ID的设计介绍](https://zhuanlan.zhihu.com/p/652612070)

###### 闪蒸器与气液分离器
闪蒸器：主要用于相对高压系统中，对以液相为主的体系中脱除少量气相场合，往往表现为以流体部分静压能减压转化为流体动能的方式，而实际上流体经过一级入口分离总成时，已经初步实现对混合流体的气液两相流初步分离和动能动量重新分配；粗分后的气相在流经二级精密分离总成时，又对气相中液滴进行二次脱除；经过闪蒸器处理后的液相系统所含气量以及气相系统残留液量能实现定量设计。

气液分离器：在行业内通常认为，对大量以气相为主的体系中脱除少量液相场合，由于过程压损极小故几乎不表现为以流体部分静压能减压转化为流体动能的方式，其关键在于内件总成数学模型平台设计；混合流体经过一级入口分离总成时，主要初步实现对混合流体的液相段塞流、大液滴脱除，以及气相动能动量重新分配；粗分后的气流在流经二级精密分离总成时，气流中的微小液滴在特殊设计的空气动力学流道中通过矢量分离、高效碰撞聚结、液相高表面自由能捕集等综合分离手段实现对气相中微量微小液滴进行二次分离；经过气液分离器处理后的出口气流中残液量小于0.01kg/1000Nm^3，能对5微米以上的液滴实现99.9%高效脱除。这里所说的定量分离器，是指采用如高效叶片式分离内件总成技术的空气动力学分离技术方式实现的气液两相分离；而不是指采用如丝网分离内件的以物理孔格阻挡拦截分离方式实现的气液两相间定性分离器，非定量分离器。

能否保证高效定量脱除效率，关键取决于设计单位是否建立有经过长期实践检验修正的精准空气动力学数学模型，并被世界上有代表性的大型石化企业应用认定，如经过壳牌（SHELL）认证认定，就可以在全球推广应用，几乎畅通无阻。仅仅作为CFD数据模拟形成的模型，未经大量工程放大应用验证，其可靠性得不到有效保证，这是目前国内工程设计与国外工程设计上的差距所在，故而国内设计院和工程公司则采取分离器外包给具有工程设计经验的国外公司，让国外公司进行整体设计制造供货，但前提必须保证向国内工程公司提供工艺计算书和工程图供审核。这样，经过几次消化吸收，基本掌握其设计原理，但数学模型则需要较长的时间去建立，形成自己的可靠的成果，从而实质性提升国内工程工装设计水准。


对于含氢、液、有机物的体系，可参考如下：
1. 加氢反应器出口物流中的氢，通常均要求回收后加压循环进加氢反应器。反应器入口氢气压力高于反应器出口氢压，因此，只要打算循环利用氢气，通常要求设置循环氢压缩机补压后，与反应器入口氢并流使用。
2. 循环氢压缩机，是加氢单元昂贵而核心设备之一，对压缩机入口物流的要求较严格：1、温度不能高；2、入口段气流带液量尽可能小。否则，循环氢压缩机稳定运行将面临严峻挑战。为此保护加氢单元昂贵而核心设备循环氢压机，工艺设计上都尽量满足循环氢压机入口物流要求，即在加氢反应器出口管线先设置换热器（也可能是几级换热，确保温度降到60摄氏度或更低），然后再设置高效气液分离器，分离器出来的气相再进入循环氢压缩机入口段。

如果打算把反应器出来的物流直接送闪蒸器、闪蒸后的气相再送气液分离器、气液分离器出来的气相再进循环氢压缩机入口段工艺流程安排来看，有几点需要注意：
1. 闪蒸存在相变，减压后部分液相有机物会部分气化进入气相，与循环氢一道参与循环加氢反应，副产物明显增多；
2. 进入气相的有机物与气相氢，由于没有经过专门换热器，仅仅通过部分有机物气化相变吸热而使温度有所降低，分离器能把气相中携带的液相分离下来，而难以对气相中有机气体从氢气中分离；
3. 分离器出来的气相，在进入循环氢压机入口段前，仍然需要换热器将温度降到60度以下，此时气相中的有机物冷凝下来部分被氢气流挟带，该气流不满足循环氢压机进气条件，需要再增加气液分离器高效脱除气相中的微小液滴后才能进入循环氢压机；否则，后果可想而知。


因此，尽量参照“反应器-->换热器-->分离器-->循环氢压机”这样经过许多工程师和业主经验和教训总结出来的流程去设置您的工艺。



### 工艺包
###### 工艺包设计需要哪些专业共同完成？
工艺包开发是一项系统工程。需要涉及到多个专业、不同学科，难以凭借一己之力完成。一般来讲，工艺包开发及设计主要由研发、化工工艺、工艺系统、分析化验、自控、材料、安全卫生、环保等专业共同完成该化工产品的工艺包设计工作。

###### 工艺包成品应包括哪些设计文件？
工艺包的成品应包括说明书、工艺流程图(PFD)、初版管道仪表流程图(P&ID)、建议的设备布置图、工艺设备一览表、工艺设备数据表(附设备简图)、催化剂及化学品汇总表、取样点汇总表、材料手册(需要时)、安全手册(包括职业卫生、安全和环保)，操作手册(包括分析手册)、物性数据手册以及有关的计算书。

工艺包设计的质量控制与公司设计标准规定的各个有关专业在基础设计／初步设计阶段的质量控制要求相同。

###### 工艺包设计内容和深度的详细规定
1 说明书

工艺包设计说明书是工艺包设计的重要组成部分，应包括下列内容：
1.  生产方法、装置特点；描绘工艺包设计所采用工艺生产方法的先进性、可靠性以及装置特点。
1.  产品名称及规模、年操作时间、装置运行方式，按五班三运转或四班三运转，或者其他方式运转。
1. 按工艺过程的先后顺序,列出组成装置各工段的名称。
1. 列出产生三废的装置设备名称以及三废名称、数量、组成及排放形式，有关三废综合利用和处理的说明。

（1）设计基础
1. 分别列出有关原料、催化剂及化学品的名称及规格。
1. 分别列出水、电、气、汽等公用工程的名称及规格。

（2）工艺设计
1. 叙述工艺过程原理，列出工艺过程所涉及的化学反应方程式(包括主、副反应)，说明所采用的催化剂。
1. 按照工艺过程顺序，分工段及系统(塔系统、反应器系统、压缩机系统)详细叙述工艺流程。
1. 分工段及系统(塔系统、反应器系统、压缩机系统)列出各主要点的正常操作条件，如温度、压力、流量、组成及主要的控制指标。
1. 列出产品规格、产品产量及原料消耗量的期待值和保证值。
1. 列出主要的公用工程消耗指标。
1. 分工段及系统(塔系统、反应器系统、压缩机系统)详细叙述工艺控制原理，并对工艺安全联锁系统加以说明。
1. 对反应器、主要的传质设备、主要的换热设备以及机泵等关键设备的选型从结构、形式、选材等方面加以说明。

2 图纸
1. 工艺 流程图(PFD)，附物料平衡表；管道仪表流程图(P&ID)；建议的设备布置图。
1. 建议的设备布置图应包括下列内容：建、构筑物形式的建议和参考性的尺寸，设备之间的相对位置和相对标高(按比例表示，无需标出具体尺寸)，有特殊要求设备的相对位置或标高或高差(必须标出具体尺寸)，全部或主要设备的名称和位号，控制室和主要操作室的相对位置。

3 表格
工艺设备一览表；工艺设备数据表(附设备简图)；催化剂及化学品汇总表；取样点汇总表(需要时)

4 安全手册
1. 包括职业卫生、安全和环保；
1. 简要介绍安全手册的主要内容、编制目的及其作用。
1. 工艺说明：包括化学原理和装置工艺流程的叙述。原料、中间产品、最终产品的基本物理化学性质及火灾、爆炸、毒性等方面的详细的数据资料及其控制手段。针对装置的性质所采取的预防火灾、爆炸、中毒等事故发生的措施及控制手段。例如通风、紧急出口、灭火器、安全淋浴器、洗眼器、呼吸设备、人身防护设施的配备等规定。

5 操作手册
1. 包括分析手册，在全部工程设计完成后由专利商提供；
1. 简要介绍操作手册的主要内容、编制目的及其作用；
1. 化学原理、装置工艺流程和公用工程系统的叙述，附缩小的PFD和P＆ID图；
1. 列出工段或系统(反应器系统、塔系统、压缩机系统等)的推荐的操作参数以及改变这些操作参数给装置带来的影响；
1. 主要为设备、管道机械进行最后检查的步骤，提出阀门及有关设备机械的润滑步骤，设备及管道的清洗和吹扫步骤，仪表检查和校对步骤，泵、压缩机等设备的调试和运行步骤的要求；
1. 开车步骤、正常操作步骤、正常停车和事故停车步骤；
1. 工艺装置和公用工程辅助装置详细的正常停车和事故停车步骤。

6 分析手册
1. 简要介绍分析手册的主要内容、编制目的及其作用，以及分析部门的职责、组织和协作。
1. 对取样点设计的基本要求作简要说明，并以取样点汇总表的形式列出整个装置中每个取样点的具体位置、取样点类型、分析项目和分析频率。
1. 取样步骤包括下列有关内容：取样操作的安全防护措施、取样容器的准备、取样步骤和样品的制备及处理、获取有代表性样品的技术和方法。
1. 列出整个装置取样分析所用到的分析方法，包括原料、产品的分析方法，以及装置各个工段及系统的有关分析方法。

###### 化工生产过程工艺包开发
1. 化工生产过程主要包括反应和分离两个部分。反应过程是化工生产的核心，分离过程是保证产品纯度的重要手段，二者缺一不可。
1. 反应过程的任务是确定反应路线，通过参数优化得到最佳的反应条件。在路线及条件选择时需要综合考虑以下因素：产率、转化率、选择性、能耗、安全性、稳定性、介质腐蚀性（涉及到材料选择）三废处理量、设备投资、运营成本等。
1. 化工装置中常见的分离为气液分离、吸收、气提、解析、精馏等。不同分离手段的适用工况不同。应结合物料组成和分离要求做出权衡。


![](/img/wc-tail.GIF)
