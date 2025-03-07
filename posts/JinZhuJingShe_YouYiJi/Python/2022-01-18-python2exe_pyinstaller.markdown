---
layout:     post
title:      "python python转exe pyinstaller"
subtitle:   ""
date:       2021-08-24 23:29:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Python
    - 2021


---

### 安装
`conda install pyinstaller`或`pip install pyinstaller`

### 使用
```
pyinstaller [opts] yourprogram.py

-F 指定打包后只生成一个exe格式的文件(建议写上这个参数)
-D –onedir 创建一个目录，包含exe文件，但会依赖很多文件（默认选项）
-c –console, –nowindowed 使用控制台，无界面(默认)
-w –windowed, –noconsole 使用窗口，无控制台
-p 添加搜索路径，让其找到对应的库。
-i 改变生成程序的icon图标(比如给女朋友写的程序，换个好看的图标，默认的很丑)
```

如：`pyinstaller -F test.py -i test.ico`


### exe文件太大
1. 因为Anaconda里内置了很多库，打包的时候打包了很多不必要的模块进去，导致打包后的.exe文件变得很大。”因此可以使用虚拟环境pipenv来打包。 pipenv是虚拟的oython环境，即，它可以在电脑上某个文件夹下创建一个虚拟的python环境，这个环境和你用Anaconda安装的oython,是完全独立的，互相不影响。这个新建的虚拟的python环境里边包含的库非常少，你可以在里边安装你的.py源文件里需要的第三方库，然后打包成.exe,这时打包的.ex文件中不会被无缘无故添加一些不相关的库，因此会生成大小合适的.exe文件。
1. xilock在vscode里弄失败了，直接在anaconda里弄吧
1. 安装pipenv: `pip install pipenv`
1. cd到想要作为虚拟环境的文件夹下，比如D:\data_analysis\pipenvTest，然后执行`pipenv install --python 3.8`，这样就在D:\data_analysis\pipenvTest目录下创建了一个局部环境，在pipenv文件夹下会出现Pipfile文件。
1. 激活环境:`pipenv shell`，查看已有的库：`pip list`。
1. 安装自己.py文件中所需的第三方库。比如：`pipenv install pyinstaller`、`pipenv insatall openpyxl`，然后再用`pip list`查看虚拟环境中的库。
1. 利用pyinstaller生成exe文件：将.py文件拷到当前目录下，执行`pyinstaller -F .\dataAnalysis_v3.py `


### 参考资料
1. [简单3步将你的python转成exe格式](https://blog.csdn.net/Dopamy_BusyMonkey/article/details/106398497)


![](/img/wc-tail.GIF)
