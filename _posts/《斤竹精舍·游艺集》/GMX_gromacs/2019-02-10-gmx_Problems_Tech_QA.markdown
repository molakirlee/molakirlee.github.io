---
layout:     post
title:      "Gromacs问题 Q&A"
subtitle:   ""
date:       2019-02-10 20:39:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2019

---

Google找不到可以在这个mail box里找一下，里面有很多相关的提问和回答：[mail-archive](https://www.mail-archive.com/)


### 遇到过的问题
###### ... no domain decomposition for 20 ranks...
```
Fatal error:
There is no domain decomposition for 20 ranks that is compatible with the given box and a minimum cell size of 0.929375 nm  
Change the number of ranks or mdrun option -rcon or -dds or your LINCS settings  
Look in the log file for details on the domain decomposition  
For more information and tips for troubleshooting, please check the GROMACS website at http://www.gromacs.org/Documentation/Errors  
```

Solution:
Use following command line: `gmx mdrun -v -deffnm em -nt 8`  
I used the option "-nt 1" to make it work. Sometimes the simulation is too small to be divided.  
sob老师说是因为原子数较少所致的域分解错误，可以用-ntmpi 1解决。

参见[Gromacs Errors](http://www.gromacs.org/Documentation/Errors#There_is_no_domain_decomposition_for_n_nodes_that_is_compatible_with_the_given_box_and_a_minimum_cell_size_of_x_nm)  

###### 2019.2 build warnings
开发者说：The warning are harmless, something happened in the build infrastructure which emits some new warnings that we've not caught before the release.  
具体参见：[[gmx-users] 2019.2 build warnings](https://mailman-1.sys.kth.se/pipermail/gromacs.org_gmx-users/2019-April/125095.html)

###### 盐离子团聚
Q:水环境体系中K+和Cl-为什么跑完动力学以后都团聚到一块了？  
A:amber99力场描述高浓度离子不合理,当年sob老师也遇到了相同的问题(doi: 10.3866/PKU.WHXB201506191)，后来改用KBFF力场就没问题了。明显是amber力场的缺陷。  
Q:在研究盐对蛋白的影响，如果浓度不太高的话用amber99合理吗？比如生理环境中的137mM。  
A:生理环境没问题,只要看见结晶肯定不行  
更新：  
这是amber力场的缺陷，通过修改LJ参数可以进行修正，具体参数见文献(注意：建议将新的离子的LJ参数和原子类型单独放在两个itp里调用，直接修改力场源文件中的参数可能效果不理想)：  
1. Joung I S, Cheatham III T E. Determination of alkali and halide monovalent ion parameters for use in explicitly solvated biomolecular simulations[J]. The journal of physical chemistry B, 2008, 112(30): 9020-9041.
2. Auffinger P, Cheatham T E, Vaiana A C. Spontaneous formation of KCl aggregates in biomolecular simulations: a force field issue?[J]. Journal of chemical theory and computation, 2007, 3(5): 1851-1859. （文中的rmin应为0.5rmin）
3. Joung I S, Cheatham III T E. Molecular dynamics simulations of the dynamic and energetic properties of alkali and halide ions using water-model-specific ion parameters[J]. The Journal of Physical Chemistry B, 2009, 113(40): 13279-13290. (文献1基础上考察更多参数)

###### Right hand side '1.0  1.0' for parameter 'tau_p' in parameter file is not a real value
在NPT中使用semiisotropic的时候，若将`tau_p`设置为两个参数则可能会报错。实际上，与温度耦合不同，压力耦合的`tau_p`就是一个参数（虽然`ref_p`和`compressibility`是两个参数）。  
参见mailing list: [strange behaviout in 5.1.2](https://mailman-1.sys.kth.se/pipermail/gromacs.org_gmx-users/2016-February/103459.html)  

###### LINCS WARNING
因为约束而报错：   
```
Step 500, time 0.5 (ps)  LINCS WARNING
relative constraint deviation after LINCS:
rms 178.962402, max 279.656189 (between atoms 2 and 3)
bonds that rotated more than 30 degrees:
 atom 1 atom 2  angle  previous, current, constraint length
      3      4   85.1    4.1929  58.3083      0.2700
      3      5   89.2    2.6759  61.9056      0.2700
      4      5  157.9    2.7246  41.7282      0.2700
```

1. 这种错误往往是因为topol不合理而导致的，比如约束过多的话为了满足一些约束而超出另一些约束的阈值。
1. 别都用键长约束，可以换用键角的时候用键角约束替换掉一些键长约束。（如嘉兴之前做Fmoc的时候中间五元环简化成3个珠子，如果用三个键长来约束的话就会爆炸，如果用两个键长加一个键角的话就正常了。）
1. 注意二面角的0°和180°是不一样的，跟表面序号有关系。（from Supernova）

###### MoS2-水体系跑MD只在原位置振动
如果成键参数定义的太强，则在grompp时会有如下提示：
```
Note 2 [file topol.top, line 45]:
  The bond in molecule-type MoS between atoms 1 S1 and 6 Mo1 has an
  estimated oscillational period of 6.9e-03 ps, which is less than 10 times
  the time step of 1.0e-03 ps.
  Maybe you forgot to change the constraints mdp option.
```
这是因为约束强的时候化学键的振动频率高，如果低于步长的5倍之类的，那么在跑MD的过程中就会出现重原子只在原位置振动的现象，跟冻住了一样。解决方法就是增大步长或者减小成键约束。

![](/img/wc-tail.GIF)
