---
layout:     post
title:      "LAMMPS 蒙特卡洛 Monte Carlo"
subtitle:   ""
date:       2026-06-10 22:12:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2026

---

Motivation: Why Use Monte Carlo in LAMMPS?   

Limitations of MD：   
1. Does not allow number of particles to change 
1. Sampling limited by slow translational dynamics e.g. interdiffusion in metal alloys 


Monte Carlo Methods：  
1. Allow unphysical moves that can overcome kinetic barriers 
1. Allows atoms or molecules to be added or removed 
1. Allows atoms to switch to a different element 
1. Faithfully preserves equilibrium Boltzmann probability distribution of atomic configurations, atom counts, molecule counts, etc.

1. [Monte Carlo Simulations with LAMMPS](https://www.lammps.org/workshops/Aug15/PDF/talk_Thompson1.pdf)
1. LAMMPS Manual，比如`lammps-2Aug2023/doc/Manual.pdf`


1. []()

1. []()


1. [知乎：LAMMPS-SGCMC学习](https://zhuanlan.zhihu.com/p/135347868)
1. [知乎：LAMMPS-GCMC学习（2）](https://zhuanlan.zhihu.com/p/133863516)
1. []()


1. [Chemical potential for the use of gcmc](https://matsci.org/t/chemical-potential-for-the-use-of-gcmc/25928)
1. [[Lammps] lammps-gcmc模拟甲烷吸附SIO2表面的问题](http://bbs.keinsci.com/thread-39202-1-1.html)
1. []()

![](/img/wc-tail.GIF)
