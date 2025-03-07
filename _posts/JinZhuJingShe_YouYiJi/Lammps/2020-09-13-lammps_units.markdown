---
layout:     post
title:      "LAMMPS units"
subtitle:   ""
date:       2020-09-13 22:11:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### units lj

LJ是约化单位，主要是用于[universal的情况](https://lammps.sandia.gov/threads/msg62544.html)。这种方式由用户自行指定基本物理量的基本单位（如epsilon等于多少,sigma等于多少），这些基本物理量的基本单位不是设定在哪里的，而是用户假定的。比如用户假定epsilon为2.5 kJ/mol，这个epsilon不是pair_coeff的epsilon，而是存在于用户脑子里的，给这个系统定义的基本单位，我们可以称zhi为epsilon*，有了这个epsilon*，我们就可以定义系统中的物理量了，比如pair_coeff的epsilon设定为1那就意味着其epsilon为1个epsilon*，也就是2.5 kJ/mol，如果pair_coeff的epsilon设定为2那就意味着其epsilon为5.0 kJ/mol。其它同理，比如data文件里的距离都是以1为单位的（无单位无量纲），你用real的时候那就是以1 angstrom为单位，用lj的时候就是以无量纲的1为单位。这样就形成了一个universal的系统。


其它参考：  
1. [LAMMPS manual - units command](https://lammps.sandia.gov/doc/units.html)
1. [How to convert the DPD units of temperature for lj system of lammps into real temperature e.g. Kelvin ?](https://www.researchgate.net/post/How_to_convert_the_DPD_units_of_temperature_for_lj_system_of_lammps_into_real_temperature_eg_Kelvin)
1. [Confusing LJ units in LAMMPS?](https://www.researchgate.net/post/Confusing_LJ_units_in_LAMMPS)




![](/img/wc-tail.GIF)
