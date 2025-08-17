---
layout:     post
title:      "gmx Gromacs安装教程（+MPI+GPU加速版）及相关"
subtitle:   ""
date:       2019-02-02 20:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2019

---

### 单精度or双精度
1. 一般计算只需要按照前述编译单精度版本就够了，但如果模拟刚开始就崩溃，有时候用双精度版本可解决，但计算比单精度版慢将近一倍、trr/edr等文件体积大一倍。另外，做正则振动分析时在能量极小化和对角化Hessian矩阵的时候一般也需要用双精度版以确保数值精度。注意，编译双精度版本时不支持GPU加速。
1. 单双精度除了编译上有区别，fftw也不同，有些电脑自带双精度（libfftw3），记得自己编一个单精度的（如libfftw3f）

###  Linux版GMX安装
###### 安装fftw-3.2.2，安装路径为/opt/fftw-3.2.2

http://www.fftw.org/fftw-3.3.8.tar.gz下载.
```
tar xzvf fftw-3.3.4.tar.gz   
cd fftw-3.3.4  
./configure --prefix=/opt/fftw-3.3.4 --enable-sse2 --enable-avx --enable-float --enable-shared  
```
如果你的CPU相对较新，支持AVX2指令集，可再加上 `--enable-avx2` 选项以获得更好性能。

```
sudo make 
sudo make install
```
make时可调用-j，代表调用所有核并行编译，建议用于编译的核不要超过4个？即`make -j 4`。  
编译完后可以把FFTW的解压目录和压缩包删掉。  


打开~/.bashrc（gedit ~/.bashrc）
复制：

```
# For FFTW
export LD_LIBRARY_PATH=/opt/fftw-3.3.4/lib:$LD_LIBRARY_PATH
export PATH=/opt/fftw-3.3.4/bin:$PATH
```

保存后 `source ~/.bashrc` 并用 `vi ~/.bashrc`检查一下。

###### 安装CMake

先检查cmake --version，如果显示没有安装则先安装cmake

```
tar xzvf cmake-2.8.12.2.tar.gz
cd cmake-2.8.12.2
./configure --prefix=/opt/cmake-2.8.12.2
sudo make
sudo make install
```
打开~/.bashrc
复制：

```
# For CMake
export PATH=/opt/cmake-2.8.12.2/bin:$PATH
```
保存后 `source ~/.bashrc` 并用 `cmake --version` 查看版本。

######  安装cuda
去https://developer.nvidia.com/cuda-downloads下载CUDA toolkit并安装.

###### 安装OpenMPI

http://www.open-mpi.org下载OpenMPI最新版本.

```
./configure --prefix=/opt/openmpi
make all install -j
```

之后在用户目录下的.bashrc末尾加入以下两行  
```
export PATH=$PATH:/opt/openmpi/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/openmpi/lib
```

如xilock的为：
```
# openmpi
export PATH=/THFS/opt/openmpi/2.0.2/bin/:$PATH
export LD_LIBRARY_PATH=/THFS/opt/openmpi/2.0.2/lib:$LD_LIBRARY_PATH
```
然后重新进入终端使以上语句生效。

**注意，若装了mpi版本的还想再装一个非mpi版本的来供单节点使用，则需要重新编译一个gromacs且需要在编译gromacs时把mpi给OFF掉。**

###### 安装Gromacs-5.1.4

```
tar xzvf gromacs-5.1.4.tar.gz 
cd gromacs-5.1.4
mkdir build
cd build

export CMAKE_PREFIX_PATH=/<fftw的路径/>
cmake .. -DCMAKE_INSTALL_PREFIX=/opt/gromacs-5.1.4-gpu -DGMX_MPI=ON -DGMX_GPU=ON -DCUDA_TOOLKIT_ROOT_DIR=/<cuda的路径/>

sudo make 
```
进行make时，若此前安装的是cuda9.0以上版本，则可能会报错“nvcc fatal : Unsupported gpu architecture 'compute_20' while cuda9.0 is installed”  
这是由兼容性导致的，此时需要更改一下gromacs里面的文件“gromacs-5.1.2/cmake/gmxManageNvccConfig”，将其中几处带“-gencode;arch=compute_20,code=compute_20”的行处理掉（如将其注释掉）即可。  

```
sudo make install
```

**注意，也可不做`sudo make`直接`sudo make install`**

打开~/.bashrc
复制：  

```
# For Gromacs
source /opt/gromacs-5.1.4-gpu/bin/GMXRC
```

保存并 `source ~/.bashrc`

######  测试

```
gmx_mpi mdrun
```

