---
layout:     post
title:      "CentOS 7 安装显卡驱动及CUDA"
subtitle:   ""
date:       2020-09-29 16:13:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Linux
    - 2020

---
  
### 安装显卡驱动
###### 下载相应驱动
在英伟达官网下载相应驱动。
###### 屏蔽默认带有的nouveau
打开`/lib/modprobe.d/dist-blacklist.conf`,将nvidiafb注释掉：`#blacklist nvidiafb`。然后添加以下语句：
```
blacklist nouveau
options nouveau modeset=0
```
###### 重建initramfs image
```
# cp /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.bak
# dracut /boot/initramfs-$(uname -r).img $(uname -r)
# rm /boot/initramfs-$(uname -r).img.bak ; 这一步可不执行
```

###### 修改运行级别为文本模式并重启
```
# systemctl set-default multi-user.target
# reboot
```
###### 预安装组件
预安装一些必需的组件，需要联网：
```
# yum install gcc kernel-devel kernel-headers
```

###### 安装驱动
进入下载的驱动所在目录（注意：必需指定 kernel source path，否则会报错；kernel 的版本和系统内核有关，可能会有差别）：
```
chmod +x NVIDIA-Linux-x86_64-384.81.run
# ./NVIDIA-Linux-x86_64-384.81.run --kernel-source-path=/usr/src/kernels/3.10.0-693.5.2.el7.x86_64  -k $(uname -r)
```
安装过程中，选择accept，如果提示要修改xorg.conf，选择yes。

###### 检查
执行如下两条语句，如果出现显卡的型号信息，说明驱动已经安装成功：
```
# lspci |grep NVIDIA
# nvidia-smi
```

### CUDA安装
###### 下载
根据实际情况和需求下载相应的CUDA：https://developer.nvidia.com/cuda-toolkit-archive
###### 预安装
安装gcc、g++编译器、kernel-devel（安装前先检查是否已安装）：
```
sudo yum install gcc    
sudo yum install gcc-c++  
sudo yum install kernel-devel  
```

###### 安装CUDA
参照官网给的步骤去做即可，一般就像这样：
```
sudo sh cuda_9.0.176_384.81_linux-run.run
```

**注意：我们前面是自己安装了匹配的驱动的，所以第一项Driver出来的时候选择N 后面全是Y ,即可**

###### 配置环境变量

```
export PATH=$PATH:/usr/local/cuda-9.0/bin    
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-9.0/lib64  
```

### 参考资料
1. [CentOS 7 安装 NVIDIA 显卡驱动和 CUDA Toolkit](https://blog.csdn.net/xueshengke/article/details/78134991)
1. [centos7系统，显卡驱动安装教程](https://www.jianshu.com/p/14293f82fcb0)
1. [centos 7 安装CUDA9.0 +CUDNN](https://www.jianshu.com/p/a201b91b3d96)

![](/img/wc-tail.GIF)
