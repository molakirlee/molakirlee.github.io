---
layout:     post
title:      "gmx gromacs并行计算 MPI&OpenMP"
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

单节点运行时，thread-mpi并行比mpirun并行稍快，虽然两者同为rank级别，故：  
**!单机不要用并行版gmx**  
**!单机不要用并行版gmx**  
**!单机不要用并行版gmx**  

###  硬件术语
1. socket: 等价于CPU芯片个数，独立的中央处理单元，体现在主板上是有多个CPU的槽位；
1. CPU cores: 物理上的概念，每个CPU上的核数，即**物理核**；
1. processor: 一种逻辑概念，这个主要得益于超线程技术，可以让一个物理核模拟出多个**逻辑核**，`lscpu`时显示的CPU(s)；

###  并行术语
1. rank: 进程，等价于processes；
1. thread: 线程；
1. OpenMP和MPI:天河二号系统支持OpenMP和MPI两种并行编程模式。其中OpenMP为共享内存方式，仅能在一个计算结点内并行，最大线程数不能超过结点处理器核心数；MPI是分布式内存并行，计算作业可以在一个或者若干个结点上进行，最大进程数仅受用户帐号所能调用的CPU总数限制。

###  说明
1. 进程是资源分配的基本单位；线程是程序执行的基本单位，一个进程可以包含若干个线程。。
1. rank和thread就像车间和工人的关系，一个rank可以包括多个thread。GMX在做muti-level并行时先在rank阶段用Domain Decompostion把体系切成小块，每块交给一个rank去算，而在这个rank中，多个thread共同处理这一个小块。  
1. 单节点的rank级别用`-ntmpi`控制，多节点的则用`-np`（在mpirun里）。
1. thread级别的用`-ntomp`控制。

###  gmx_mpi版安装使用说明
###### 安装使用说明
1. 安装基本与普通版相同，区别在于需要提前安装openmpi并在cmake那一步额外加上-DGMX_MPI=ON选项，具体见参考资料。
1. 跨节点运行时需要在每个节点上都安装上并行版gmx，且都有执行文件，xilock写了段代码来实现这个过程。
1. 使用时将该脚本与tpr置于同一文件夹下，再准备两个文件:machinefile.LINUX和nodes.par，两个文件里的内容一样，均为每行一个node名，例如第1行为node6，第二行为node7等等。
1. 输入`./gmxmpi_xilock nprocs npt.tpr`即可，nprocs为调用rank数，经测试对于4 socket - 8 cores/socket - 2 thread/cores的AMD Opteron(tm) Processor 6376而言，1 OpenMP thread/ MPI process有较好性能，即让nprocs(rank)等于逻辑核数。

### xilock自制mpi用脚本
gmxmpi_xilock.bsh（使用方法：`./gmxmpi_xilock.bsh 核数 任务名`，如`./gmxmpi_xilock.bsh 128 npt`）
```
#!/bin/csh -f
### script to run gmx_mpi
 set TNAME = $$_`whoami`
 set TMPDIR = ~/tmp_mpi$$_`whoami`
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
 mkdir $here/${FILENAME}_{$$_`whoami`}/
 cp $TMPDIR/* $here/${FILENAME}_{$$_`whoami`}/
 foreach n (`cat $here/nodes.par`)
  ssh -n $n "rm -R -f $TMPDIR"
 end
 exit
```

