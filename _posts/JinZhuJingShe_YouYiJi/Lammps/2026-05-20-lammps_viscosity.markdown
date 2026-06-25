---
layout:     post
title:      "LAMMPS 粘度计算"
subtitle:   ""
date:       2026-05-20 22:12:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2026

---


参考资料：[黏度计算-AuToFF生成LAMMPS的力场拓扑data文件](https://autoff.readthedocs.io/en/latest/example.html#autofflammpsdata)

示例代码：

```
#-------------------------------------------------------------------------------------------------------------------#

variable        temperature     equal   298
variable        timestep        equal   1
variable        Tdamp           equal   ${timestep}*100
variable        Pdamp           equal   ${timestep}*1000
variable        drag            equal   0.7
variable        tequ            equal   1000
variable        trun            equal   1000000
variable        srate           equal   0.003
variable        scaling         equal   1e6/1e15

#-------------------------------------------------------------------------------------------------------------------#

units           real
boundary        p p p
atom_style      full
pair_style      lj/cut/coul/long 15.0
pair_modify     mix arithmetic
special_bonds   lj 0.0 0.0 0.5 coul 0.0 0.0 0.8333
kspace_style    pppm 1.0e-5
bond_style      harmonic
angle_style     harmonic
dihedral_style  fourier
improper_style  cvff
read_data       system.data            #导入体系拓扑信息文件
include         system.in.settings     #导入体系力场信息文件
thermo          1000
timestep        ${timestep}

#-------------------------------------------------------------------------------------------------------------------#

#minimize       1.0e-4 1.0e-6 100 1000
minimize         0.0 1.0e-8 1000 100000
fix             1 all nve/limit 0.1
fix             2 all langevin ${temperature} ${temperature} ${Tdamp} 123456 zero yes
run             1000
unfix           2
unfix           1

#-------------------------------------------------------------------------------------------------------------------#

fix             npt all npt temp ${temperature} ${temperature} ${Tdamp} iso 0 0 ${Pdamp} drag ${drag}
run             ${tequ}
unfix           npt

write_data      data.final

reset_timestep  0

#-------------------------------------------------------------------------------------------------------------------#

change_box      all triclinic

kspace_style    pppm 1.0e-5

fix             deform all deform 1 xy erate ${srate} remap v

fix             sllod all nvt/sllod temp ${temperature} ${temperature} ${Tdamp}

compute         usual all temp

compute         tilt all temp/deform

thermo_style    custom step temp c_usual epair etotal press pxy

thermo_modify   temp tilt

#--------------------------------------------------------------------------------------------------------#

fix             rescale all temp/rescale 1 ${temperature} ${temperature} 1.0 1.0

run             10000
unfix           rescale

run             10000
reset_timestep  0

#--------------------------------------------------------------------------------------------------------#

variable        visc equal -pxy/(${srate})*${scaling}

fix             vave all ave/time 10 100 1000 v_visc ave running start 500000

thermo_style    custom step temp press pxy v_visc f_vave

thermo_modify   temp tilt

run             ${trun}

```


![](/img/wc-tail.GIF)
