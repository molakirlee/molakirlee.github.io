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

### 参考资料
1. [简单3步将你的python转成exe格式](https://blog.csdn.net/Dopamy_BusyMonkey/article/details/106398497)


![](/img/wc-tail.GIF)
