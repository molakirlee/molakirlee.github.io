---
layout:     post
title:      "gmx 虚拟退火simulated annealling"
subtitle:   ""
date:       2020-04-26 10:22:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2020

---

###### 关于退火
ref-t是参考温度，热浴是指控温的算法，退火模拟不需要设置ref-t但需要设置热浴。应当溶剂和蛋白分别控温，否则容易造成热溶剂冷溶质现象，达不到想要的目的。

```
tcoupl           = v-rescale ; 
tc-grps          = Protein Non-Protein ; 
tau_t            = 0.1     0.1 ; 
;ref_t            = 298.15  298.15    ; 
;annealing
annealing = single single ; single or periodic
annealing-npoints = 5 5
annealing-time = 0 5000 10000 15000 20000 0 5000 10000 15000 20000 ; ps
annealing-temp = 273.15 288.15 277.15 298.15 310.15 273.15 288.15 277.15 298.15 310.15 ; K
```

###### 注意


###### manual中相关信息

annealing:  
Type of annealing for each temperature group  
no  
No simulated annealing - just couple to reference temperature value.  
single  
A single sequence of annealing points. If your simulation is longer than the time of the last point, the temperature will be coupled to this constant value after the annealing sequence has reached the last time point.  
periodic  
The annealing will start over at the first reference point once the last reference time is reached. This is repeated until the simulation ends.  

annealing-npoints:  
A list with the number of annealing reference/control points used for each temperature group. Use 0 for groups that are not annealed. The number of entries should equal the number of temperature groups.  
annealing-time:  
List of times at the annealing reference/control points for each group. If you are using periodic annealing, the times will be used modulo the last value, i.e. if the values are 0, 5, 10, and 15, the coupling will restart at the 0ps value after 15ps, 30ps, 45ps, etc. The number of entries should equal the sum of the numbers given in annealing-npoints.  
annealing-temp:  
List of temperatures at the annealing reference/control points for each group. The number of entries should equal the sum of the numbers given in annealing-npoints.  

Confused? OK, let's use an example. Assume you have two temperature groups, set the group selections to annealing = single periodic, the number of points of each group to annealing-npoints = 3 4, the times to annealing-time = 0 3 6 0 2 4 6 and finally temperatures to annealing-temp = 298 280 270 298 320 320 298. The first group will be coupled to 298K at 0ps, but the reference temperature will drop linearly to reach 280K at 3ps, and then linearly between 280K and 270K from 3ps to 6ps. After this is stays constant, at 270K. The second group is coupled to 298K at 0ps, it increases linearly to 320K at 2ps, where it stays constant until 4ps. Between 4ps and 6ps it decreases to 298K, and then it starts over with the same pattern again, i.e. rising linearly from 298K to 320K between 6ps and 8ps. Check the summary printed by grompp if you are unsure!

###### 参考资料
1. [gromacs manual](https://manual.gromacs.org/archive/4.6.3/online/mdp_opt.html)


![](/img/wc-tail.GIF)
