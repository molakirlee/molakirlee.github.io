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

### Win版
###### CPU版
1. 打开[官网链接](https://rpm.lammps.org/windows/)，根据自己的需求选择相应的可执行文件，比如，是否支持 MPI 并行、是否需要调用 Python 等。这里选择 LAMMPS-64bit-Python-2Aug2023-MSMPI.exe 并行版以满足上述两种需求 (因为文件名字中含 Python 和 MSMPI) 。另外，还需要安装 msmpisetup.exe 来支持 MPI 并行 ([下载链接](https://www.microsoft.com/en-us/download/details.aspx?id=100593))。需要注意的是，在同一台电脑上已经不允许安装不同版本的 LAMMPS，安装时建议安装最新版。
1. 首先双击下载好的 msmpisetup.exe，正常安装即可.
1. 安装完成以后，就可以使用 LAMMPS 了。LAMMPS 软件需要在控制台程序中执行，比如 cmd 和 Windows Powershell。打开控制台程序以后，可切换至 in 文件所在的目录，通命令运行 LAMMPS.
1. 串行方式: `lmp -in **.lammps` (其中 **.lammps 表示 in 文件)
1. 多线程并行方式: `lmp -pk omp 4 -sf omp -in **.lammps` (其中**.lammps 表示 in 文件)
1. MPI 并行方式 (注意必须下载支持 MPI 的可执行文件): `mpiexec -np # lmp -in **.lammps` (其中 # 表示核数，**.lammps 表示 in 文件)
1. 其它注意事项见官方链接[LAMMPS Windows Installer Repository](https://packages.lammps.org/windows.html)

参考资料：[LAMMPS 软件的安装与运行](https://zhuanlan.zhihu.com/p/657435571)

###### GPU版本
1. 按照CPU版本安装
1. 安装GPU驱动和CUDA，具体过程见参考资料，完成后`nvidia-smi`检查是否安装成功
1. 可用以下指令运行：`mpiexec -n 1 lmp -in in.filename -sf gpu -pk gpu 1 platform 1`，其中`platform n（0或1）`是用于有核显的情况下指定使用哪个显卡加速


参考资料:
1. [Lammps安装，GPU加速，Python调用Lammps](https://www.bilibili.com/opus/937373043267731478)
1. [Windows环境下LAMMPS使用GPU加速运算](https://zhuanlan.zhihu.com/p/139922210)
1. [笔记：Lammps windows安装以及GPU加速](https://blog.csdn.net/FXJgogogo/article/details/148238219)


### Win-WSL2版
1. [《记一次Lammps上GPU加速的折腾，和CPU核数越多越慢的奇特表现》](http://bbs.keinsci.com/thread-18771-1-1.html)一文有以下结论：1） WSL2已经非常好用。笔记本没必要刷Linux桌面了。2） LAMMPS就是单进程搭单卡，计算90%扔GPU上的架构。（具体来讲和对势、键势、接邻列表算法等有关）。
1. [《Gaussian 16在虚拟机和WSL中的相对效率 - 计算化学公社》](http://bbs.keinsci.com/thread-16405-1-1.html)提到"WSL效率确实不错，(相比ubuntu)只损失了10%多点的性能"


###### WLS2安装
1. 在Windows搜索栏中搜索控制面板，程序→启用或关闭Windows功能→勾选"开启Hyper-v"、"虚拟机平台"、"适用于Linux的Windows子系统"这3项（Hyper-v是用来提高性能的，家庭版window可能没这个选项，可参考[《Windows11家庭版上安装Hyper-V并导入虚拟机的方法》](https://blog.csdn.net/breaksoftware/article/details/135754808)）
1. 在微软应用商店中搜索Ubuntu，选择需要安装的发行版本（以Ubuntu 22.04.2为例），下载完成后即可在开始菜单中找到，点击运行，开始安装。随后根据提示设置用户名和密码。
1. 在PowerShell（在Win搜索栏中搜索打开）中输入wsl -l -v 即可查看WSL的运行状态和版本，如果version是2则说明是WLS2，否则就是WLS，参照资料进一步改为WLS2。
1. 亲测win 12np时44min/；win 6/12np+1gpu时21-22min(1个GPU时，6/12个CPU线程影响不大)； WSL2 1gpu时21min/ WSL2 6/12np+1gpu时10min，2np+1gpu时14min，*4np+1gpu时8min*。可见GPU加速时并非线程越多越好

###### CUDA及CUDA-toolkit安装
1. NV官网给出了WSL 2的CUDA安装方式，根据网页下方的安装指引即可，`nvidia-smi`可看到显卡等信息，确定安装完成
1. `sudo apt-get -y install nvidia-cuda-toolkit`,安装完成后`nvcc --version`有对应信息确定安装成功。


###### 环境安装
```
sudo apt install build-essential #报404错误就换源，具体操作自行必应搜索
apt install cmake
apt install gfortran
apt update
apt upgrade
```

换源步骤：
1. 步骤1：备份原始源文件。在更改之前，建议备份系统默认的 sources.list 文件：`sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup`
1. 步骤2：编辑源文件,使用文本编辑器打开 sources.list 文件：`sudo vim /etc/apt/sources.list`或者：`sudo gedit /etc/apt/sources.list`清空文件内容或注释掉原有的源地址，然后根据你的 Ubuntu 版本添加以下内容：

```
# 阿里云镜像
deb https://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb https://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb https://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb https://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse

# 清华大学镜像
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
```

1. 步骤3：更新软件源.保存并关闭文件后，运行以下命令更新软件包列表：`sudo apt update`和`sudo apt upgrade`


###### MPI安装
1. ……
1. ……
1. 用`which mpirun`查看安装位置，`mpirun --version`查看版本，确认安装成功

###### LAMMPS安装
1. 下载LAMMPS最新稳定版的源码压缩包:`wget https://download.lammps.org/tars/lammps-stable.tar.gz`
1. 解压缩`tar -xzvf lammps-stable.tar.gz`
1. `cd lammps-2Aug2023/ #不同版本的发布时间不同，当前最新稳定版为2023年8月2日发布的版本`
1. `mkdir build`
1. `cd build`
1. `cmake -C ../cmake/presets/basic.cmake -D PKG_OPENMP=yes -D PKG_GPU=on -D GPU_API=cuda -D GPU_ARCH=sm_86 -D FFT_SINGLE=yes ../cmake`，其中GPU_ARCH为GPU架构型号，可通过`nvidia-smi -q | grep Architecture`，显示`Architecture: 75`,或显示Ampere然后查询对应数字是80/86；`/basic.cmake` 中有如MOLECULE , MANYBODY等包，但`CLASS2` `REACTION`等需要额外添加（以后用的时候发现缺啥了就回来加上以后重新cmake；`-DFFT_SINGLE=yes`是指定单精度版，因为手册的[Optional build settings](https://docs.lammps.org/Build_settings.html)中说Performing 3d FFTs in parallel can be time-consuming due to data access and required communication.This cost can be reduced by performing single-precision FFTs instead of double precision.而且Note that Fourier transform and related PPPM operations are somewhat less sensitive to floating point truncation errors, and thus the resulting error is generally less than the difference in precision.**所以多核运行时可以优先考虑单精度，单核时可以考虑双精度**）。
1. `make -j 4`，如果不添加数字则默认最大，会因为内存不够而失败
1. `make install`
1. `vim .bashrc`并添加 `export PATH=/home/skywalker/lammps-2Aug2023/build:$PATH`后`source .bashrc`


1. ReaxFF的GPU加速需要使用kokkos包，安装可参考[WSL2下Kokkos版加速的Lammps的cmake编译](http://bbs.keinsci.com/thread-36559-1-1.html)和[在linux mint21.3上安装含kokkos以及deepmd的lammps & 4090的reaxff测试](http://bbs.keinsci.com/thread-46630-1-1.html)
1. Kokkos(22Jul2025只支持双精度,Currently, there are no precision options with the KOKKOS package. All compilation and computation is performed in double precision)对GPU和多核CPU加速较好，但有3中情况不使用：1）小规模体系（万原子以下），因为启动 Kokkos 的开销可能抵消加速收益。2）不支持某些复杂的多体势或特定 fix/compute（具体参见[官方文档](https://docs.lammps.org/Speed_kokkos.html)）。3）硬件仅限单核 CPU 或没有 GPU。


有些情况下报错让指定cuda的bin2c位置(如Could not find bin2c, use -DBIN2C=/path/to/bin2c to help cmake finding it)和mpicxx的位置(如 Imported target "MPI::MPI_CXX" includes non-existent path)，可参照下面指令（**注意:1）"\"后不能有任何字符；2）往命令行中复制时不能超过30行**）
```
cmake -C ../cmake/presets/basic.cmake \
      -D PKG_OPENMP=yes \
      -D PKG_GPU=on \
      -D GPU_API=cuda \
      -D GPU_ARCH=sm_86 \
      -D FFT_SINGLE=yes \
      -D BIN2C=/usr/local/cuda-12.3/bin/bin2c \
      -D MPI_CXX_COMPILER=/home/xilock/Desktop/mpich412/bin/mpicxx \
      -D MPI_C_COMPILER=/home/xilock/Desktop/mpich412/bin/mpicc \
      -D MPI_HOME=/home/xilock/Desktop/mpich412 \
      ../cmake
```



GPU双精度版的cmake:
```
cmake -C ../cmake/presets/basic.cmake \
      -D PKG_OPENMP=yes \
      -D PKG_GPU=on \
      -D GPU_API=cuda \
      -D GPU_ARCH=sm_86 \
      -D GPU_PREC=double \
      -D BIN2C=/usr/local/cuda-12.3/bin/bin2c \
      -D MPI_CXX_COMPILER=/home/xilock/Desktop/mpich412/bin/mpicxx \
      -D MPI_C_COMPILER=/home/xilock/Desktop/mpich412/bin/mpicc \
      -D MPI_HOME=/home/xilock/Desktop/mpich412 \
      ../cmake
```


###### 关于Kokkos
1. **结论：使用双精度不好的游戏卡时，如果不是reaxff这样必须用kokkos加速的情况，优先用混合精度的GPU包；必须用kokkos包时，3万原子以下考虑用KISS FFT将PPPM放在CPU上计算，大体系用默认的cuFFT将PPPM放在GPU上计算。**
1. kokkos包使用时，`newton on`会将时间从modify的耗时转到comm(对称力只计算1次，而由内部同步处理),且降低了Neigh，且总耗时会降低，因此**推荐指令为`lmp -k on g 1 -sf kk -pk kokkos cuda/aware on neigh half comm device binsize 2.8 newton on -var x 8 -var y 4 -var z 8 -in in.* > run.log 2>&1`**。

1. 原则上来说，在同为双精度情况下，kokkos包比GPU包要更快([doc-7.4.3. KOKKOS package](https://docs.lammps.org/Speed_kokkos.html)原文为:When running large number of atoms per GPU, KOKKOS is typically faster than the GPU package when compiled for double precision. The benefit of using single or mixed precision with the GPU package depends significantly on the hardware in use and the simulated system and pair style.)但是，kokkos目前仅支持双精度计算，然而RTX系列（rtx30、rtx40系列）双精度计算能力非常弱，因此使用这些卡，支持混合精度的GPU包加速效果将要明显优于kokkos包，参见[lammps gpu版编译（kokkos+cuda）](https://zhuanlan.zhihu.com/p/603892794).（Entropy.S.I测试过RT4090，lammps的GPU加速功能对GPU的双精度浮点性能需求高，较不适合用来测试双精度浮点性能孱弱的游戏GPU。但RTX 4090的双精度浮点性能已超过1 TFLOPS（3090只有0.56），有一定测试价值；对于LAMMPS，LJ 2.5和EAM两个任务中RTX 4090性能较RTC 3090Ti实现“翻倍”，Tersoff任务离“翻倍”还有较大距离。而对比NVIDIA公布的测试结果，RTX 4090运行LAMMPS的性能（具体数据见SI）仍明显不如A100，甚至不如V100，这显然是因为RTX 4090无FP64执行单元，双精度浮点性能太弱，参见[《性能翻倍？RTX4090科学计算之经典MD模拟全面测试》](http://bbs.keinsci.com/thread-33296-1-1.html)。）
1. 因为游戏卡对双精度计算支持不好，在12th Gen Intel(R)Core(TM)i9-12900H / NVIDIA GeForce RTX 3060 Laptop GPU上，xikock实测了对于[nvidia测试包](https://github.com/molakirlee/Blog_Attachment_A/blob/main/lammps/LAMMPS_benchmark_GPU)中的EAM实例而言(其它硬件参见[主流分子动力学程序在AMD、NVIDIA和Intel的消费级GPU上的性能基准测试](http://bbs.keinsci.com/thread-39266-1-1.html))，同为双精度GPU计算时，用gpu包耗时2:33，用kokkos耗时1:51；相较之下混合精度GPU包耗时只有0:56，所以，**对于双精度性能不足的条件下，能用GPU包尽可能用GPU包**。（LJ-2.5测试包: kokkos 02:36，双精度GPU包 05:35，混合精度GPU包02:36）。虽然kokkos基本可以视为仅支持双精度，游戏卡跑不了，但动力学里应该只有reax不支持单精度GPU，参见[《WSL2下Kokkos版加速的Lammps的cmake编译》](http://bbs.keinsci.com/thread-36559-1-1.html)
1. kokkos加速适合EAM、reaxff、Tersoff、LJ的普通力场，但在处理pppm时，1)对于小体系，同为双精度且均在CPU上计算PPPM时，GPU包效率高于kokkos包，这是因为kokkos包依赖通用Kokkos抽象层，无法针对PPPM进行深度硬件优化，增加抽象层开销，降低实际计算效率（GPU包使用专用GPU内核优化PPPM计算，对于电荷映射Kernel rho和力插值Force interp进行了深度优化，只有纯FFT部分在CPU上；kokkos包全在cpu上且未优化）；2）关于PPPM放在GPU用cuFFT计算还是放在CPU用KISS FFT计算，小体系无法充分利用GPU的大规模并行能力，GPU加速在小规模FFT上的启动和数据传输开销可能超过计算收益，所以**小体系PPPM适合在CPU上计算而非在GPU上计算**。具体而言，如果体系太小(如原子数小于几万)，kokkos处理class2的pppm加速效果极差(如对3400原子体系，grid 10x10x10，甚至不如双精度GPU包，双精度GPU包03:34(8threads 03:14)，kokkos包05:46(8 thread 05:37；PPPM强制用KISS FFT放到CPU上时03:47)；当原子数达到27000，grid 20x20x20时kokkos效率反超双精度GPU包且cuFFT最好，cuFFT 4:16,KISS FFT kokkos 4:40,双精度GPU包4:17)，因此：**能用混合精度GPU包则混合精度GPU优先，reaxff等必须用kokkos再考虑用kokkos，如果显卡双精度计算可以(rtx 30xx 40xx等游戏显卡就算了)可以考虑测试下kokkos（因为kokkos到2024Aug版仍只支持双精度不支持混合精度）**。



1. 对Kokkos包和GPU包而言，Task timing breakdown(或loop time)都只记录某个CPU task在wall-clock上消耗了多少时间，而不直接测GPU内核的时间，所以两者的 task breakdown 在“口径”上是可比的。GPU包还会额外输出细粒度拆分的Device Info。
1. 以EAM case为例，从耗时分布上看，kokkos包的neigh和commm耗时高， 但这只是表象，两者归类方式不同，见下表：

| **模块**        | **Kokkos (s)** | **GPU (s)** | **Kokkos 细分说明**                                             | **GPU 细分说明**                                                                                                              |
| ------------- | -------------- | ----------- | ----------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Pair              | 23.988         | 126.38              | GPU内核力计算（pair styles的compute内核，主要是force evaluation）  | 包含 GPU Force calc (98.07) + Neighbor build (15.99) + Data Transfer (8.83) + Neighbor copy (0.11) + Device Overhead (0.03) + 主机同步 (\~3.35) |
| Neigh             | 36.606         | 0.744               | 邻居列表构建、ghost拷贝，含CPU辅助和部分数据传输                   | MPI breakdown中很小；Device Info把CPU Neighbor ≈1.78 单独列出（口径差异）                                            |
| Comm              | 37.69          | 5.721               | MPI通信时间(发/收ghost原子坐标和力数据和一些小的MPI内部开销)       | MPI 通信时间                                                                                                             |
| Modify            | 0.010043       | 9.592               | Fix/Compute、时间积分 (Verlet)、数据pack/unpack                    | CPU Cast/Pack ≈9.78 + CPU Driver ≈0.02                                                                                 |
| Output            | 0.0054348      | 0.086               | 文件/日志输出                                                      | 文件/日志输出                                                                                                            |
| Other             | 0.6829         | 4.545               | 杂项（初始化、内核管理、device overhead）                          | 杂项（初始化、内核管理、device overhead）                                                                                |
| **合计 (loop)**  | **98.98**     | **147.069**        | 与 Loop time 完全一致                                              | 与 Loop time 完全一致                                                                                                    |
| CPU Idle          | (摊分在各项)   | (66.60,摊分在各项)  | 已经摊分，不再单独列出                                             | 单独显示在 Device Info，用于性能分析，**不能与 MPI breakdown 相加**                                                      |

注意：
1. GPU包的Device Info中的Force calc，虽然名字是Force calc，但实际上包含了：1)每步力计算内的数据加载/原子信息访问;2)内存访问、线程同步;3)一些额外的neighbor lookup逻辑(尤其EAM核心中访问表格、embedding能)。Kokkos包只统计纯kernel的力计算，Neighbor build、ghost处理、数据移动、同步等耗时统计在Neigh/Comm/Modify中。
1. 基于上一条，造成kokkos包和GPU包计量差别的一个重要因素应该就是ghost原子(特别是邻居)的处理，kokkos包将其计入neigh/comm/modify，GPU包将其计入pair。所以并不是kokkos的邻居相关neigh/comm/modify高，而是GPU包将其计入了pair。
1. ghost原子不止是多MPI时存在，邻居列表也存在 ghost原子。
1. Comm (MPI Communication)指的是不同MPI rank/不同节点之间的数据交换（Comm包含ghost原子处理，不仅是MPI消息即使只有1个 MPI rank，LAMMPS 仍然要维护ghost原子（边界 buffer 区域），以确保邻居列表正确。）。Data Transfer (GPU-CPU memory copy)指的是 同一 MPI rank 内，CPU 主存和 GPU 显存之间的数据传输。
1. 


Kokkos版cmake(带reaxff)：
```
cmake -C ../cmake/presets/basic.cmake -C ../cmake/presets/kokkos-cuda.cmake \
      -D PKG_OPENMP=yes \
      -D PKG_REAXFF=on \
      -D PKG_GPU=on \
      -D GPU_API=cuda \
      -D GPU_ARCH=sm_86 \
      -D BIN2C=/usr/local/cuda-12.3/bin/bin2c \
      -D MPI_CXX_COMPILER=/home/xilock/Desktop/mpich412/bin/mpicxx \
      -D MPI_C_COMPILER=/home/xilock/Desktop/mpich412/bin/mpicc \
      -D MPI_HOME=/home/xilock/Desktop/mpich412 \
      ../cmake
```

给kokkos开openMP可在cmake时加如下指令，CPU耗时占大头时开多线程会有效果，但GPU耗时占大头时多线程对GPU加速没有显著影响
```
      -D Kokkos_ENABLE_OPENMP=ON \
```

测试时为了控制FFT都为KISS的话可在cmake时添加如下指令：
```
      -D FFT=KISS \
      -D FFT_KOKKOS=KISS \
```


参考[WSL2下Kokkos版加速的Lammps的cmake编译](http://bbs.keinsci.com/thread-36559-1-1.html)有一个多包版(不在`/basic.cmake`中指定而是当场指定所有)
```
cmake -C ../cmake/presets/basic.cmake \
      -C ../cmake/presets/kokkos-cuda.cmake \
 -D BUILD_MPI=yes \
 -D PKG_ASPHERE=on        -D PKG_BOCS=on           -D PKG_BODY=on        -D PKG_BROWNIAN=on \
 -D PKG_CG-SDK=on         -D PKG_CLASS2=on         -D PKG_COLLOID=on     -D PKG_CORESHELL=on \
 -D PKG_DIELECTRIC=on     -D PKG_DIFFRACTION=on    -D PKG_DIPOLE=on      -D PKG_DPD-BASIC=on \
 -D PKG_DPD-MESO=on       -D PKG_DPD-REACT=on      -D PKG_DPD-SMOOTH=on  -D PKG_DRUDE=on \
 -D PKG_EFF=on            -D PKG_EXTRA-COMPUTE=on  -D PKG_EXTRAD-UMP=on  -D PKG_EXTRA-FIX=on \
 -D PKG_EXTRA-MOLECULE=on -D PKG_EXTRA-PAIR=on     -D PKG_FEP=on         -D PKG_GRANULAR=on \
 -D PKG_KSPACE=on         -D PKG_MANIFOLD=on       -D PKG_MANYBODY=on    -D PKG_MC=on \
 -D PKG_MEAM=on           -D PKG_MGPT=on           -D PKG_MISC=on        -D PKG_ML-IAP=on \
 -D PKG_ML-SNAP=on        -D PKG_MOFFF=on          -D PKG_MOLECULE=on    -D PKG_OPENMP=on \
 -D PKG_OPT=on            -D PKG_ORIENT=on         -D PKG_PERI=on        -D PKG_PHONON=on \
 -D PKG_PLUGIN=on         -D PKG_PTM=on            -D PKG_QEQ=on         -D PKG_QTB=on \
 -D PKG_REACTION=on       -D PKG_REAXFF=on         -D PKG_REPLICA=on     -D PKG_RIGID=on \
 -D PKG_SHOCK=on          -D PKG_SMTBQ=on          -D PKG_SPH=on         -D PKG_SPIN=on \
 -D PKG_SRD=on            -D PKG_TALLY=on          -D PKG_UEF=on         -D PKG_YAFF=on \
 -D PKG_GPU=on            -D GPU_API=cuda \
 -D GPU_ARCH=sm_86 \
 -DCMAKE_CUDA_COMPILER=/usr/local/cuda-12.3/bin/nvcc \
 -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-12.3 \
 -DMPI_CXX_COMPILER=/home/xilock/Desktop/mpich412/bin/mpicxx \
 -DMPI_C_COMPILER=/home/xilock/Desktop/mpich412/bin/mpicc \
 -DMPI_HOME=/home/xilock/Desktop/mpich412 \
 ../cmake
```

GPU_ARCH的参数参考:[Packages with extra build options](https://docs.lammps.org/Build_extras.html)
```
sm_30 for Kepler (supported since CUDA 5 and until CUDA 10.x)
sm_35 or sm_37 for Kepler (supported since CUDA 5 and until CUDA 11.x)
sm_50 or sm_52 for Maxwell (supported since CUDA 6)
sm_60 or sm_61 for Pascal (supported since CUDA 8)
sm_70 for Volta (supported since CUDA 9)
sm_75 for Turing (supported since CUDA 10)
sm_80 or sm_86 for Ampere (supported since CUDA 11, sm_86 since CUDA 11.1)
sm_89 for Lovelace (supported since CUDA 11.8)
sm_90 for Hopper (supported since CUDA 12.0)
```

###### 提交指令
`mpirun -np 12 lmp -in case_nvt.in -sf gpu -pk gpu 1 platform 1`
1. Use the -sf gpu command-line switch, which will automatically append “gpu” to styles that support it. 参见["LAMMPS command - GPU package"](https://docs.lammps.org/Speed_gpu.html)
1. Use the -pk gpu Ng command-line switch to set Ng = # of GPUs/node to use.
1. platform 1 规定了在哪个显卡上加速



###### 其它问题
1. 如果win系统有更新，则可能出现`Cuda driver error 999 in call at file '/home/xilock/Desktop/lammps-29Aug2024/lib/gpu/geryon/nvd_memory.h' in line 502`等错误，重启更新后问题解决.
1. `make -j 4`时如果提示`/home/xilock/Desktop/lammps-29Aug2024/lib/kokkos/bin/nvcc_wrapper: line 365: nvcc: command not found`则是因为捯饬cuda相关步骤时导致nvcc位置变化，可去nvcc_wrapper文件的366行查看所调用的指令是什么，然后对应修改（如26行的`nvcc_compiler=nvcc`修改为`nvcc_compiler="/usr/local/cuda-12.3/bin/nvcc"`）

参考资料：
1. [在Windows上高效使用LAMMPS](https://leo-lyy.github.io/docs/WSL_LAMMPS_GPU.html)
1. [Win10+WSL2+Ubuntu22.04安装Lammps+GPU+Python](https://blog.csdn.net/apathiccccc/article/details/131538775)
1. [WSL2下gpu版lammps编译详细版](http://bbs.keinsci.com/thread-27603-1-1.html)
1. [从lib/gpu和src用make安装:lammps安装kokkos MPI实现GPU计算](https://blog.csdn.net/m0_55063425/article/details/136556312)
1. [在linux mint21.3上安装含kokkos以及deepmd的lammps & 4090的reaxff测试](http://bbs.keinsci.com/thread-46630-1-1.html)
1. [lammps gpu版编译（kokkos+cuda）](https://zhuanlan.zhihu.com/p/603892794)



### Linix版

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
`make ps`是显示安装包的状态；`make yes-all`是安装所有包；`make no-lib`是不安装有外链的包；

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


### AMD平台暗黄
1. [为某网友的AMD GPU平台编译和调优LAMMPS和GROMACS](http://bbs.keinsci.com/thread-40313-1-1.html)

### 性能调优
1.  [LAMMPS中密度不均一体系域分解问题，和性能调优的一点经验](http://bbs.keinsci.com/thread-39016-1-1.html)


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


### 并行效率
1. 用单线程效率更高（For many problems on current generation CPUs, running the OPENMP package with a single thread/task is faster than running with multiple threads/task. This is because the MPI parallelization in LAMMPS is often more efficient than multi-threading as implemented in the OPENMP package. The parallel efficiency (in a threaded sense) also varies for different OPENMP styles.）参考[《LAMMPS的多线程和多进程并行》](https://zhuanlan.zhihu.com/p/8615490989)

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
