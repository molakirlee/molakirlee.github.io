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
    - 实验
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
###### SPR-BioNavis
1. 箱体背后电源打开，打开软件（SPR Navi）,Control window里看温度是否稳定，close。
1. 打开推样器（柱塞泵），每隔一段时间转一会SPR旋钮，稳定30min。
1. Config里选路径path --> Measurement里Angle选Full range --> Init Scan里Start，看是否只有一个峰（向下的峰，横坐标为角度），若是则用右下角"+"选中峰值区域（不多不少，几乎正好包括整个峰，大概65°-80°）；若不是，则可能是在35°左右也出峰，这表明有气泡，此时可加速冲洗一下。
1. Go to angle scan里start即可（检查SPR curve）（不需要再调角度，此时角度为custom，即之前选定的范围）。
1. 基线以50ul/min，蛋白进样10ul/ml，后冲洗50ul/min，三阶段均为10mins。
1. 注意：线下修饰时表面要有饱满的液体鼓包；BSA进样前必须过膜；PBS用前需脱气（水浴加热到60C后真空干燥箱内不关泵抽5min真空）。
1. 用完后用100-200ul/min的流速冲洗芯片，换芯片前停泵停软件。
1. SDS十二烷基硫酸钠(MW:288.38),0.5g/100ml用于清洗。

###### SPR-Biocore
1. 开启仪器后面的按钮启动仪器，power亮绿灯表示接通电源；temperature亮表示稳定在设定温度（25 C），黄灯闪烁表示温度不稳定；sensor chip在装载传感芯片且传感芯片准备就绪时亮起，*色表示插入芯片但未装载，绿色表示运行；run绿色表示运行。
1. 开机时power灯亮，temperature灯亮或闪烁，sensor chip熄灭或闪烁，run熄灭。
1. 开软件Biocore X100，输入用户名、密码。
1. 确保左边托盘上的玻璃瓶内装有新鲜缓冲液或水，并且两根缓冲液管已插入液面以下。
1. 确保右侧托盘上的废液瓶内为空，且废液管已插入废液瓶中。
1. 单击Load Samples图标，等待Rack locked指示灯熄灭后取出样品架，在4ml小瓶中加满去离子水，将样品架插入样品室，在Load Samples对话框中单击OK。
1. 此时芯片处于未加载状态，单击undock chip图标，打开芯片舱门，取出维护芯片，清洗表面灰尘后装入芯片仓，单击ok装载芯片。
1. Tools --> prime使缓冲液注满系统，缓慢冲洗至少1-2h。
1. 仪器清洗 --> prime --> 换好缓冲液和样品 --> 测样 --> prime
1. 用完后用100-200ul/min的流速冲洗芯片，换芯片前停泵停软件。

**仪器维护：**  
相关试剂： BIAdsorb soution1、BIAdsorb soution2、BIAdisinfectant solution。  

Tools --> more Tools -->  
Desorb（用时~0.5h）：S1提示用量1000ul，实际用量~700ul；S2提示用量1000ul，实际用量~800ul。  
Desorb and sanitize（用时~1h，之后还需待机平衡3-4h才可测样）：S1提示用量10ml，实际用量~4ml；S2提示用量10ml，实际用量~3.5ml；消毒液（次氯酸钠）提示15ml，试剂~7.5ml。

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


![](/img/wc-tail.GIF)
