---
layout:     post
title:      "LAMMPS 熵等热力学性质计算2PT Two Phase Thermodynamics"
subtitle:   ""
date:       2025-11-17 22:12:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2025

---

[2PT下载地址](https://github.com/molakirlee/2PT_TwoPhaseThermodynamics.git)

###### 安装及使用说明
1. 安装fftw，用默认的双精度，[下载地址](https://www.fftw.org/download.html)
1. Extract the contents of the compressed file into your favorite directory: `tar –zxof 2pt.tar.gz (on linux) `
1. Make sure which compiler you have, g++ (in gnu)  or icpc (in intel). Check whcich do you have by `g++ --version` or `icpc --version`.
1. Rename the Makefile.gnu or Makefile.intel into Makefile.
1. Navigate to the 2pt/src directory and edit the Makefile to point to the location of the compiler.
1. Navigate to the 2pt/src directory and edit the Makefile to point to the location of the FFTW3 library 
1. Type ‘make install’ in this directory. If all goes well you should have a binary called 2pt_analysis in the ../bin directory 
1. Create your control file 
1. Run the analysis using “{install_directory}/2pt/bin/2pt_analysis {control_file}”

###### 需要准备的文件
1. 结构文件,如lammps的data文件
1. 轨迹文件 ，可用下文2PT模拟单独生成
1. control文件，控制2PT分析用
1. group文件（非必须）


###### 用于2PT分析的MD模拟用IN文件
2PT_simu.in
```
units			real
boundary		p p p 
dimension		3 

atom_style		full
bond_style		class2
angle_style		class2
dihedral_style	class2
improper_style	class2

pair_style		lj/class2/coul/long 12.0
kspace_style pppm 1.0e-4

read_data	   polymers_w_stage_NPTfinal.data

pair_modify	 mix geometric
neighbor		2.0 multi
neigh_modify	every 2 delay 4 check yes
thermo_style	multi
thermo_modify		line multi format float %14.6f
variable		sname index polymer_w

print "================================================"
print "NVT dynamics for 20ps dumping velocities"
print "================================================"
thermo          2
thermo_style    custom etotal ke temp pe ebond eangle edihed eimp evdwl ecoul elong press vol
thermo_modify	line multi
fix             1 all nvt temp 300.0 300.0 100.0
dump            1 all custom 2 ${sname}.2pt.lammps id type xu yu zu vx vy vz 
run             10000
undump          1
unfix           1
```

###### control文件
2pt.mol.in
```
IN_LMPDATA                    ./polymers_w_stage_NPTfinal.data
IN_LMPTRJ                     polymer_w.2pt
# IN_GROUPFILE                  2pt.mol.grp # Unnecessary
ANALYSIS_FRAME_INITIAL        1
ANALYSIS_FRAME_FINAL          0
ANALYSIS_FRAME_STEP           1
ANALYSIS_VAC_CORLENGTH        0.5
ANALYSIS_VAC_MEMORYMB         8000
ANALYSIS_VAC_2PT              3
ANALYSIS_OUT                  polymer_w.2pt.mol
ANALYSIS_LMP_TSTEP            0.002
ANALYSIS_VAC_LINEAR_MOL	      0
ANALYSIS_VAC_ROTN_SYMMETRY    2
ANALYSIS_VAC_FIXED_DF         648
ANALYSIS_SHOW2PT            1
```

###### group文件
2pt.mol.grp
```
Total Groups: 3
Group 1 Atoms 1300
1 - 1300
Group 2 Atoms 6678
1301 - 7978
Group 3 Atoms 12
7979 - 7990
```

![](/img/wc-tail.GIF)
