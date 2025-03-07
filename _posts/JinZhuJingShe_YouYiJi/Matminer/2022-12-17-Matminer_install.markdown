---
layout:     post
title:      "Matminer 安装"
subtitle:   ""
date:       2022-12-17 19:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - 2022

---

### 安装
以天河2号上安装为例：
```
(base) [test@ln0%tianhe2 ~]$ conda create -n py36 python=3.6
# 安装好环境后，激活该环境，并安装pymatgen 和 matminer
(base) [test@ln0%tianhe2 ~]$ conda activate py36
(py36) [test@ln0%tianhe2 ~]$ conda install -c conda-forge pymatgen
(py36) [test@ln0%tianhe2 ~]$ pip install matminer
```

测试：
```
(py36) [test@ln0%tianhe2 ~]$ python
Python 3.6.12 |Anaconda, Inc.| (default, Sep  8 2020, 23:10:56) 
[GCC 7.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import pymatgen
>>> import matminer
```
参考资料：[超好用的材料类机器学习开源软件-Matminer](https://www.bigbrosci.com/2020/12/16/A25/)

![](/img/wc-tail.GIF)
