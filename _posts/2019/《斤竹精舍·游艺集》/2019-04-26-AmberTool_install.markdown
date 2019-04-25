---
layout:     post
title:      "AmberTool安装教程"
subtitle:   ""
date:       2019-04-26 20:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - 2019

---

[官网](http://ambermd.org/AmberTools15-get.html) 下载AmberTools14.tar.bz2后移动至/home/myname/install  

```
cd /home/myname/install  
tar xvfj AmberTools15.tar.bz2  
cd amber14
```

然后在.bashrc里加上  

```
export AMBERHOME=/home/myname/install/amber14
export PATH=$PATH:$AMBERHOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$AMBERHOME/lib
```

 `source ~/.bashrc` 使其生效

```
cd $AMBERHOME

./configure -gnu

make install

make test
```

可参考[Amber14安装方法](http://sobereva.com/263)

![](/img/wc-tail.GIF)
