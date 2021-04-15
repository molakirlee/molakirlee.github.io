---
layout:     post
title:      "gmx Jerkwin老师计算MMPBSA的新脚本——gmxmmpbsa使用说明"
subtitle:   ""
date:       2019-07-20 20:20:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2019

---

### 声明

**原文转自Jerkwin老师**，此处**转载**以便自己日常使用，阅读详细信息还请移步[Jerkwin老师的网页](https://github.com/Jerkwin/gmxtool)。  

### 前言
gmxpbsa对gmx版本有要求且脚本写的很乱，出错了不容易调试；
g_mmpbsa安装麻烦，二进制包，windows系统下无法使用，新版g_mmpbsa兼容gmx 5.1.x但不知是否兼容更新版本。

基于以上原因，Jerkwin老师编写了gmxmmPBSA脚本。

gmxMMPBSA使用时会调用gmx和APBS并可以支持任意版本，因此可以安装最新版本而无需担心不支持。gmx只使用了trjconv和dump程序，前者用于处理轨迹的周期性叠合问题，后者用于抽取tpr中的原子参数。既然你已经有了轨迹文件说明肯定可以使用gmx，至于APBS则需要单独安装。

MM部分的计算是脚本自行完成的，PBSA部分是借助APBS完成的。

### 使用步骤
简单流程如下：
#### 数据文件的生成
- 运行MD模拟，得到轨迹文件xtc；
- 生成ndx文件，其中中需定义三个组：复合物（com）、蛋白（pro）、配体（lig），名字虽然是pro、lig，但其实可以代表任意分子，比如两个有机小分子。

#### gmxmmPBSA脚本中设定计算参数

###### 路径修改
将 `apbs='c:/apbs1.5/bin/apbs.exe'	# apbs程序` 中的路径修改为apbs.exe的路径，linux系统下则修改为apbs的路径，如： `apbs='/home/users/ntu/n1805727/APBS/bin/apbs'`。linux系统下的另一修改是将两处awk语句中的四次出现的两个单引号修改为四次出现的一个单引号，即：
L88的
```
$dump -quiet -s $tpr 2>$scr | awk -v ndx=$ndx -v pro=$pro -v lig=$lig ''
```
修改为
```
$dump -quiet -s $tpr 2>$scr | awk -v ndx=$ndx -v pro=$pro -v lig=$lig '
```
L200的
```
'' >$qrv
```
修改为
```
' >$qrv
```
L217的
```
	-v fadd=$fadd -v cfac=$cfac -v df=$df ''
```
修改为
```
	-v fadd=$fadd -v cfac=$cfac -v df=$df '
```
L488的
```
'' _$pid.pdb >>_$pid~MMPBSA.dat
```
修改为
```
' _$pid.pdb >>_$pid~MMPBSA.dat
```

###### 基本信息修改
```
ff=AMBER						# 力场类型
trj=1EBZ.xtc					# 轨迹文件
tpr=1EBZ.tpr					# tpr文件
ndx=index.ndx					# 索引文件

com=System						# 复合物索引组
pro=Protein						# 蛋白索引组
lig=BEC							# 配体索引组
```

将trj、tpr、ndx等变量指向相应文件，将com、pro、lig指向ndx文件中相应的索引组。

其他参数主要是力场类型、极性参数、非极性参数、网格无关性，这些参数一般无需更改太多。  
此处链接为不同网格情况下PB的差异：[链接](https://molakirlee.github.io/attachment/gmx/gmxmmpbsa_test.xlsx)
总体而言，df小于0.2,fadd=20,cfac=2时PB变化已经较小。对于测试结果，Jerwin老师说：
1. df=0.11太小了, 不太具有实用性, 因为我们测试的这个蛋白只有200个残基, 比较小, 还可以用比较小的df, 对大的蛋白不可能使用很小的df，除非使用并行的apbs, 这样对蛋白大小没限制；
1. 小体系可以本机算, 大体系只能用集群算；
1. 表面密度的设置影响不大, 最关键的还是df。

#### 轨迹预处理（最新脚本省略此步）
计算前需要处理轨迹PBC问题、叠合问题，最新脚本可自动完成该过程。

#### 运行脚本。
- 脚本会首先抽取tpr中原子信息，存放在qrv文件中，主要是复合物中每个原子的电荷、半径、VDW参数以及残基信息。
- 脚本然后处理轨迹：1.完整化；2.居中叠合。之后将构型输出到pdb文件。
- 根据pdb文件中原子的坐标获取APBS网格参数并将每帧构型输出到APBS的pqr文件，同时生成APBS输入文件*.apbs。
- 调用APBS计算每帧构型对应的apbs文件并计算极性PB、非极性SA、部分的贡献，在计算MM贡献，同时进行残基分解，输出结果。

由于脚本计算是分步进行的，因此你可以先将所有apbs文件都产生出来然后并行计算它们，最后再统计结果。当然这只是在计算构型较多的情况下才值得尝试。

### 用户反馈
#### 与gmxpbsa相比
- gmxmmpbsa可给出MM、PB、SA总的结果和残基分解结果，而gmxpbsa只能给出总的结果；
- gmxpbsa使用时若体系中存在自定义拓扑或残基，则需要提供相应的拓扑或力场文件；
- gmxpbsa原有脚本生成并使用Mm.mdp文件较老，需要手动在print_files.dat里修改脚本；
- gmxpbsa出错时需要需要进入子文件查看错误原因，重新运行时又要删除子文件夹，否则不能运行，因而调试较为繁琐；
- gmxpbsa需先后运行三个脚本，而gmxmmpbsa只需要运行一次。
- gmxpbsa可实现甘氨酸扫描（CAS）和残基突变，gmxmmpbsa未可。

#### 与g_mmpbsa相比
- 对g_mmpbsa算例，MM能量一致, PBSA能量有差距, 原因可能在于APBS计算所用网格大小不一样；
- gmxmmpbsa无需安装，简单修改后可直接使用；
- g-mmpbsa需手动分别运行计算MM、PB、SA的能量，而gmxmmpbsa只需要运行一次。

#### 关于三种方法的原子半径
gmxpbsa用的半径与gmxmmpbsa和g_mmpbsa不同。gmxmmpbsa与g_mmpbsa的原子半径取自于amber, gmxpbsa是根据参数计算的。所以与amber所计算的结合能比较的话,gmxmmpbsa和g_mmpbsa应该会更接近（ amber有自己的mmpbsa, 用的最多，一般以它算出的结合能做标准，但amber自己的pbsa程序和apbs可能有差距）。

#### 关于三种方法的网格计算
gmxmmpbsa采用与g_mmpbsa相同的方法计算格点，因为g_mmpbsa的格点方法是apbs给的方法，但g_mmpbsa处理网格的问题在于所采用的格点不一致；相比之下，gmxpbsa严格一些, 因为用的格点是一致的。此外，关于网格的设定，李老师觉得觉得要拿最大的体系测试, 看最小能用多大的网格, 然后所有的都用这个网格。

三种方法计算g_mmpbsa算例1EBZ的结果比较：

||gmxmmpbsa|||g_mmpbsa|gmxpbsa|
|:----:|:----:|:----:|:----:|:----:|:----:| 
|df|0.25|0.35|0.5|0.5|0.5|
|VDW|-321.087|-321.087|-321.087|-326.395|-324.708|
|COU|-147.217|-147.217|-147.217|-140.694|-154.925|
|MM|-468.304|-468.304|-468.304|-467.089|-479.633|
|||||||
|PB|293.582|303.029|318.777|311.807|358.44|
|SA|-34.662|-34.662|-34.662|-30.25|-30.378|
|PBSA|258.92|268.367|284.115|281.557|328.062|
|||||||
|Binding energy|-209.384|-199.937|-184.189|-185.532|-151.571|



![](/img/wc-tail.GIF)
