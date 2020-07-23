---
layout:     post
title:      "gromacs并行计算"
subtitle:   ""
date:       2020-07-22 16:15:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2020

---

**!单机不要用并行版gmx**  
**!单机不要用并行版gmx**  
**!单机不要用并行版gmx**  

###### 硬件术语
1. socket: 等价于CPU芯片个数，独立的中央处理单元，体现在主板上是有多个CPU的槽位；
1. CPU cores: 物理上的概念，每个CPU上的核数，即**物理核**；
1. processor: 一种逻辑概念，这个主要得益于超线程技术，可以让一个物理核模拟出多个**逻辑核**，`lscpu`时显示的CPU(s)；

###### 并行术语
1. rank: 进程，等价于processes；
1. thread: 线程；

###### 说明
1. 进程是资源分配的基本单位；线程是程序执行的基本单位，一个进程可以包含若干个线程。。
1. rank和thread就像车间和工人的关系，一个rank可以包括多个thread。GMX在做muti-level并行时先在rank阶段用Domain Decompostion把体系切成小块，每块交给一个rank去算，而在这个rank中，多个thread共同处理这一个小块。  
1. 单节点的rank级别用`-ntmpi`控制，多节点的则用`-np`（在mpirun里）。
1. thread级别的用`-ntomp`控制。

###### gmx_mpi版安装使用说明
1. 安装基本与普通版相同，区别在于需要提前安装openmpi并在cmake那一步额外加上-DGMX_MPI=ON选项，具体见参考资料。
1. 跨节点运行时需要在每个节点上都安装上并行版gmx，且都有执行文件，xilock写了段代码来实现这个过程。
1. 使用时将该脚本与tpr置于同一文件夹下，再准备两个文件:machinefile.LINUX和nodes.par，两个文件里的内容一样，均为每行一个node名，例如第1行为node6，第二行为node7等等。
1. 输入`./gmxmpi_xilock nprocs npt.tpr`即可，nprocs为调用rank数，经测试对于4 socket - 8 cores/socket - 2 thread/cores的AMD Opteron(tm) Processor 6376而言，1 OpenMP thread/ MPI process有较好性能，即让nprocs(rank)等于逻辑核数。

gmxmpi_xilock
```
#!/bin/csh -f
### script to run gmx_mpi
 set TMPDIR = ~/tmp_gmxmpi$$_`whoami`
# set TMPDIR = ~/tmp_mpi
 set here = $PWD
 set MPIBIN = /public/software/mpi/openmpi/1.6.5/intel/bin/mpirun
 set NPROCS = $1
 set FILENAME = $2
#
 foreach n (`cat $here/nodes.par`)
  ssh -n $n "mkdir -p $TMPDIR"
 end
#
 foreach n (`cat $here/nodes.par`)
  scp -q $here/"$2.tpr" ${n}:$TMPDIR/.
 end
#
# mpirun + gmx_mpi
 $MPIBIN -machinefile machinefile.LINUX -np $NPROCS gmx_mpi mdrun -v -deffnm $TMPDIR/$2 
#
# copy and clear
 mkdir $here/output/
 cp $TMPDIR/* $here/mpi_output/
 foreach n (`cat $here/nodes.par`)
  ssh -n $n "rm -R -f $TMPDIR"
 end
 exit
```

**若要指定每个节点可用的processes，在machinefile.LINUX中的节点名之后用`slots`指定**

machinefile.LINUX (用于mpirun命令，调用node5和node6且分别指定可调用7和3个processes)
```
node5 slots=7
node6 slots=3
```

nodes.par （用于runmpi14脚本）
```
node5
node6
```

参考资料：
1. [GROMACS (2019.3 GPU版) 并行效率测试及调试思路](http://bbs.keinsci.com/thread-13861-1-1.html)
1. [Getting good performance from mdrun](http://manual.gromacs.org/documentation/current/user-guide/mdrun-performance.html)
1. [GROMACS的安装方法](http://sobereva.com/457)
1. [Specifying Number of Processes](https://www.open-mpi.org/doc/v4.0/man1/mpirun.1.php#toc7)  
相关下载：
1. [gmxmpi_xilock](http://molakirlee.github.io/attachment/gmx/gmxmpi_xilock.txt)

![](/img/wc-tail.GIF)
