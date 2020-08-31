---
layout:     post
title:      "天河二号使用"
subtitle:   ""
date:       2020-08-31 15:27:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Linux
    - 2020

---
 
### 常用指令
1. 提交命令：`yhbatch`，具体使用方法参见slurm文件； 
1. 已用机时：`time`；
1. 查看正在运行的序列：`yhq`；
1. 作业用量查询：`yhreport  Cluster AccountUtilizationByUser start=1/1/15 end=now -t hour user=用户账号`；


### slurm示例
1. [job_gmx2019.slurm](https://molakirlee.github.io/attachment/linux/job_gmx2019.slurm)
1. [job_vasp.slurm](https://molakirlee.github.io/attachment/linux/job_vasp.slurm)




![](/img/wc-tail.GIF)
