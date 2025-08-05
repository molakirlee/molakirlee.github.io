---
layout:     post
title:      "LAMMPS variable变量"
subtitle:   ""
date:       2020-10-24 17:39:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### 注意
1. 当变量的值不是表达式字符串，而是一个具体的值时，变量是可以被重新定义的。
1. 用`$`引用变量的时候不能嵌套，即不能`${hello_$i}`

### 其它
###### [v_和&的区别](https://zhuanlan.zhihu.com/p/393693495)
1. “&”立即获取变量值，`variable L0 equal ${tmp}`这句命令是把变量“tmp”的值立即计算出来，而tmp的值为lx，因此，系统取得lx的值36.1，并将36.1赋值给L0。
1. “v_"获取变量计算公式，暂不计算具体数值。`variable L1 equal v_tmp`上命令运行后，L1的值等于v_tmp的值，即L1=v_tmp，但此时并不计算v_tmp的值，又因为v_tmp=lx，因此L1=lx。但此时，并没有将lx的值赋值给L1，仅仅是明确这种相等的关系。当在下一句thermo命令输出L1的时候，再计算L1的值，根据公式L1=lx，系统计算此时lx的值，并复制给L1。


```
units           metal
atom_style      atomic
timestep 0.001
lattice         fcc 3.61
region          box block 0 10 0 5 0 5
create_box 1 box
create_atoms 1 box
pair_style  eam
pair_coeff      * * Cu_u3.eam
velocity        all create 300 8989
#定义变量L0，L1
variable tmp equal "lx"
variable L0 equal ${tmp}
variable L1 equal v_tmp
#输出
thermo 10
thermo_style    custom step v_L0 v_L1 lx
fix  1 all npt temp 300 300 0.01 y 0 0 0.1 z 0 0 0.1
fix  2 all deform 1 x erate 0.02 units box remap x
run 100
```



### 参考资料
1. [LAMMPS 变量的使用 (五)](https://cloud.tencent.com/developer/article/1484609)
1. [variable command](https://lammps.sandia.gov/doc/variable.html)

![](/img/wc-tail.GIF)
