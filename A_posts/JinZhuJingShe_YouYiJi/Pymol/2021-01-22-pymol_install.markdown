---
layout:     post
title:      "Pymol 安装 with PiView"
subtitle:   ""
date:       2021-01-22 19:03:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Pymol
    - 2021

---

感谢好友[SuperNova](https://www.zhihu.com/people/zhang-jia-xing-42-34)的帮助！

### 准备工作
**本文以Anaconda里安装pymol为例（开源），二进制版见参考资料**

1. [下载](https://www.lfd.uci.edu/~gohlke/pythonlibs/#pymol)与系统上的Python匹配的PyMOL主程序的whl文件（如：pymol-2.1.0-cp27-cp27m-win_amd64.whl），以及PyMOL的启动器whl文件（如：pymol_launcher-2.1-cp27-cp27m-win_amd64.whl），置于临时的工作目录里；
1. 在工作目录中启动Anaconda

### 安装
```
conda create -n pymol27 python=2.7
conda activate pymol27
pip install numpy
pip install pmw
pip install --no-index --find-links="%CD%" pymol_launcher
```

如果一安装numpy就自动升级python且找不到解决方案，那就用`conda create -n python27 python=2.7 anaconda`强行安装python2.7所有的默认包（约2.1G）。

若要更新PyMOL，运行如下命令（其中pymol.whl是更新后的主程序的whl，launcher 不需要更新）
```
pip install --no-index --find-links="%CD%" pymol_launcher
```
要使用较新的单窗口Qt接口，还要为Python安装PyQt5依赖项（可选）：
```
pip install pyqt5
```

### PiViewer安装
安装PiViewer需要以下条件：
1. Python 2.x/3.x（建议2.7）
1. NumPy
1. Openbabel and Pybel (Python wrapper)
1. PyMOL (optional if GUI needed)

所以还需要安装Openbabel：
```
conda install -c openbabel openbabel
```

输入`obabel`，如果出现"No input file or format spec or possible a misplaced option." balabala的就是可以了。再进入python环境中试试能不能`import opebbabel`和`import pybel`。

之后在anaconda里输入`pymol`调出pymol主程序，然后在Plugin-->Plugin Manager-->Install New Plugin里安装“PiViewer_plugin.py”，安装成功后，重新启动pymol即可使用。

### pymol使用教程
1. [PyMOL中文教程：入门教程](http://pymol.chenzhaoqiang.com/intro/startManual.html)
1. [Pymol常用命令](https://www.x-mol.com/groups/cpu1604/events/37369)
1. [零基础PyMOL作图教程——绘制蛋白质-分子结合模式图](https://zhuanlan.zhihu.com/p/62350762)
1. [高质量PyMOL作图教程](https://zhuanlan.zhihu.com/p/61568763)

### 选择语句
1. [Pymol 选择速查手册](http://kangsgo.com/706.html)
1. [PyMOL 选择器的语法参考](https://zhuanlan.zhihu.com/p/121215784)

### 参考资料
1. [Win10安装免费开源PyMOL的过程](https://zhuanlan.zhihu.com/p/112479336)
1. [开源版和试用版pymol的安装](https://jerkwin.github.io/2020/04/20/%E5%BC%80%E6%BA%90%E7%89%88%E5%92%8C%E8%AF%95%E7%94%A8%E7%89%88pymol%E7%9A%84%E5%AE%89%E8%A3%85/)
1. [Win或Linux系统下用conda安装Open Babel](https://zhuanlan.zhihu.com/p/83585670)
1. [Github:PiViewer](https://github.com/hugecadd/PiViewer)
1. [PiViewer: An open‐source tool for automated detection and display of π–π interactions](https://onlinelibrary.wiley.com/doi/abs/10.1111/cbdd.13340)



![](/img/wc-tail.GIF)
