---
layout:     post
title:      "Gromacs安装教程（+MPI+GPU加速版）及相关"
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

## GMX安装
### 一、安装fftw-3.2.2，安装路径为/opt/fftw-3.2.2

http://www.fftw.org/fftw-3.3.8.tar.gz下载.
```
gzip xzvf fftw-3.3.4.tar.gz   
cd fftw-3.3.4  
./configure --prefix=/opt/fftw-3.3.4 --enable-sse2 --enable-avx --enable-float --enable-shared  
```
如果你的CPU相对较新，支持AVX2指令集，可再加上 `--enable-avx2` 选项以获得更好性能。

```
sudo make 
sudo make install
```
make时可调用-j，代表调用所有核并行编译。  
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
然后重新进入终端使以上语句生效。


### 五、安装Gromacs-5.1.4

```
gzip xzvf gromacs-5.1.4.tar.gz 
cd gromacs-5.1.4
mkdir build
cd build

export CMAKE_PREFIX_PATH=\<fftw的路径\>
cmake .. -DCMAKE_INSTALL_PREFIX=/opt/gromacs-5.1.4-gpu -DGMX_MPI=ON -DGMX_GPU=ON -DCUDA_TOOLKIT_ROOT_DIR=\<cuda的路径\>

sudo make 
```
进行make时，若此前安装的是cuda9.0以上版本，则可能会报错“nvcc fatal : Unsupported gpu architecture 'compute_20' while cuda9.0 is installed”  
这是由兼容性导致的，此时需要更改一下gromacs里面的文件“gromacs-5.1.2/cmake/gmxManageNvccConfig”，将其中几处带“-gencode;arch=compute_20,code=compute_20”的行处理掉（如将其注释掉）即可。  

```
sudo make install
```

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

## 其他
###### dssp安装
可在[这里](https://swift.cmbi.umcn.nl/gv/dssp/HTML/distrib.html)的“DSSP 2.*”处下载处理好的linux/win版dssp放到/usr/local/bin目录下（或设置DSSP环境变量指向“此文件”，注意不是指向该文件的路径），然后用`sudo chmod a+x /usr/local/bin、dssp`添加权限（否则会提示增加“-ver option”）。  
路径设置：  
WRONG: export DSSP=/opt/bin  
RIGHT: export DSSP=/opt/bin/dssp  

也可以在[这里](https://swift.cmbi.umcn.nl/gv/dssp/)下载dssp，但没弄明白怎么安装。  


![](/img/wc-tail.GIF)
