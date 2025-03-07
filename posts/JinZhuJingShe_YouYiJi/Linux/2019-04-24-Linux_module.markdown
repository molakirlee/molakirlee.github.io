---
layout:     post
title:      "Linux Module使用说明"
subtitle:   ""
date:       2019-02-24 20:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Linux
    - 2019

---
  
参考资料：
1. [Modules环境模块管理工具](https://liuyujie714.com/48.html#more)  

  
### 简介
Environment Modules软件包以模块为单位，为用户动态设置Linux或UNIX的环境变量的软件。
模块的概念，“应用名”和“应用的版本”的二元组，即一个模块对应的是一个特定版本的应用。
Environment Modules软件包独立于具体使用的Shell，支持多种主流的Shell。
最新版本:2012.12发布的modules-3.2.10
官网http://modules.sourceforge.net/

###### 安装
可参考[mudules 安装使用](https://www.jianshu.com/p/fed0af3c7ff5)和[使用 Environment Module 管理不同版本软件](https://enigmahuang.github.io/2017/02/22/Environment-Modules-Usage/)  
```
sudo yum install -y environment-modules  
sudo apt-get install environment-modules  
```

Modules软件包的初始化与具体Shell的初始化一起完成，具体过程如下：  
创建module命令（实际执行modulecmd应用）  
创建Modules环境变量（通过modulefile文件配置）  
创建环境的快照（开启的情况下），如$HOME/.modulesbeginenv  


modulefile文件，动态配置模块，可能存在多个  
位于MODULEPATH环境变量指定的路径中  
默认/etc/modulefiles/目录下  


###### 常用命令
module help 查看帮助  
等价于module -h 查看帮助  
module avail 查看可用模块  
module list 查看已经加载的模块  
module add <模块名>加载模块  
等价于module load <模块名>加载模块  
module rm <模块名>卸载模块  
等价于module unload <模块名>卸载模块  
module purge 卸载所有模块  
module switch <旧模块> <新模块>替换模块  
等价于module swap <旧模块> <新模块>替换模块  
module whatis <模块名>查看模块说明  
module show <模块名>查看模块内容  
等价于module display <模块名>查看模块内容  
module use -a <路径>将指定路径追加到MODULEPATH中  
等价于module use --append <路径>将指定路径追加到MODULEPATH  

##### 常用的 PBS 环境变量：    

|Command|Description|  
|------|------|  
|module avail|List the available modules. Note that if there are multiple versions of a single package that one will be denoted as (default). If you load the module without a version number you will get this default version.|
|module whatis|List all the available modules along with a short description.|
|module load MODULE|Load the named module.|
|module unload MODULE|Unload the named module, reverting back to the OS defaults.|
|module list|List all the currently loaded modules.|
|module help|Get general help information about modules.|
|module help MODULE|Get help information about the named module.|
|module show MODULE|Show details about the module, including the changes that loading the module will make to your environment.|

### Module范例——Gromacs 

无后缀文本文件作为modulefile，内容如下：  
```
#%Module -*- tcl -*-
##
## modulefile
##

set name    gromacs
set version 5.1.4
set root    /home/users/ntu/n1805727/GMX5.1.4_Mine/gromacs-5.1.4-gpu
set url     http://www.gromacs.org


module-whatis "adds $name version $version to your environment variables."

module load gcc/4.9.3
module load openmpi/intel/1.10.2
module load cuda80/toolkit/8.0.44

setenv GMXBIN                $root/bin
setenv DSSP                  $root/bin/dssp
setenv GMXDATA               $root/share/gromacs
setenv GMXLDLIB              $root/lib64
setenv GMXMAN                $root/share/man
setenv GROMACS_DIR           $root
setenv PKG_CONFIG_PATH       $root/lib64/pkgconfig
prepend-path LD_LIBRARY_PATH $root/lib64
prepend-path MANPATH         $root/share/man
prepend-path PATH            $root/bin
```

![](/img/wc-tail.GIF)