###### 集群安装示例
本例在ntu nscc服务器上安装
1. 先后在个人文件夹（home/users/ntu/n1805727）中安装fftw-3.2.2和cmake-2.8.12.2，并添加环境变量。
2. 然后加载以下model。

```
module load gcc/4.9.3
module load openmpi/intel/1.10.2
module load cuda80/toolkit/8.0.44
```
3. 然后在gromac里的build文件夹里执行以下命令即可：

```
export CMAKE_PREFIX_PATH=/home/users/ntu/n1805727/GMX5.1.4_Mine/fftw-3.3.4-installed
cmake .. -DCMAKE_INSTALL_PREFIX=/home/users/ntu/n1805727/GMX5.1.4_Mine/gromacs-5.1.4-gpu -DGMX_MPI=ON -DGMX_GPU=ON -DCUDA_TOOLKIT_ROOT_DIR=/cm/shared/apps/cuda80/toolkit/8.0.44

make
make install 
```

4. 创建无后缀文本文件作为modulefile，内容如下：

```
#%Module -*- tcl -*-
##
## modulefile
##

set name    gromacs
set version 5.1.4
set root    /home/users/ntu/n1805727/GMX5.1.4_Mine/gromacs-5.1.4-gpu
set url     http://www.gromacs.org


module-whatis "adds $name version $version to your environment variables."

module load gcc/4.9.3
module load openmpi/intel/1.10.2
module load cuda80/toolkit/8.0.44

setenv GMXBIN                $root/bin
setenv GMXDATA               $root/share/gromacs
setenv GMXLDLIB              $root/lib64
setenv GMXMAN                $root/share/man
setenv GROMACS_DIR           $root
setenv PKG_CONFIG_PATH       $root/lib64/pkgconfig
prepend-path LD_LIBRARY_PATH $root/lib64
prepend-path MANPATH         $root/share/man
prepend-path PATH            $root/bin
```



### WSL版(以gmx2025.2为例)

