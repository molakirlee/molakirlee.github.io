---
layout:     post
title:      "AmberTool安装及使用教程"
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

### 安装

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

编译大概需要20min，测试大概需要2h。

将acpype.py放到AmberTool的bin文件夹里。

可参考[Amber14安装方法](http://sobereva.com/263)

### 使用

gview画出的mol2文件可以直接用AmberTool处理，命令如下：

```
acpype.py -i xxx.mol2 <-n -1> <-d>
```

 `-n` 用于调整电荷量， `-d` 则可以显示处理细节。


![](/img/wc-tail.GIF)
