---
layout:     post
title:      "Tough3及PETSc安装"
subtitle:   ""
date:       2025-11-18 21:57:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - 2025


---

### 简介
TOUGH（Transport of Unsaturated Groundwater and Heat）是一套由美国劳伦斯伯克利国家实验室（Lawrence Berkeley National Laboratory, LBNL）开发的用于模拟多孔介质中多相流体流动与传热过程的数值模拟软件。它广泛应用于地热系统、二氧化碳地质封存（CCS）、核废料处置、地下水污染修复、油气开采等领域。

核心特点：  
1. 多相流体流动：支持气相、液相、超临界相等多种流体相态。
1. 多组分传输：可模拟多种化学组分（如H2O、CO2、CH4、空气等）的迁移。
1. 非饱和带流动：适用于包气带中水分和空气的流动。
1. 热传导与对流耦合：支持热-流-力-化（THMC）耦合过程。
1. 复杂几何与网格：支持结构化与非结构化网格，可与网格生成工具（如MeshMaker、TRELLIS）结合使用。


TOUGH的应用领域：  
1. 地热能开发：模拟地热储层中热水/蒸汽的流动与热提取过程。
2. 碳捕集与封存（CCS）：模拟CO2注入深层咸水层后的迁移、溶解、矿化过程（常用TOUGH2-EOS7或ECO2N）。
3. 核废料地质处置：分析废料罐周围热-水-力耦合效应，预测长期安全性。
4. 地下水污染与修复：模拟非水相液体（NAPL）在地下环境中的迁移（使用TMVOC模块）。
5. 页岩气/煤层气开采：模拟吸附/解吸过程与气体流动。
6. 冻土与天然气水合物：使用特定EOS模拟水合物生成与分解过程。


### WSL系统安装带PETSc的Tough3
1. [安装教程《tough3_installation_for_NewPackage》](https://tough.forumbee.com/media/download/m2pka6/tough3_installation_for_NewPackage.pdf）

###### WSL安装
1. 系统安装见“lammp安装”文章
1. 安装必要环境
```
sudo apt update
sudo apt upgrade
sudo apt install gcc gfortran mpich cmake libblas-dev liblapack-dev python2 python
```

###### PTESc安装
1. 编译教程tough3是匹配的PETSc3.7.4，xilock试过最新版本会停在`Scanning dependencied of target ..._parallel`，因此建议使用PETSc3.7.4
1. Copy file petsc-3.7.4.tar.gz  to you home directory:  `cp ./petsc-3.7.4.tar.gz ~ `
1. Unzip and untar the compressed file: 
```
cd ~ 
tar –xf ./ petsc-3.7.4.tar.gz 
```
1.  Configure and build PETSC:  
```
cd petsc-3.7.4 
./configure --with-debugging=0   --with-shared-libraries=0 --PETSC_ARCH=arch-t3 --download-fblaslapack
make
```
1. 记住PETSC directory (PETSC_DIR, can be found by typing pwd in ~/petsc3.7.4) 和 name of build directory (PETSC_ARCH，就是上面`--PETSC_ARCH=arch-t3 `指定的arch-t3), which is needed in TOUGH3 installation


###### Tough3安装

1. Go to your home directory and Create and go to a new directory “tough3-build”
```
mkdir tough3-build
cd tough3-build
```
1. Place TOUGH3 installation folders “esd-tough3” and “esd-toughlib” in this new directory
```
cp -R PATH_TO_ESD_TOUGH3 .
cp -R PATH_TO_ESD_TOUGHLIB .
```
1. Go to “esd-tough3”: `cd esd-tough3`
1. Compile desired EOS (for instance ECO2n): `../configure.sh --build-type=RELEASE --eos=eco2n --no-x11 --petsc-dir=/home/keniz/petsc-3.7.4 --petsc-arch=arch-t3 `



![](/img/wc-tail.GIF)
