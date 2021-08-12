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

## GMX安装
### 一、安装fftw-3.2.2，安装路径为/opt/fftw-3.2.2

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

### 二、安装CMake

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

### 三、安装cuda
去https://developer.nvidia.com/cuda-downloads下载CUDA toolkit并安装.

### 四、安装OpenMPI

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

### 五、安装Gromacs-5.1.4

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

### 六、测试

```
gmx_mpi mdrun
```

### 七、例子
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


## 入门级使用教程
1. [A simple guide to Gromacs 5](https://molakirlee.github.io/attachment/gmx/gromacs_tutorial_v5.pdf)  
1. [Molecular Dynamics Simulations in GROMACS Project report](http://folk.ntnu.no/preisig/HAP_Specials/AdvancedSimulation_files/2017/project%20reports/MolecularDynamics/Jan%20Schulze%20-%20MD_Report_final.pdf)  

## 其他
###### dssp安装
可在[这里](https://swift.cmbi.umcn.nl/gv/dssp/HTML/distrib.html)的“DSSP 2.*”处下载处理好的linux/win版dssp放到/usr/local/bin目录下（或设置DSSP环境变量指向“此文件”，注意不是指向该文件的路径），然后用`sudo chmod a+x /usr/local/bin/dssp`添加权限（否则会提示增加“-ver option”）。  
路径设置：  
WRONG: export DSSP=/opt/bin  
RIGHT: export DSSP=/opt/bin/dssp  

也可以在[这里](https://swift.cmbi.umcn.nl/gv/dssp/)下载dssp，但没弄明白怎么安装。  

对于linux版的gromacs,'gmx do_dssp'假定dssp可执行程序的路径为/usr/local/bin/dssp. 如果不是, 那么需要设置环境变量DSSP, 并将其指向dssp可执行程序的路径, 例如setenv DSSP /opt/dssp/bin/dssp. 如果使用bash, 可使用export DSSP='/opt/dssp/bin/dssp', 也可以直接将该变量加到bash的配置文件中。
对于win版的gromacs，调用[dssp](https://molakirlee.github.io/attachment/gmx/dssp-2.0.4-win32.exe)时需要新建一个名为DSSP的系统环境变量，值设置为E:\dssp-2.0.4.exe，指向dssp文件。

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
