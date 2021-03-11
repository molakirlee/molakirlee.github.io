---
layout:     post
title:      "LAMMPS MS生成lmp输入文件 msi2lmp"
subtitle:   ""
date:       2020-12-06 22:03:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### 使用说明
###### 指定力场 
1. MS中对建好的*.cif模型文件指定力场。Modulus => Discover => Setup => Select => cvff（新版本在forcite模块中指定为cvff力场，注意不要执行run，直接关闭。）；
1. 然后把Typing中,List all forcefield types前面的勾选去掉；
1. 最后点选,Calculate 
1. 把模型导出为*.car格式，将同时生成*.car 和*.mdf文件。 

###### 生成可执行程序msi2lmp.exe 
/lamps-30Jul16/tools/msi2lmp/src文件夹下执行make命令，将会生成msi2lmp.exe可执行文件。

###### 转化*.data 
1. 将lammps目录下tool/msi2lmp/frc_files文件夹拷贝到临时目录；
1. 将第一步生成的*.car和*.mdf文件（如benzene-class1.car和benzene-class1.mdf）和第二步得到的msi2lmp.exe拷贝到frc_files文件夹下；
1. 由于/frc_files中已经存在各种所需的力场，所以不再需要拷贝cvff.frc；
1. 然后在此文件夹下输入命令： `./msi2lmp.exe benzene-class1 -class I -frc cvff.frc -i –n`，生成的XXX.data就是需要的data文件。 

### 说明
1. 需要在src文件夹下执行make命令后才会生成msi2lmp.exe，否则无法找到。 
1. 不能把*.car和*.mdf文件和第二步得到的msi2lmp.exe拷贝到自己建的单独文件夹中，虽然有人说可以这么做，但实测发现会报错“/frc_files/cvff.frc cannot”。 
1. 第三步只生成*.data文件，并不像‘有些文档’所说的会生成两个文件。具体原因可能是版本不同？
1. 命令中“I”是罗马字母1，不是字符“$|$”或1。 
1. 具体命令的含义参见/lammps-30Jul16/tools/msi2lmp/中的README。 
1. 因为msi2lmp很久没更新了，有些力场参数之类的可能没有，调用时会报错：`unable to find …… data`（原因见参考资料）。如`msi2lmp Unable to find bond data for cp n`就是说找不到这两种原子的成键信息，但xilock检查生成的data文件后发现成键信息是有的，但成键参数都是0，所以添加上成键参数就行了（其他情况具体分析）。
1. 如果是直接对晶胞进行处理，则需要先`make P1`来吧结构对称性去掉，否则会报错：“Msi2LMP is not equipped to handle symmetry operations”
1. frc文件未必完成，调用前可根据情况进行补充，例如：https://lammps.sandia.gov/threads/msg46719.html。

### 附录
msi2lmp的部分README内容
```
    The program is started by supplying information at the command prompt
    according to the usage described below.  

    USAGE: msi2lmp.exe <ROOTNAME> {-print #} {-class #} {-frc FRC_FILE}
                {-ignore} {-nocenter} {-shift # # #}

   -- msi2lmp.exe is the name of the executable
   -- <ROOTNAME> is the base name of the .car and .mdf files
   -- -2001
         Output lammps files for LAMMPS version 2001 (F90 version)
         Default is to write output for the C++ version of LAMMPS

   -- -print (or -p)
	 # is the print level  0 - silent except for error messages
	                       1 - minimal (default)
                               2 - verbose (usual for developing and
                                   checking new data files for consistency)
                               3 - even more verbose (additional debug info)

   -- -ignore (or -i)     ignore errors about missing force field parameters
                          and treat them as warnings instead.

   -- -nocenter (or -n)   do not recenter the simulation box around the
                          geometrical center of the provided geometry but
                          rather around the origin

   -- -oldstyle (or -o)   write out a data file without style hints
                          (to be compatible with older LAMMPS versions)

   -- -shift (or -s)      translate the entire system (box and coordinates)
                          by a vector (default: 0.0 0.0 0.0)

   -- -class  (or -c)
        # is the class of forcefield to use (I  or 1 = Class I e.g., CVFF, clayff)
                                            (O  or 0 = OPLS-AA)
                                            (II or 2 = Class II e.g., CFFx, COMPASS)
        default is -class I

   -- -frc    (or -f) specifies name of the forcefield file (e.g., cff91)
 
     If the file name includes a directory component (or drive letter 
     on Windows), then the name is used as is. Otherwise, the program
     looks for the forcefield file in $MSI2LMP_LIBRARY (or %MSI2LMP_LIBRARY%
     on Windows). If $MSI2LMP_LIBRARY is not set, ../frc_files is used
     (for testing). If the file name does not end in .frc, then .frc
     is appended to the name.

     For example,  -frc cvff (assumes cvff.frc is in $MSI2LMP_LIBRARY
                              or ../frc_files)

                   -frc cff/cff91 (assumes cff91.frc is in cff)

                   -frc /usr/local/forcefields/cff95
                       (assumes cff95.frc is in /usr/local/forcefields/)

     By default, the program uses $MSI2LMP_LIBRARY/cvff.frc  or
      ../frc_files/cvff.frc depending on whether MSI2LMP_LIBRARY is set.

  -- the LAMMPS data file is written to <ROOTNAME>.data
     protocol and error information is written to the screen.
```

### 参考资料
1. [msi2lmp生成data文件](https://wenku.baidu.com/view/4c764dbb03d276a20029bd64783e0912a2167c2e.html?re=view)
1. [关于msi2lmp出错unable to find…..data的解析——Pcff力场分配参数流程](https://www.shehunotes.cn/?p=226#opennewwindow)
1. [msi2lmp使用方法-msi2lmp程序的README文件翻译](https://www.shehunotes.cn/?p=190)
1. [利用msi2lmp工具转换Materials Studio模型到lammps模型时出现多余原子错误](https://www.shehunotes.cn/?p=166)
1. [一份分子动力学模拟资源 lammps+MS 适合初学者](https://wenku.baidu.com/view/6739580602020740be1e9b27?pcf=2&bfetype=new)
1. [Msi2LMP is not equipped to handle symmetry operations](http://muchong.com/html/201707/4566649.html)
1. [Building LAMMPS data files with car/mdf files and the msi2lmp utility](https://lammps.sandia.gov/workshops/Feb10/Jeff_Greathouse/msi2lmp.pdf)


![](/img/wc-tail.GIF)
