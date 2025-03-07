---
layout:     post
title:      "实验杂记"
subtitle:   ""
date:       2019-11-26 09:57:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Experiment
    - 2019


---
1. 专注于一点·慢慢谨慎的做事·彻底地完成  
1. 是日已过，命亦随减，如少水鱼，斯有何乐！当勤精进，如救头燃，但念无常，慎勿放逸！  
1. 心包太虚，量周沙界。  
1. 动静不失其时。  
1. 正位凝命，旷怀笃行。  
1. 夕惕若厉。  
1. 心无所住，一期一会。  
1. 克己·慎独。  
1. 行云流水，任意所致。  
1. 十力·精诚。
1. 炼器于身。
1. 学以聚之，问以辨之，宽以居之，仁以行之。  

### Buffer
###### piranha清洗液

|Type|Ratio|Temp|Time|  
|----|----|----|----|  
|Acid|H2SO4 : H2O2(30%) = 7:3|60-90 C|10-30 mins|  
|Alkali|H2O: NH3·H2O: H2O2(30%) = 5:1:1|60 C(or 75C )|10-15 mins|  

###### 10mM PBS配方

按下表配方于1L水中溶解定容，用0.22um的水膜抽滤，pH大概7.31左右，接近理论值7.4：  

|Material(MW)|Weight|Mol mass|  
|----|----|----|  
|Na2HPO4(141.96)|1.44g|10.1mM|  
|or Na2HPO4·12H2O(358.14)|3.63g|10.1mM|  
|KH2PO4(136.09)|0.27g|1.98mM|  
|NaCl(58.44)|8g|136.89mM|  
|KCl|0.2g||  

###### 10mM HBS配方（受多价盐影响小）

按下表配方于1L水中溶解定容，用0.22um的水膜抽滤，pH大概5.5，需加NaOH调pH：  

|Material(MW)|Mol mass|Weight|  
|HEPES(238.30)|0.01M|2.383g|  
|NaCl(58.44)|0.15M|8.766g|  

###### 其它常见缓冲液
1. MES
1. MOPE（易受多价盐影响）

### 常用药品

1. 正常人血清：SoLarbio,5mM，Lot.No.20160912.Cat.No.Sl010
1. CaCl2·2H2O(MW=147.02):100mM=14.70mg/ml(无规则水合结构)
1. MgCl2·6H2O(MW=203.30):100mM=20.33mg/ml(六配位八面体水合结构)

### 仪器
###### 纳米粒度及zeta电位分析仪
1. 如果样品尺寸分布比较广，则可用**激光衍射法**。
1. 散射光强可以向数量百分比或体积百分比换算（分散剂必须准）。
1. 溶质的折光指数和吸收率对折算重要，若不折算则不重要。
1. 测试过程中光强误差应在5%以内。
1. 测zeta电位的过程中，单项模式加电压的时间比较短，常规模式加电压的时间长一些。
1. zeta potential的绝对值大于30mV被业界认为是稳定。
1. correlation function图的纵坐标截点值应在0.8-1之间。

### 经验
1. cystein会形成二硫键，导致无法吸附，所以在配置溶液时会有一步还原，加入DDT然后过柱子，或者加tris(1-carboxyethyl)phosohine hydrochloride （TCEP, 10mM， MW=286.65）。后者不用过柱子，但需要现配现用且避光混合1h。
1. 组装时加0.5M的盐可以有效屏蔽掉electrostatic interaction，要不可能有些肽因为electrostatic interaction而难溶。
1. 络合常数可以与结合能（用ITC测）互相换算，低pH下络合常数通常很低，常pH下络合常数则较高。
1. pI小于pH带负电，如PBS中BSA，pI大于pH带正电，如PBS中lysozyme。

### 有用的链接
1. [仪器表征基础知识汇总帖](https://mp.weixin.qq.com/s?__biz=MzUxMDMzODg2Ng==&mid=2247522643&idx=2&sn=89cc5b31ce149b6f367bdc0134ca86fe&chksm=f906ab0ece7122189b5a5bc009ed71c69919f1e197713a5d95d7178734b68488dec5de639582&scene=21#wechat_redirect)

![](/img/wc-tail.GIF)
