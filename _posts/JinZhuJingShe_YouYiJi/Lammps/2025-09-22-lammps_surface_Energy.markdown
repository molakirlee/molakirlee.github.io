---
layout:     post
title:      "LAMMPS 表面能及表面张力计算"
subtitle:   ""
date:       2025-09-22 22:08:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2025

---

### 简介
一相所需增加一定尺寸表面所做的功被称为表面张力。作为单位面积的功或单位润湿长度的力来测量，表面张力有单位mN/m 和指定的符号σ。如果这一相是固体，常常用表面自由能这一等价术语。如果相邻相为一固体或液体，指的是界面张力。

液滴形状分析(Drop shape analysis, DSA)是一种从水滴的图像确定接触角，从悬滴的图像确定表面张力或界面张力的图像分析方法。与此同时可通过测量不同极性液体的接触角，计算出固体表面的自由能(SFE)。液滴性状分析可将测试液体滴在固体样品上(一般用于测试接触角)或液滴悬滴于针尖上(一般用于测试液体表面能)。液滴的图像可利用相机记录下来，并在分析软件中通过对液滴的轮廓进行拟合，可分析得出液滴在固体表面的接触角或计算得出液体的表面张力。
接触角、液体表面张力、固体表面能的测量参见[接触角测量仪原理及测试方法 ](https://iac.sjtu.edu.cn/UpLoadFile/AppFileData/仪器原理及测试方法介绍-接触角.pdf)


### 表面能
表面能的3种理解：
1. 晶体表面的原子处于不平衡的状态，其能量要高于处于平衡态的晶体内部原子，高出的这部分能量就是表面能。
1. 将体相变成表面晶体所需要的能量。
1. 表面能是创造物质表面时，破坏分子间作用力所需消耗的能量。

先计算块体，然后把上半部分上移（形成界面），计算两者能量差，具体参见[表面能的计算 & lammps输入脚本](https://zhuanlan.zhihu.com/p/629961579)


参考资料:
1. []()

### 表面张力
什么叫局部应力？局部应力是连续介质的概念，是指任何一个位置处的应力，不管这个位置是否存在原子。比如要算z方向上的应力分布。z的坐标是连续变化的，但是原子是离散分布的。如何将离散分布的原子的速度和受力信息转换到连续的空间中是计算局部应力的关键之处。到目前为止使用LAMMPS有两种计算局部应力的方法。第一种是原生的LAMMPS计算功能，第二种是Nakamura等对LAMMPS进行扩展而实现的计算功能。第一种可以在LAMMPS的所有版本中使用，第二种仅限于lammps-1Feb14版本。当然你可以修改Nakamura的源代码使其适应LAMMPS的最新版本。 两种方法的计算细节和示例in文件可以加微信lmp_zhushou获取。 第一种是利用 compute stress/atom 和 fix ave/chunk 命令实现计算。通过 fix ave/chunk 命令统计平均出单原子应力（单位是stress*vol），然后用单原子应力乘以bin中的时间平均的原子个数再除以bin的体积就是这个bin位置处的应力。 第二种则是直接利用Nakamura 等开发的 compute stress/spatial 命令进行计算然后用fix ave/time 进行平均并输出。 两种方法的区别是从离散原子信息向连续空间转换的方式不同。第一种采用Harashima 方法，第二种采用Irving-Kirkwood 方法。第一种LAMMPS原生支持可以对任何体系进行计算，但是统计涨落较大并且在界面处应力计算会出错。第二种方法只能计算简单液体和部分电场下的分子体系，但是在界面和体相取都很准确且统计涨落小。 下面是两种方法计算的液体氩的气液界面上的应力分布图。有意思的是尽管两种方法在气液界面上的应力分布不同但是计算出来的表面张力确实一致的。Harashima 计算出来的是1067.343，Irving-Kirkwood1062.437。确实一致。所以利用LAMMPS中的compute stress/atom 是可以直接计算界面的表面张力的。


###### 均相立方盒子体系表面张力
鲍老师在[讲义(更新至2022.12.22)-分子动力学模拟及其LAMMPS实现.pdf](https://github.com/molakirlee/Blog_Attachment_A/blob/main/lammps/讲义(更新至2022.12.22)-分子动力学模拟及其LAMMPS实现.pdf)中以SPC/E 模型下水的表面张力计算为例：
使用的是水的SPCE模型。方法是计算垂直液面和平行液面的压强分布，即pxx，pyy和pzz在垂直液面方向上的分布曲线。计算命令是 
```
compute myp all stress/atom NULL 
compute cc1 all chunk/atom bin/1d x lower 1.0 units box 
fix 1 all ave/chunk 1 1000000 1000000 cc1 c_myp[1] c_myp[2] c_myp[3] norm sample 
file p.profile 
```
计算完成后打开输出的p.profile文件，文件中第一列是bin的编号，第二列是bin的位置，第三列是bin中的平均原子数，第四列到第六列是c_myp[1]，c_myp[2] ，c_myp[3]。用第四列乘以第三列再除以bin 的体积取相反数就是pxx，用第五列乘以第三列除以bin的体积取相反数就是pyy，用第六列乘以第三列除以bin的体积取相反数就是pzz。将得到的pyy和pzz取平均就得到了平行于液面的压强pt，而 pxx 就是垂直于液面的压强pn。将pn列减去pt列，并将得到的结果乘以bin 的厚度，此处是1埃。将最终得到的结果列求和除以2就是表面张力值（因为2个表面？）。本例计算出的表面张力值是54mN/m，文献值是52mN/m，实验值是72mN/m。由此可见本例的计算结果是可靠的。 

此外[LAMMPS中盒子尺寸和原子数对表面张力计算的影响](https://zhuanlan.zhihu.com/p/1950168859014330262)一文同理，利用3个方向的压力和盒子 尺寸计算（没有划分bin而是用的整体，具体见链接汇中代码）。**此外，该文还证明水层厚度，真空层高度，不会影响表面张力的计算，这就是一些物理量的尺度非依赖性！**

###### [球形液滴的表面张力](https://zhuanlan.zhihu.com/p/716458647)
利用拉普拉斯定理
$$\Delta P=\frac{周界上的力}{剖面面积}=\frac{2Πr\gamma}{Πr^2}=\frac{2\times \gamma}{R}$$
(推导见[第11期：很重要的界面现象](https://www.bilibili.com/opus/730975967634260055))
其中ΔP为液滴内外的压差（[同最大气泡法](https://www.ceshigo.com/article/10510.html#:~:text=%E6%B5%8B%E9%87%8F%E5%8E%9F%E7%90%86%EF%BC%9A%E9%A6%96%E5%85%88%E5%B0%86%E9%93%82%E9%87%91,%E5%8F%96%E5%86%B3%E4%BA%8E%E6%B6%B2%E4%BD%93%E7%9A%84%E7%B2%98%E5%BA%A6%E3%80%82&text=%E6%B5%8B%E9%87%8F%E5%8E%9F%E7%90%86%EF%BC%9A%E5%BD%93%E6%84%9F%E6%B5%8B,%E5%8F%82%E8%A7%81%E5%9B%BE4%E3%80%82&text=%E5%BC%8F%E4%B8%AD%EF%BC%8C%CE%94p%E4%B8%BA%E9%99%84%E5%8A%A0,%E4%B8%BA%E6%B0%94%E6%B3%A1%E7%9A%84%E6%9B%B2%E7%8E%87%E5%8D%8A%E5%BE%84%E3%80%82)）

所以只需要使用
```
compute stress/atom
compute chunk/atom bin/sphere
fix ave/chunk
```

计算出来沿球形液滴半径的密度和压强分布就可以计算出ΔP和半径。

这种方法的优势是适用于任何体系和任何势函数，如单原子流体，分子流体，金属流体等。而其他方法只能适合特定的体系或势函数。

fix ave/chunk会输出密度分布和compute stress/atom计算出的（P*V）分布，用每个球壳内部的（P*V）*密度，就得到了每个球壳的压强。

只需要取液滴中心部分和气体中心部分的压强的平均值就得到了液滴内外的压差，然后液滴的半径在0.5*(液体密度+气体密度)对应的半径处。



其它参考：
1. [10.3.2. Use chunks to calculate system properties](https://docs.lammps.org/Howto_chunk.html)


![](/img/wc-tail.GIF)
