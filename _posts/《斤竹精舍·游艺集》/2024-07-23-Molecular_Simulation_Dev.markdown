---
layout:     post
title:      "分子模拟 · 发展"
subtitle:   ""
date:       2024-07-23 07:57:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - 分子模拟
    - 2024


---

###### 化学反应自动设计软件Automated Design of Chemical Reaction（ADCR）
由南京大学黎书华教授课题组开发的一款闭源免费的自动搜索化学反应路径的一个程序集，它利用将分子动力学模拟和坐标驱动结合的方法（Combined Molecular Dynamics and Coordinate Driving，MD/CD），自动搜索复杂反应体系的反应路径并构建反应网络。程序网站为：[https://itcc.nju.edu.cn/shuhua/index_ADCR.html](https://itcc.nju.edu.cn/shuhua/index_ADCR.html)

MD/CD方法使用MD模拟实现低能垒过程的搜索；使用改进的CD技术搜索能垒较高的化学过程，获得可能的过渡态和中间体的结构。对反应物和搜索过程中产生的中间体依次进行MD/CD计算，就能组合出较为完整的化学反应网络（详见：Phys. Chem. Chem. Phys. 2023,25, 23696）

当前版本的ADCR程序支持在本地工作站、LSF作业管理系统及Slurm作业管理系统上运行，支持以MPI的方式跨节点并行计算。软件的特色包括：1）易于上手，仅需要具备使用常见的量子化学软件的基本技能，比如使用Gaussian软件进行常规DFT计算和使用xtb软件进行半经验计算等；2）ADCR程序提供了自动化的计算选项，同时也允许用户根据自己的直觉进行一些手动干预，如选择优先反应中心或指定基元反应步数等，以提高计算效率。

目前，程序已计算测试了包含大约50种经典有机化学过程。适用的化学反应体系的包括：1）均相闭壳层有机反应；2）自由基反应；3）过渡金属催化反应机理研究；4）单电子转移过程；5)支持以溶质-溶剂团簇的方式搜索溶液相的化学反应等。

![](/img/wc-tail.GIF)
