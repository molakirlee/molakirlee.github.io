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
1. `cmake -C ../cmake/presets/basic.cmake -D PKG_OPENMP=yes -D PKG_GPU=on -D GPU_API=cuda -D GPU_ARCH=sm_80 ../cmake`，其中GPU_ARCH为GPU架构型号，可通过`nvidia-smi -q | grep Architecture`，显示`Architecture: 75`,或显示Ampere然后查询对应数字是80/86；`/basic.cmake` 中有如MOLECULE , MANYBODY等包，但`CLASS2` `REACTION`等需要额外添加（以后用的时候发现缺啥了就回来加上以后重新cmake）。
1. `make -j 4`，如果不添加数字则默认最大，会因为内存不够而失败
1. `make install`
1. `vim .bashrc`并添加 `export PATH=/home/skywalker/lammps-2Aug2023/build:$PATH`后`source .bashrc`


GPU_ARCH的参数参考:
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

参考资料：
1. [在Windows上高效使用LAMMPS](https://leo-lyy.github.io/docs/WSL_LAMMPS_GPU.html)
1. [Win10+WSL2+Ubuntu22.04安装Lammps+GPU+Python](https://blog.csdn.net/apathiccccc/article/details/131538775)
1. [WSL2下gpu版lammps编译详细版](http://bbs.keinsci.com/thread-27603-1-1.html)
1. []()


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
