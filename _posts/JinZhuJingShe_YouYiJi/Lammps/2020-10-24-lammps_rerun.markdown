---
layout:     post
title:      "LAMMPS 重跑rerun"
subtitle:   ""
date:       2020-10-24 20:06:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### `rerun`
###### 代码示例
因为lammps的rerun不支持xyz格式的轨迹（步数读取有问题），所以可dump出lammpstrj格式，然后把原IN文件中dump部分和run这两部分注释掉后，加一个rerun之前生成的lammpstrj文件的命令即可，像下面的示例代码：
```
#dump myDump all custom ${Num_dump} ${O_Dir}/${OF_basename}.lammpstrj id mol element xu yu zu
#dump_modify myDump element C C C O O C N C C O N O H H H
#dump_modify myDump sort id

#run ${Num_step}
rerun ${O_Dir}/${OF_basename}.lammpstrj dump x y z
```

###### 参考资料
1. [rerun command](https://lammps.sandia.gov/doc/rerun.html)

![](/img/wc-tail.GIF)