可参考[GROMACS-GPU版在WSL2-Ubuntu中的安装方法 ](http://bbs.keinsci.com/thread-25516-1-1.html)

###### WSL安装
见LAMMPS安装一文

###### cmake安装
gmx2025.2要求CMake3.28或更高，可以`cmake --version`检查一下，如果版本低的话，手动编译或者通过官方 Kitware 仓库卸载重装一下，Ubuntu/Debian指令如下：
```
# 卸载旧版本（可选）
sudo apt remove --purge cmake

# 添加 Kitware 官方仓库
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/kitware.list >/dev/null

# 更新并安装最新 CMake
sudo apt update
sudo apt install cmake

# 验证版本
cmake --version  # 应输出 ≥3.28
```

###### fftw安装

```
wget http://www.fftw.org/fftw-3.3.10.tar.gz
tar -xzf fftw-3.3.10.tar.gz
cd fftw-3.3.10

# 编译单精度版本（libfftw3f）
make clean
./configure --prefix=/home/xilock/Desktop/fftw338 --enable-sse2 --enable-avx --enable-float --enable-shared

make -j 4
sudo make install

```

1. 安装完后通过`find / -name "libfftw3*so*" 2>/dev/null`看安装到哪里了（或单精度用`ls /usr/lib/x86_64-linux-gnu/libfftw3f.so* 2>/dev/null`，双精度用`ls /usr/lib/x86_64-linux-gnu/libfftw3.so* 2>/dev/null`）


###### CUDA Toolkit安装
买的成品机有时候是安装了windows版CUDA的，可以直接用，默认地址在`/usr/lib/cuda`，可在cmake中做如下添加（gmx2021后用`-DGMX_GPU=CUDA`，之前用`-DGMX_GPU=ON`）
```
cmake .. -DGMX_GPU=CUDA \
         -DCUDA_TOOLKIT_ROOT_DIR="/usr/lib/cuda" \
         -DCUDA_PATH="/usr/lib/cuda"
```

gmx2025.2要求CUDA12.1以上(Could NOT find CUDAToolkit: Found unsuitable version "11.5.119", but required is at least "12.1" (found /usr/include))，如果CUDA版本太低，就下载个新的(但不能超过nvidia-smi中硬件支持的上限)，可以与windows系统不同。在官网[CUDA Toolkit Archive](https://developer.nvidia.com/cuda-toolkit-archive)选择对应的版本，然后依据Target Platform选择到WSL-Ubuntu-2.0，得到对应的代码（Installation Instructions），依次输入对应指令即可
  参考[Windows和WSL安装CUDA](https://blog.csdn.net/Sakuya__/article/details/141254961)。
  
  
安装完后，记得**修改环境变量是将其放在默认路径的前面**，然后`nvcc --version`
  
如果同一次编译过程中用旧版本CUDA编译过，则CMake缓存可能导致即便CUDA更新但仍按旧版本报错，可尝试：`rm -rf CMakeCache.txt CMakeFiles/`

多个版本的cuda可以共存，在.bashrc中更改PATH路径即可  需注意在/usr/local/cuda以及/usr/local/cuda-11均为指向你最后安装的cudu版本的软链接.


###### gmx2025.2安装

```
mkdir build
cd build
export CMAKE_PREFIX_PATH=/home/xilock/Desktop/fftw338
```

GPU加速版cmake指令如下：
```
cmake .. \
    -DCMAKE_INSTALL_PREFIX=/home/xilock/Desktop/gromacs_2025p2_GPU \
    -DGMX_GPU=CUDA \
    -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-12.3 \
    -DCMAKE_CUDA_ARCHITECTURES=86  # 关键修改！使用数字格式
```

然后`make install -j 4`，将`source /home/xilock/Desktop/gmx2025p2/bin/GMXRC`加到`.bashrc`中`source`一下，看看`gmx -version`是否输出gromacs的信息判断是否安装成功。

其中CUDA的架构可以从`nvidia-smi -q`的 Product Architecture中找到名称(如Ampere架构对应86)后查对应数字，或者直接`nvidia-smi --query-gpu=compute_cap --format=csv`会显示如`compute_cap 8.6`


### 并行效率
1. 参考[《GROMACS (2019.3 GPU版) 并行效率测试及调试思路》](http://bbs.keinsci.com/thread-13861-1-1.html)可知：如果只配一块显卡，我们有一个核心数较少（8-12）频率较高的CPU就够了，比如桌面级别的I7，I9，如果要装多显卡的机器，那么选择cpu的时候最好满足10核左右/1块显卡比例（如果cpu主频够高，可以适当降低核心数要求），在此基础上，利用公式：cpu频率* min(显卡数*10，cpu核心数) / price，来计算搭配cpu的性价比（所以gmx2025.2在不指定核数的时候，如果调用GPU加速会自动将10物理20逻辑的机子用1MPI threads+10OpenMP threads跑，而不调用gpu时用20 MPI threads+1OpenMP thread跑？？）。
1. sob说“开HT且启用全部逻辑核心并行的时候，性能比只用物理核心时计算性能略有提升，GROMACS，启用全部逻辑核心也并非总能令性能更好，需要根据具体任务进行测试。但**如果你懒得测试，索性就用物理核心数并行就完了，注意此时一定要用-pin on，肯定会令性能有所提升，有时提升还挺大**”，参见[《正确认识超线程(HT)技术对计算化学运算的影响》](http://sobereva.com/392)
1. 单显卡情况下：只用1个Rank（运行时单进程多线程并行），如果显卡足够好，把PME任务给显卡，openmp theads 12个左右；命令如下：`gmx mdrun -pin on -ntmpi 1 -ntomp 12 -pme gpu XXX.tpr`
1. Entropy.S.I在[《GROMACS (2025.2 GPU版) 并行效率测试结果》](http://bbs.keinsci.com/forum.php?mod=viewthread&tid=54728&page=1#pid343347)一文中认为16核机子开SMT，-ntomp 31在绝大多数情况下速度最快，并在[《Gromacs跑动力学CPU和GPU占用率均不高》](http://ccc.keinsci.com/thread-35736-1-1.html)一文中强调跑GPU加速GMX应当用上CPU的超线程，但xilock实测超线程效果较差。
1. GMX2023以前的版本需要在mdrun命令中加`-update gpu`，参见[《跑GPU加速版的GMX时GPU的利用率很低》](http://ccc.keinsci.com/thread-49600-1-1.html)
1. Entropy.S.I在[《性能翻倍？RTX4090科学计算之经典MD模拟全面测试》](http://bbs.keinsci.com/thread-33296-1-1.html)一文中对不同CPU如何发挥GPU的性能有一些测试，可参考阅读。

### gmx入门级使用教程
1. [A simple guide to Gromacs 5](https://github.com/molakirlee/Blog_Attachment_A/blob/main/gmx/gromacs_tutorial_v5.pdf)  
1. [Molecular Dynamics Simulations in GROMACS Project report](http://folk.ntnu.no/preisig/HAP_Specials/AdvancedSimulation_files/2017/project%20reports/MolecularDynamics/Jan%20Schulze%20-%20MD_Report_final.pdf)  

### 其他
###### dssp安装
可在[这里](https://swift.cmbi.umcn.nl/gv/dssp/HTML/distrib.html)的“DSSP 2.*”处下载处理好的linux/win版dssp放到/usr/local/bin目录下（或设置DSSP环境变量指向“此文件”，注意不是指向该文件的路径），然后用`sudo chmod a+x /usr/local/bin/dssp`添加权限（否则会提示增加“-ver option”）。  
路径设置：  
WRONG: export DSSP=/opt/bin  
RIGHT: export DSSP=/opt/bin/dssp  

也可以在[这里](https://swift.cmbi.umcn.nl/gv/dssp/)下载dssp，但没弄明白怎么安装。  

对于linux版的gromacs,'gmx do_dssp'假定dssp可执行程序的路径为/usr/local/bin/dssp. 如果不是, 那么需要设置环境变量DSSP, 并将其指向dssp可执行程序的路径, 例如setenv DSSP /opt/dssp/bin/dssp. 如果使用bash, 可使用export DSSP='/opt/dssp/bin/dssp', 也可以直接将该变量加到bash的配置文件中。
对于win版的gromacs，调用[dssp](https://github.com/molakirlee/Blog_Attachment_A/blob/main/gmx/dssp-2.0.4-win32.exe)时需要新建一个名为DSSP的系统环境变量，值设置为E:\dssp-2.0.4.exe，指向dssp文件。

### Q&A
###### cmake阶段The C compiler identification is GNU 4.4.7/unknown
gromacs 2019要求gcc至少为4.8.1(gromacs2019不支持gcc5.2，还是得用4.8；gromacs2020要求gcc>=5.0)，但有时即便安装了新版本仍然会在cmake时报版本过久，故此时需要指定路径，即：`[user1@node1 build]$ cmake .. -DCMAKE_CXX_COMPILER=/usr/local/gcc-5.2.0/bin/g++ -DCMAKE_C_COMPILER=/usr/local/gcc-5.2.0/bin/gcc`。**注意这两个路径要紧跟着`cmake ..`，放在后面没效果好像。** 

比如，若玺洛克添加的gcc环境变量为：
```
# gcc 4.8.5
export LD_LIBRARY_PATH=/THFS/opt/intel/18_1/compilers_and_libraries_2018.0.128/linux/mkl/lib/intel64_lin:/THFS/opt/intel/18_1/compilers_and_libraries_2018.0.128/linux/mpi/intel64/lib:/THFS/opt/intel/18_1/compilers_and_libraries_2018.0.128/linux/compiler/lib/intel64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/THFS/opt/gcc/4.8.5/lib64/:$LD_LIBRARY_PATH
export PATH=/THFS/opt/gcc/4.8.5/bin/:$PATH
```

玺洛克用mpi版编译时指令如下：
```
cmake .. -DCMAKE_CXX_COMPILER=/THFS/opt/gcc/4.8.5/bin/g++ -DCMAKE_C_COMPILER=/THFS/opt/gcc/4.8.5/bin/gcc -DCMAKE_INSTALL_PREFIX=/THFS/home/q-nwu-jmm/Desktop/INSTALL_Xilock/gromacs_install/gromacs20196_installed -DGMX_MPI=ON
```

若MPI的路径也有问题，则检查bashrc里添加的是否正确，或者在编译阶段添加MPI的路径（，一般通过前者可以解决），相关命令为（具体见参考资料）：
```
-DMPI_C_COMPILER=/public/software/mpi/openmpi-16-intel/bin/mpicc 
-DMPI_CXX_COMPILER=/public/software/mpi/openmpi-16-intel/bin/mpicxx 
```



###### WARNING: Using the slow plain C kernels. This should not happen during routine usage on supported platforms.

有些超算上面的gromacs编译的不好，使用时会提示`WARNING: Using the slow plain C kernels. This should not happen during routine usage on supported platforms.`，严重影响效率（效率相差几倍！如6h的任务变为24h），建议重新编译!

### 参考资料：
1. [Sob:GROMACS的安装方法](http://sobereva.com/457)
1. [Dealing with The compiler /usr/bin/c++ has no C++11 support for CentOS 6](https://thelinuxcluster.com/2018/02/26/dealing-with-the-compiler-usr-bin-c-has-no-c11-support-for-centos-6/)
1. [Lammps分子动力学软件MPI并行+Intel高效编译版 Linux完整安装教程](https://my.oschina.net/u/2996334/blog/3095634)


![](/img/wc-tail.GIF)
