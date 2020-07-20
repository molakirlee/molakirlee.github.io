---
layout:     post
title:      "Crystal安装及测试 UNIX/Linux"
subtitle:   ""
date:       2020-07-16 20:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - 2020
    - Crystal

---

### 前言
Crystal主要包括两个模块：crystal和properties
1. crystal:compute the energy, analytical gradient and wave function for a given geometry, which can also be fully optimized, compute frequencies at Gamma.
1. properties:compute one electron properties (electrostatic potential, charge density, ...); analyse the wave function in direct and reciprocal space transform the Bloch functions (BF) into Wannier functions (localization of BF)

###### crystal的运行模式
1. crystal      sequential execution
1. Pcrystal     replicated data parallel execution
1. MPPcrystal   distributed data parallel execution

本文以sequential为例介绍安装，Pcrystal和MPPcrystal的安装参见http://www.crystal.unito.it => documentation  

###### 软件计算过程
The two programs, crystal and properties,  interact via files stored on disk.
1. crystal: Unformatted wave function information is written by crystal in file fort.9; formatted wave function (wf) information is written by crystal in file fort.98. 
1. properties: properties can read  wf information computed by crystal unformatted (file fort.9) or formatted (file fort.98). Formatted data written in file fort.98 can be moved from one platform to another (e.g.: from Opteron to Itanium).

###### 部分术语
1. "ARCH"    string to identify the operating system and/or the compiler (e.g. Linux-pgf, Linux-ifort, MacOsx)
1. "VERSION" string to identify the crystal version (e.g. v1.0.3)
1. d12      extension of file meant to be input to crystal
1. d3       extension of file meant to be input to properties 

注：sequential版本不需要安装ifort，并行版的话需要，具体参见Pcrystal和MPPcrystal的安装教程。

### 安装过程
###### bin包
1. log in as a generic user, and cd to your home directory
1. make the crystal root directory - it is called $CRY2K14_ROOT in the following
1. change directory to $CRY2K14_ROOT
1. 下载与自己系统适配的代码包至$CRY2K14_ROOT，如crystal14_v1_0_3_Linux-ifort_XE_openmpi-1.6_amd64.exe.tar.gz
1. decompress the files: `gunzip crystal14_v1_0_3_Linux-ifort_XE_openmpi-1.6_amd64.exe.tar.gz`， 得到crystal14_v1_0_3_Linux-ifort_XE_openmpi-1.6_amd64.exe.tar
1. untar the files: `tar -xvf crystal14_v1_0_3_Linux_XE_openmpi-1.6_amd64.exe.tar`， 得到解压后的文件夹（The directory bin contains a sub-directory foreach type of executable, identified by a string (ARCH), and for each release (the first one being v1.0.0).）
###### utils
1. 下载utils（如utils14.zip）至$CRY2K14_ROOT
1. decompress and untar the file: `gunzip utils14.tar.gz` 和 `tar -xvf utils14.tar`，得到一堆文件：runcry14、runmpi14、runprop14、cry2k14.cshrc、cry2k14.bashrc、runcry14mp2、runcryscor09  
1. 进入utils14文件夹后提升其中执行文件的权限: `chmod +x run*`
1. 备份cry2k14.bashrc文件（cry2k14_copy.bashrc）后对cry2k14.bashrc中的3个变量进行修改：CRY2K14_ROOT:CRYSTAL14 root directory(e.g. CRYSTAL14), CRY2K14_ARCH:ARCH string to identify the executable(e.g. Linux-pgf), CRY2K14_SCRDIR:temporary directory for scratch files(e.g. $HOME)
1. 将cry2k14.bashrc文件复制到home文件夹中，在~/.bashrc中添加 `source cry2k14.bashrc` 并在terminal中执行一下该命令
###### 测试case
1. 下载case文件：http://www.crystal.unito.it/test_cases/inputs_wf.tar.gz 
1. 或者For tests on geometry optimization and vibrational frequencies calculation see the CRYSTAL tutorials home page: http://www.crystal.unito.it/tutorials/index.html， 或者move to http://www.crystal.unito.it ==> documentation ==> test cases and download input files.
1. 解压算例文件: `gunzip *.gz` 和 `tar -xvf inputs.......tar`，之后得到一堆文件：crystal (*.d12) and properties (*.d3)
1. 新建文件夹test_case并将test11 (bulk MgO) 复制进去，运行算例: `runcry14 test11`，开始计算，完成后得到文件: test11.out: standard output (crystal+properties); test11.f9: unformatted wf data (written by crystal); test11.f98: formatted wf data (written by crystal)
1. 查看单点能: `grep "GY(HF" test11.out`, 结果应为:TOTAL ENERGY(HF)(AU)(   7) -2.7466419188884E+02 DE 3.7E-08 tst 3.2E-09 PX 4.1E-04
###### 可视化软件Crgra2006安装（非必要）
1. The package for visualization of bands, doss, maps, from the data written in file fort.25 by the program properties. 下载链接: http://www.crystal.unito.it/crgra2006/crgra2006.html ；
1. 确认电脑上有A standard postscript visualizer, called by the command gv，可以用`whereis gv`查看；
1. 解压缩 `gunzip Crgra2006.tar.gz` `tar -xvf Crgra2006.tar`，得到一堆band, doss, maps之类的文件和文件夹；
1. 将Crgra2006添加到环境变量里（在cry2k14.bashrc里修改默认路径即可）


参考资料: 
1. [howtorun](http://tutorials.crystalsolutions.eu/tutorial.html?td=others&tf=howtorun)
1. [howtoinstall](https://www.crystal.unito.it/Manuals/howtoinstall.txt)
1. [Tutorials](http://tutorials.crystalsolutions.eu/)
1. [A quick tour of CRYSTAL: Wave function calculation input and output](http://tutorials.crystalsolutions.eu/tutorial.html?td=others&tf=quick)

![](/img/wc-tail.GIF)
