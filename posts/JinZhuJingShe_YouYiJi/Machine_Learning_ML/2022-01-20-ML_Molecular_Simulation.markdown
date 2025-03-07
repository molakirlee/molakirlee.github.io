---
layout:     post
title:      "ML 分子模拟"
subtitle:   ""
date:       2022-01-20 23:50:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Machine_Learning
    - 2022


---

### 描述符
1. CODESSA
1. (E-)Dragon:在线

### 分子尺寸及电荷
1. [Multiwfn可以计算的分子描述符一览](http://sobereva.com/601)
1. [使用Multiwfn预测晶体密度、蒸发焓、沸点、溶解自由能等性质](http://sobereva.com/337)

1. [使用Multiwfn计算分子的动力学直径](http://sobereva.com/503)
1. [谈谈分子体积的计算](http://sobereva.com/102)
1. [谈谈分子半径的计算和分子形状的描述](http://sobereva.com/190)


1. [谈谈如何衡量分子的极性](http://sobereva.com/518)
1. [谈谈怎么计算化学体系中“原子的静电势”](http://sobereva.com/641)
1. [谈谈怎么考察、计算、分析化学体系的电子密度](http://sobereva.com/715)
1. [使用Multiwfn的定量分子表面分析功能预测反应位点、分析分子间相互作用](http://sobereva.com/159)

###### Case 1: 应用机器学习高能材料预测分子性质
1. More abstract general purpose featurizations, such as SMILES strings & Coulomb matrices (discussed below) only excel with large data and deep learning models, which can learn to extract the useful information. 
1. With small data, great gains in accuracy can sometimes be gained by hand selecting features using chemical intuition and domain expertise. For example, the number of azide groups in a molecule is known to increase energetic performance while also making the energetic material more sensitive to shock. While the number of azide groups is implicitly contained in the SMILES string and Coulomb matrix for the molecule, ML models such as neural networks typically need a lot of data to learn how to extract that information. To ensure that azide groups are being used by the model to make predictions with small data, an explicit feature corresponding to the number of such groups can be put in the feature vector.

参考资料：
1. [Applying machine learning techniques to predict the properties of energetic materials](https://www.nature.com/articles/s41598-018-27344-x#Sec1)
1. [中译版：应用机器学习高能材料预测分子性质](https://bohrium.dp.tech/notebooks/47434212168)

###### Case 2: 过渡态搜索
1. [OA-ReactDiff: 当扩散生成模型遇到化学反应-- 现代“AI炼金术”](https://bohrium.dp.tech/notebooks/91481195231)

###### Case3: Uni-Mol预测液流电池溶解度
1. [Uni-Mol预测液流电池溶解度](https://bohrium.dp.tech/notebooks/7941779831)

![](/img/wc-tail.GIF)