希望让多个mdrun串行调用mpirun跑的话用下面的脚本来调用gmxmpi_xilock.bsh
ParaRun.bsh
```
#!/bin/bash

#sleep 2.5h
OriDir=$(pwd)
#
# 1st Process: in the dir you want make nvt_pre.tpr
gmx_mpi grompp -f mdp/nvt_pre.mdp -c em_ions3.gro -p topol.top -o nvt_pre
gmx_mpi mdrun -v -deffnm nvt_pre
./gmxmpi_xilock.bsh 128 nvt_pre
#
# 2nd Process: make and run nvt
cd nvt_pre*
DirNamNow=$(basename `pwd`)
#echo "OriDir is $OriDir"
gmx_mpi grompp -f $OriDir/mdp/nvt_0-60ns.mdp -c nvt_pre.gro -p $OriDir/topol.top -o nvt_60ns.tpr
# copy related files
cp $OriDir/gmxmpi_xilock.bsh ./
cp $OriDir/nodes.par ./
cp $OriDir/machinefile.LINUX ./
# run
./gmxmpi_xilock.bsh 128 nvt_60ns
#
# Analysis
cd nvt_60ns*
gmx_mpi trjconv -s nvt_60ns.tpr -f nvt_60ns.xtc -pbc nojump -o nvt_60ns_nojump.xtc
gmx_mpi rms -s nvt_60ns.tpr -f nvt_60ns_nojump.xtc

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


### 域分解 
要确定区域分解和节点划分的最佳设置, 可利用如下步骤:  
1. 根据测试运行结果确定区域分解的最小单元尺寸(Minimum cell size due to bonded interactions): d;
1. 根据盒子x和y方向的尺寸 a 和 b 确定x和y方向的最大可能划分单元数: Nx=a/d, Ny=b/d，如最小单元尺寸为0.65nm时(Minimum cell size due to bonded interactions: 0.650 nm)，可将一个x×y为5.9×5.9nm的z向板块盒子划分为9×9×1;
1. 对板块构型, 一般不沿z方向划分盒子, 所以体系的最大可能划分单元数为: Nx×Ny×1，其他的可划分为Nx×Ny×Nz，实际上即便是板块结构z方向也可做划分，xilock发现有时在默认条件下会进行划分;
1. 使用-dd选项设定区域分解时, 每一方向的划分单元数不可超过前面得到的最大可能划分单元数, 否则出错
1. 使用-npme选项设定PME节点数时, 其值必须小于总节点数的一般. 具体多少可根据测试结果确定, 一般可取1/3或1/4
1. GROMACS自动设置区域分解时, 对于某些节点数可能出错. 此时可使用-dd手动设定区域分解.

##### `-np`, `-ntmpi`,`-ntomp`分配
###### 例子
1. 单节点情况下：`gmx mdrun -ntmpi 4 -ntomp 6` （4个MPI rank, 每个rank 使用6个线程，运行时占用24个核）
1. 跨节点运行时：`mpirun -np 2 gmx_mpi mdrun -ntomp 6`（2个MPI rank, 每个rank 使用6个线程，运行时占用12个核）

###### 单节点
对于单节点的`-ntmpi`和`-ntomp`分配，gromacs一般建议让`-ntopm`在1-6之间，即每个rank分配1-6个OpenMP：
```
Your choice of number of MPI ranks and amount of resources results in using 10 OpenMP threads per rank, which is most likely inefficient. The optimum is usually between 1 and 6 threads per rank. If you want to run with this setup, specify the -ntomp option. But we suggest to change the number of MPI ranks (option -ntmpi).
```
但玺洛克发现，对于不同机子，情况不一样：
1. 无论哪种情况，**尽可能让`-ntmpi`和`-ntomp`乘积恰为总线程数时效率最高（即利用全部线程）！**
1. 有时候`-ntomp 1`时好，如对于"4 socket - 8 cores/socket - 2 thread/cores的AMD Opteron(tm) Processor 6376"，见[《GROMACS 软件并行计算性能分析》](http://www.c-s-a.org.cn/csa/ch/reader/create_pdf.aspx?file_no=20161203&flag=1&year_id=2016&quarter_id=12)；
1. 有时候`-ntomp`在1-6之间且接近6时效率最高，如对于"Intel(R) Xeon(R) CPU E5-2692 v2 @ 2.20GHz,Cores per node:24,Logical cores per node:24"的话`-ntmpi 6 -pin on`（测试体系较小，<3 3 15>的盒子）；
1. 有时候`-ntomp`大于6好？？如对于"Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz,Cores per node:24,Logical cores per node:24"的话如果调用双节点默认参数为`-ntmpi 4 -ntomp 12`（未优化！可能并不是最好的，从后面来看`-ntomp`似乎还是应该在1-6之间？）；
1. **可能跟具体任务有关，提交前对几种`-ntmpi`和`-ntomp`乘积恰为总线程数时的情况分别测试！！**

###### 跨节点
**对跨节点而言，`-npme`尤为重要！**  

On 4 nodes, each with 16 cores, you might try：
```
mpirun -np 64 gmx_mpi mdrun -ntomp 1 -npme 16
mpirun -np 32 gmx_mpi mdrun -ntomp 2 -npme 8
mpirun -np 16 gmx_mpi mdrun -ntomp 4 -npme 4
```

**优先选用`-ntomp 1`的？**  


### 参考资料：  
1. [GROMACS (2019.3 GPU版) 并行效率测试及调试思路](http://bbs.keinsci.com/thread-13861-1-1.html)
1. [Getting good performance from mdrun](http://manual.gromacs.org/documentation/current/user-guide/mdrun-performance.html)
1. [GROMACS的安装方法](http://sobereva.com/457)
1. [Specifying Number of Processes](https://www.open-mpi.org/doc/v4.0/man1/mpirun.1.php#toc7)  
1. [GROMACS教程：GROMACS模拟空间非均相体系(板块结构)的并行性能：区域分解与PME节点设置](https://jerkwin.github.io/GMX/GMXtut-10/)
1. [2016-05-11-Performance-Tuning-and-Optimization-of-GROMACS.pdf](https://bioexcel.eu/wp-content/uploads/2016/05/2016-05-11-Performance-Tuning-and-Optimization-of-GROMACS.pdf)


### 相关下载：  
1. [gmxmpi_xilock.bsh](https://github.com/molakirlee/Blog_Attachment_A/blob/main/gmx/gmxmpi_xilock.bsh)


![](/img/wc-tail.GIF)
