---
layout:     post
title:      "LAMMPS建模"
subtitle:   ""
date:       2020-09-24 11:52:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### 用VMD转换data文件
参见博文《VMD在LAMMPS中的应用》

### moltemplate
###### 安装
其实不用安装，因为lammps_root/tools里就有，如果需要安装，参见：http://www.moltemplate.org/download.html  
###### 使用
Example可参见：http://www.moltemplate.org/visual_examples.html  
以“Coarse-grained lipid bilayer”为例：  
给moltemplate准备的输入文件：  
1. xyz文件：system.xyz
1. moltemplate文件：lipid.lt、water.lt、system.lt

具体步骤如下：
1. 用packmol等生成体系的xyz文件；
1. 编写lipid.lt和water.lt文件。二者分别包括了1个lipid和1个water的分子的原子参数及成键/非键相互作用参数，可以先用topotools来生成1个lipid和1个water的data文件然后在其基础上进行修改来得到。
1. 编写system.lt文件。其中包括了导入lipid.lt与water.lt的信息以及对全系统的处理，如：分别导入多少个lipid分子、多少个water分子，lipid分子中原子与water分子中原子的非键相互作用参数等。
1. 用moltemplate来基于system.xyz和system.lt生成`moltemplate.sh -xyz system.xyz system.lt`。


### 参考：
1. [个人总结导出data的方法](http://www.isimuly.cn/forum.php?mod=viewthread&tid=438&extra=page%3D6)
1. [msi2lmp的使用方法和晶体结构转化详解](http://dxli75.blog.163.com/blog/static/1067682892010419795847/)
1. [LAMMPS data文件创建工具--moltemplate](https://zhuanlan.zhihu.com/p/99872512)
1. 


![](/img/wc-tail.GIF)
