---
layout:     post
title:      "lammps安装"
subtitle:   ""
date:       2020-08-25 07:39:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### 
###### 准备包  
1. fftw-3.3.8.tar.gz：http://www.fftw.org/download.html
1. lammps-stable.tar.gz(解压后为lammps-22Aug18)：https://lammps.sandia.gov/download.html
1. mpich-3.2.1.tar.gz：http://www.mpich.org/downloads/

1. 准备工作：在 ~/Desktop/ 下建立文件夹/lammps，将三个安装包分别解压这个文件夹中；
1. 创建fftw3和mpich3文件夹用来安装

###### fftw安装
lammps对fftw的默认调用路径为`/usr/local`(参见/lammps/lammps-22Aug18/src/MAKE/OPTIONS路径下的Makefile.fftw文件)，此处我们将其安装在`~/Desktop/lammps/fftw`：
```
cd ~/lammps_install/fftw-3.3.8 
sudo ./configure --prefix=~/Desktop/lammps/fftw --enbale-shared=yes 
sudo make
make install
```

Makefile.fftw的部分字段：  
```
FFT_INC =            -DFFT_FFTW3 -I/usr/local/include
FFT_PATH =      -L/usr/local/lib
FFT_LIB =        -lfftw3
```
###### mpich安装
lammps对fftw的默认调用路径为`/usr/local`(参见/lammps/lammps-22Aug18/src/MAKE/OPTIONS路径下的Makefile.g++_mpich_link文件)，此处我们将其安装在`~/Desktop/lammps/fftw`：


```
cd ~/lammps_install/mpich-3.2.1
sudo ./configure --prefix=~/Desktop/lammps/mpich
sudo make -j4  
sudo make install
```
（-j4 意为调用4核编译，具体核数看电脑情况）  

Makefile.g++_mpich_link的部分字段：  
```
MPI_INC = -DMPICH_SKIP_MPICXX -DOMPI_SKIP_MPICXX=1 -I/usr/local/include
MPI_PATH = -L/usr/local/lib
MPI_LIB = -lmpi -lmpl -lpthread
```
###### 修改fftw和mpich的路径 
除非安装时将fftw和mpich安装在lammps的默认路径`/usr/local/`，否则就需要在Makefile.fftw和Makefile.g++_mpich_link中对路径进行修改（见上）。

###### 并行版安装
打开Makefile.mpi文件，将下面这行注释掉。（由于lammps运行过程中不需要图片支持，因而将关于图片这几行斜线部分删除）
```
LMP_INC =	-DLAMMPS_GZIP -DLAMMPS_MEMALIGN=64
```

在lammps目录下：
```
mkdir build
cd build
cmake ../cmake/
make
cd ..
```

进入src：
```
cd src
make ps
make yes-all
make no-lib
sudo make mpi -j4
```
`make ps`是显示安装包的状态；`make yes-all`是安装所有包；`make-no-lib`是不安装有外链的包；

###### 测试
在lammps/example/文件夹里随便进入一个算例文件夹，`mpirun -np 4 lmp_mpi -in in.filename`

### 问题

###### Fatal error in PMPI_Init_thread: Other MPI error, error stack

```
Fatal error in PMPI_Init_thread: Other MPI error, error stack:
MPIR_Init_thread(467)..............: 
MPID_Init(177).....................: channel initialization failed
MPIDI_CH3_Init(70).................: 
MPID_nem_init(319).................: 
MPID_nem_tcp_init(171).............: 
MPID_nem_tcp_get_business_card(418): 
MPID_nem_tcp_init(377).............: gethostbyname failed, localhost (errno 3)
```

### 参考资料
1. [lammps安装全记录](http://bbs.keinsci.com/thread-14585-1-1.html)
1. [2018版lammps安装教程（小白专用）](https://zhuanlan.zhihu.com/p/36457551)
1. [ubuntu下lammps的安装](https://blog.csdn.net/xukang95/article/details/89377180)
1. [LAMMPS从研一到延毕：安装](https://zhuanlan.zhihu.com/p/70085195)
综合理解以上所有教程后，再进行安装！
1. [问题MPICH2 gethostbyname failed](https://stackoverflow.com/questions/23112515/mpich2-gethostbyname-failed)

![](/img/wc-tail.GIF)
