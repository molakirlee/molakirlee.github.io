---
layout:     post
title:      "AutoCAD Solidworks问题"
subtitle:   "一些使用AutoCAD和Solidworks过程中遇到的问题"
date:       2018-10-26 19:52:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - CS
    - 2018


---


### AutoCAD
###### AutoCAD闪退
使用WintoGo安装AutoCAD后，每次从移动设备启动，打开cad都会闪退，需要删除“C:\Documents and Settings\All Users\Application Data\FLEXnet”文件夹下的所有文件后重新破解以下即可。
以下代码为快速打开该文件夹：
```
start /max "" "C:\Documents and Settings\All Users\Application Data\FLEXnet"
```

### Solidworks
#### 关于SW2012 启动缺失slderrresu.dll和sldresu.dll的解决方法:
###### 问题描述
安装过程到%40-50%左右杀毒软件会出现风险提示，全部选择允许程序执行，如果选择阻止此程序执行，将无法安装简体中文语言包。即便安装成功，双击桌面图标会出现提示：failed to load: X:\Program Files\SolidWorks Corp\SolidWorks\lang\chinese-simplified\slderrresu.dll,再点就出现 X:\ProgramFiles\SolidWorksCorp\SolidWorks\lang\chinese-simplified\sldresu.dll can not be applicated。总之无法启动solidworks2012。
###### 解决办法
找到你下载下来的solidworks2012.ISO格式的文件，打开找到swwi\lang\chinese-simplified\setup.exe ，手动安装一遍即可。




![](/img/wc-tail.GIF)