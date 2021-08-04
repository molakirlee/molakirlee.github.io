---
layout:     post
title:      "gmx Anaconda及MDAnalysis安装"
subtitle:   ""
date:       2020-05-14 17:25:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2020

---

###### 前言
之前在win系统下用pip安装MDAnalysis一直没有成功，问了下好像很多人都没成功，经supernova推荐，又看了下官网，决定改用conda安装，为了方便就用anaconda了。  

###### Anaconda的安装
关于Anaconda，安装可参考下面两篇资料，简单概括一下：
1. 根据系统和所想支持的python的版本，从Anaconda官网下载安装包；（xilock用的许多脚本只支持py2.7语言，所以下载py2.7，如果想用更高版本的只需后期在conda里创建相应python版本的环境。）
1. 安装完几个G大，所以留足硬盘空间。
1. win下直接管理员模式运行安装包即可，注意**让添加path时不要添加**，**让选择给谁安装时只给当前用户安装**。
1. 安装完成后在菜单栏打开Anaconda Prompt，输入命令`conda list`，若显示出一大堆packages的信息则说明安装成功了。

参考资料：
1. [Anaconda介绍、安装及使用教程](https://zhuanlan.zhihu.com/p/32925500)
1. [Anaconda详细安装及使用教程](https://blog.csdn.net/ITLearnHall/article/details/81708148)（不要参考此文安装部分，参考其总结的命令）

###### MDAnalysis的安装

参考资料：
[Installing MDAnalysis: conda-installation](https://www.mdanalysis.org/MDAnalysisTutorial/installation.html#conda-installation)

简单概括一下：  

1.The latest release of MDAnalysis (and the full test suite) can be installed from the conda-forge anaconda.org channel with conda:  
```
conda config --add channels conda-forge
conda update --yes conda
```
2.MDAnalysis fully supports Python 3.4+ and 2.7.x (since release 0.17.0). We will install a Python 3.6 environment that we call mdaenv:  
```
conda create --yes -n mdaenv python=3.6
```
3.Install MDAnalysis and the tests including data files in the mdaenv environment:  
```
conda install --yes -n mdaenv MDAnalysis MDAnalysisTests
```
4.Activate the installation (has to be done in every shell, whenever you want to use MDAnalysis)（linux下激活用source不用conda）:
```
conda activate mdaenv
```
5.Check success  
```
(mdaenv) $ python -c 'import MDAnalysis as mda; print(mda.__version__)'
0.18.0
```

以后每次使用都用Anaconda Prompt进入目标路径后激活mdaenv环境即可。

![](/img/wc-tail.GIF)
