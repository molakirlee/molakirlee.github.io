---
layout:     post
title:      "LAMMPS loop循环·if条件"
subtitle:   ""
date:       2020-10-14 13:52:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### loop循环
**注意，用jump时，提交任务一定要用`lmp -in input`而非`lmp < input`，否则jump时找不到label！**

###### 代码示例
有时候需要在input里做循环，以升温为例，其循环部分代码如下：  
```
variable mytemp index 500.0 700.0 900.0 1100.0 1300.0 1500.0 1700.0 1900.0 2100.0 2300.0
variable mytemp2 index 700.0 900.0 1100.0 1300.0  1500.0 1700.0 1900.0 2100.0 2300.0 2500.0

variable i loop 10
label loopa
fix 2 all nvt temp ${mytemp} ${mytemp2} 100.0
run 200
unfix 2

next mytemp
next mytemp2
next i
jump SELF loopa
```

说明：  
1. SELF是让程序执行到这里,跳回自己, 然后从标签 loopa开始执行. 当然loopa是随便取的, 你可以用CHN来做label.
1. [jumo命令](http://www.52souji.net/lammps-command-jump.html)
1. [next命令](http://www.52souji.net/lammps-command-next.html)

###### xilock的代码
```
variable i loop 10
label loopa
print "system_after_nvt_$i.data"
velocity Octane set 0 0 0.005
velocity Mont set 0 0 -0.005
run             50000
write_restart nvt.restart
write_data      system_after_nvt_$i.data
next i
jump SELF loopa
```


###### 参考：
1. [尝试lammps中, 分享中](http://muchong.com/html/201707/2660917.html)
1. [ERROR: Label wasn't found in input script](https://lammps.sandia.gov/threads/msg50240.html)

### if条件
###### 代码示例
```
if boolean then t1 t2 ... elif boolean f1 f2 ... elif boolean f1 f2 ... else e1 e2
    boolean : 布尔表达式
    then : 关键词
    t1 t2 : 被执行的命令块
    elif : 关键词
    else : 关键词
    f1 f2 : 被执行的命令块
```
###### 参考资料
1. [(七)脚本结构](https://zhuanlan.zhihu.com/p/44389156)

![](/img/wc-tail.GIF)
