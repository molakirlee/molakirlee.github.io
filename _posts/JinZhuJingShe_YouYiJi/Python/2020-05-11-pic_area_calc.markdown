---
layout:     post
title:      "python 基于python的图像轮廓识别及轮廓表面积计算"
subtitle:   ""
date:       2020-05-11 09:57:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Python
    - 2020


---

### 环境
1. python 2.7
1. cv2 ([opencv-3.1.0.exe](https://opencv.org/releases/)，因为测试环境为python 2.7 32bt，所以太新的版本不支持，但太久的版本语法又存在差异，如cv2.findContours参数。安装时在解压后将OpenCV目录下的 \build\python2.7\x64文件下的cv2.pyd拷贝到 Python目录下的\Lib\site-packages文件夹里即可)
1. Tkinter
1. numpy
1. matplotlib

### 轮廓识别Code
Xilock在case中采用了两种方法：
1. 灰度阈值+中值滤波+轮廓描绘
1. 大津法(OSTU)+轮廓描绘
具体参见：[利用灰度法计算覆盖面积](https://molakirlee.github.io/attachment/python/case1_single_color_peak.rar)  

参考资料：
1. [python + openCV 实现图像轮廓识别和面积计算](https://blog.csdn.net/whymeYan/article/details/78856964)


### 多通道BGR
考虑通过BGR分离或者多通道实现更精确的识别，xilock尚未具体实施，只是处理了一下多通道绘制的方法，代码如下：
```
#coding=utf-8  
import cv2  
import numpy as np  
from matplotlib import pyplot as plt
       
img = cv2.imread('14032.jpg')  
#img = cv2.imread('p1.dat.bmp')  
bins = np.arange(256) #直方图中各bin的顶点位置  
color = [ (255,0,0),(0,255,0),(0,0,255) ] #BGR三种颜色  
for ch, col in enumerate(color):  
    originHist = cv2.calcHist([img],[ch],None,[256],[0,256])  
    cv2.normalize(originHist, originHist,0,255*0.9,cv2.NORM_MINMAX)  
    plt.subplot(1,3,ch+1),plt.plot(originHist)
    
plt.show()
```


参考资料：
1. [OpenCV Python教程（3、直方图的计算与显示）](https://blog.csdn.net/sunny2038/article/details/9097989)



![](/img/wc-tail.GIF)
