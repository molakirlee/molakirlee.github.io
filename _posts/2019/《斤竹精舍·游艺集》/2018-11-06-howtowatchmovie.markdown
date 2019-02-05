---
layout:     post
title:      "Gromacs安装教程（+MPI+GPU加速版）"
subtitle:   ""
date:       2019-02-02 20:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - 2019

---

### 一、安装fftw-3.2.2，安装路径为/opt/fftw-3.2.2

http://www.fftw.org/fftw-3.3.8.tar.gz下载.

gzip xzvf fftw-3.3.4.tar.gz 
cd fftw-3.3.4
./configure --prefix=/opt/fftw-3.3.4 --enable-sse2 --enable-avx --enable-float --enable-shared
<!--如果你的CPU相对较新，支持AVX2指令集，可再加上--enable-avx2选项以获得更好性能。-->
sudo make 
sudo make install
<!--
make时可调用-j，代表调用所有核并行编译。
编译完后可以把FFTW的解压目录和压缩包删掉。
-->


打开~/.bashrc（gedit ~/.bashrc）
复制：
# For FFTW
export LD_LIBRARY_PATH=/opt/fftw-3.3.4/lib:$LD_LIBRARY_PATH
export PATH=/opt/fftw-3.3.4/bin:$PATH
保存
source ~/.bashrc

vi ~/.bashrc检查一下

### 二、安装CMake

先检查cmake --version，如果显示没有安装则先安装cmake

tar xzvf cmake-2.8.12.2.tar.gz
cd cmake-2.8.12.2
./configure --prefix=/opt/cmake-2.8.12.2
sudo make
sudo make install

打开~/.bashrc
复制：
# For CMake
export PATH=/opt/cmake-2.8.12.2/bin:$PATH
保存
source ~/.bashrc
cmake --version

### 三、安装cuda
去https://developer.nvidia.com/cuda-downloads下载CUDA toolkit并安装.

### 四、安装OpenMPI

http://www.open-mpi.org下载OpenMPI最新版本.

./configure --prefix=/opt/openmpi
make all install -j
之后在用户目录下的.bashrc末尾加入以下两行
export PATH=$PATH:/opt/openmpi/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/openmpi/lib
然后重新进入终端使以上语句生效。


### 五、安装Gromacs-5.1.4

gzip xzvf gromacs-5.1.4.tar.gz 
cd gromacs-5.1.4
mkdir build
cd build

export CMAKE_PREFIX_PATH=<fftw的路径>
cmake .. -DCMAKE_INSTALL_PREFIX=/opt/gromacs-5.1.4-gpu -DGMX_MPI=ON -DGMX_GPU=ON -DCUDA_TOOLKIT_ROOT_DIR=<cuda的路径>

sudo make 
<!--
进行make时，若此前安装的是cuda9.0以上版本，则可能会报错“nvcc fatal : Unsupported gpu architecture 'compute_20' while cuda9.0 is installed”
这是由兼容性导致的，此时需要更改一下gromacs里面的文件“gromacs-5.1.2/cmake/gmxManageNvccConfig”，将其中几处带“-gencode;arch=compute_20,code=compute_20”的行处理掉（如将其注释掉）即可。
-->
sudo make install

打开~/.bashrc
复制：
#For Gromacs
source /opt/gromacs-5.1.4-gpu/bin/GMXRC
保存
source ~/.bashrc

### 六、测试
gmx_mpi mdrun

### 七、例子
本例在ntu nscc服务器上安装
1. 先后在个人文件夹（home/users/ntu/n1805727）中安装fftw-3.2.2和cmake-2.8.12.2，并添加环境变量。
2. 然后加载以下model。
module load gcc/4.9.3
module load openmpi/intel/1.10.2
module load cuda91/toolkit/9.1.85
3. 然后在gromac里的build文件夹里执行以下命令即可：
export CMAKE_PREFIX_PATH=/home/users/ntu/n1805727/GMX5.1.4_Mine/fftw-3.3.4-installed
cmake .. -DCMAKE_INSTALL_PREFIX=/home/users/ntu/n1805727/GMX5.1.4_Mine/gromacs-5.1.4-gpu -DGMX_MPI=ON -DGMX_GPU=ON -DCUDA_TOOLKIT_ROOT_DIR=/app/cuda91/toolkit/9.1.85
make
make install 

![](/img/wc-tail.GIF)
