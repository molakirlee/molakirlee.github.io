---
layout:     post
title:      "LAMMPS安装"
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

###### gcc
如果没有gcc和gfortran的话安装一下 
```
yum install gcc-c++ 
yum install gcc-gfortran 
```

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

**附：**Makefile.fftw的部分字段：  
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

编译完将mpich的路径添加到.bashrc里，如下：
```
# mpicxx
export PATH=/root/Desktop/lammps_install/mpich-3.4a2_installed/bin:$PATH
```


**附：**Makefile.g++_mpich_link的部分字段：  
```
MPI_INC = -DMPICH_SKIP_MPICXX -DOMPI_SKIP_MPICXX=1 -I/usr/local/include
MPI_PATH = -L/usr/local/lib
MPI_LIB = -lmpi -lmpl -lpthread
```
###### 修改fftw和mpich的路径 
除非安装时将fftw和mpich安装在lammps的默认路径`/usr/local/`，否则就需要修改fftw和mpich的路径，有两种方式，择一即可（**别全改了，如果同一项在多处修改，则可能报错；**如在几个文件里都修改fftw路径，则`make mpi`那步可能报错`cannot find -lfftw3`）：  
1. 在/lammps/lammps-22Aug18/src/Make/路径下的Makefile.mpi里修改fftw和mpich的路径，内容见上。
1. 在/lammps/lammps-22Aug18/src/Make/OPTIONS路径下的Makefile.fftw和Makefile.g++_mpich_link中对路径进行修改。

###### 并行版安装

```
tar xvf lammps-stable.tar.gz
```

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

如果显示如下则证明安装成功，如果报错了，请仔细检查上面的步骤，如果有必要，请在/lammps/lammps-22Aug18/src中执行`make clean-all`（或`make clean-openmpi`？），清理一下，然后再来一次。
```
text data bss dec hex filename
30886917 55160 1612612576 1643554653 61f6a75d ../lmp_omp
make[1]: Leaving directory ‘/home/chenhuaqiang/lammps-16Mar18/src/Obj_mpi’
```

添加lammps的路径：  

```
# LAMMPS
export PATH=/root/Desktop/lammps_install/lammps-3Mar20/src/:$PATH
export LD_LIBRARY_PATH=/root/Desktop/lammps_install/lammps-3Mar20/src:$LD_LIBRARY_PATH
```

***建议新建一个环境文件lammps，将mpich和lammps的环境和路径都放进去，每次使用前source，不用就不souce，以免mpirun混乱；当然，使用module来管理的话会更好**。  


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

解决见参考资料：问题MPICH2 gethostbyname failed

###### `make mpi`过程中遇到问题

出现一大堆错误如：
```
angle_charmm_omp.cpp(90): error: "restrict" has already been declared in the current scope
```

可能是因为没有将mpich添加到路径里，添加完后`make clean-all`清理一下，然后重新`make mpi -j4`试试。

###### `mpirun -np 10 LAMMPS < in.shear`报错
如果在用mpirun调用过程中使用了alias的指令就会报下面的错误，故在使用mpirun的过程中一定要使用原来的名字`mpirun -np 10 lmp_mpi < in.shear`而非alias之后的名字（如将lmp_mpi用alias定为LAMMPS）。
```
[proxy:0:0@node5] HYDU_sock_write (utils/sock/sock.c:256): write error (Broken pipe)
[proxy:0:0@node5] HYD_pmcd_pmip_control_cmd_cb (pm/pmiserv/pmip_cb.c:937): unable to write to downstream stdin
[proxy:0:0@node5] HYDT_dmxu_poll_wait_for_event (tools/demux/demux_poll.c:77): callback returned error status
[proxy:0:0@node5] main (pm/pmiserv/pmip.c:178): demux engine error waiting for event
[mpiexec@node5] control_cb (pm/pmiserv/pmiserv_cb.c:207): assert (!closed) failed
[mpiexec@node5] HYDT_dmxu_poll_wait_for_event (tools/demux/demux_poll.c:77): callback returned error status
[mpiexec@node5] HYD_pmci_wait_for_completion (pm/pmiserv/pmiserv_pmci.c:195): error waiting for event
[mpiexec@node5] main (ui/mpich/mpiexec.c:336): process manager error waiting for completion
```

### 参考资料
###### 安装(综合理解所有教程后，再进行安装！)
1. [lammps安装全记录](http://bbs.keinsci.com/thread-14585-1-1.html)
1. [2018版lammps安装教程（小白专用）](https://zhuanlan.zhihu.com/p/36457551)
1. [ubuntu下lammps的安装](https://blog.csdn.net/xukang95/article/details/89377180)
1. [LAMMPS从研一到延毕：安装](https://zhuanlan.zhihu.com/p/70085195)

###### 问题部分
1. [问题MPICH2 gethostbyname failed](https://stackoverflow.com/questions/23112515/mpich2-gethostbyname-failed)

### 教程
1. [lammps实例](https://www.docin.com/p-1073593520.html)

![](/img/wc-tail.GIF)
