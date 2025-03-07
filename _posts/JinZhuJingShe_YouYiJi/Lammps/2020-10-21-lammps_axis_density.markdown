---
layout:     post
title:      "LAMMPS 密度分析"
subtitle:   ""
date:       2020-10-21 09:06:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### `fix ave/spatial`

fix ave/spatial 命令将模拟盒子在某一方向分层,求出每层的 density/number,然后作出曲线就行了:

```
group argon type 2
fix 101 argon ave/spatial 1 197000 200000 x lower 0.004 density/mass file density.profile units reduced
```


```
fix 1 all ave/spatial 10000 1 10000 z lower 0.02 c_myCentro units reduced
fix 1 flow ave/spatial 100 10 1000 y 0.0 1.0 vx vz norm sample file vel.profile
fix 1 flow ave/spatial 100 5 1000 y 0.0 2.5 density/mass ave running
```

```
Compute 1 Al chunk/atom bin/cylinder z lower 2 10 10 2 5 3 discard yes
fix 7 Al ave/chunk 100 2 200 1density/mass norm sample file alldensity.profile
```


### 参考资料
1. [Re: [lammps-users] density profile](https://lammps.sandia.gov/threads/msg13153.html)
1. [密度分布曲线Density profile](http://muchong.com/t-6739585-1)
1. [fix ave/chunk command](https://lammps.sandia.gov/doc/fix_ave_chunk.html)
1. [LAMMPS中fix ave spatial空间平均命令中文版](http://bbs.keinsci.com/thread-1735-1-1.html)
1. [润湿过程二维密度分布云图的数据获取](https://zhuanlan.zhihu.com/p/139014508)

![](/img/wc-tail.GIF)
