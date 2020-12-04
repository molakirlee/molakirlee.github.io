---
layout:     post
title:      "gmx xpm图片处理"
subtitle:   ""
date:       2020-12-04 13:37:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2020


---

### XPM文件的基本结构

```
/* XPM */
static char * <pixmap_name>[] = {
<Values>
<Colors>
<Pixels>
<Extensions>
};

其中Values部分相当于图像文件的文件头，它由
<width> <height> <numcolors> <cpp> [ <x_hotspot> <y_hotspot> ] [ XPMEXT ]
构成，其中x_hotspot，y_hotspot，XPMEXT是可选的。
width:图像的宽度，像素为单位
height:图像的高度，像素为单位
numcolors:颜色数
cpp:每个像素占用的字符长度
x_hotspot:热点的X轴位置
y_hotspot:热点的Y轴位置

Colors部分定义的是调色板的信息，它由
<character> { <key> <color> } { <key> <color> }构成
character是颜色索引值，key是关键字，color是颜色值
key可以有以下几种选项：
m：单色
s：符号名称
g4：4级灰度
g：灰度
c：彩色
color也可以由以下几种构成：
颜色名称
#开头的十六进制数表示RGB空间颜色值
%开头的十六禁止数表示HSV空间颜色值
符号名称
字符串NONE，表示该颜色是透明色

Pixels部分表示实际的像素，全部采用调色板中定义的索引，由等同于图像像素高度的行构成。

Extension部分可以自己定义一些图像附件信息，如作者，标题等，形如
XPMEXT <extension_name> <extension_data_string>单行的扩展
XPMEXT <extension_name>
<extension_data_string1>
<extension_data_string2>
```

### m2p文件
在调用`xpm2ps`时，可通过指定`-di xxx.m2p`来对输出进行控制，其内容如下：  
convert.m2p:  
```
; Command line options of xpm2ps override the parameters in this file
black&white              = no           ; Obsolete
titlefont                = Times-Roman  ; A PostScript Font
titlefontsize            = 20           ; Font size (pt)
legend                   = yes          ; Show the legend
legendfont               = Times-Roman  ; A PostScript Font
legendlabel              =              ; Used when there is none in the .xpm
legend2label             =              ; Used when merging two xpm's
legendfontsize           = 14           ; Font size (pt)
xbox                     = 2.0          ; x-size of a matrix element
ybox                     = 2.0          ; y-size of a matrix element
matrixspacing            = 20.0         ; Space between 2 matrices
xoffset                  = 0.0          ; Between matrix and bounding box
yoffset                  = 0.0          ; Between matrix and bounding box
x-major                  = 20           ; Major ticks on x axis every .. frames
x-minor                  = 5            ; Id. Minor ticks
x-firstmajor             = 0            ; First frame for major tick
x-majorat0               = no           ; Major tick at first frame
x-majorticklen           = 8.0          ; x-majorticklength
x-minorticklen           = 4.0          ; x-minorticklength
x-label                  =              ; Used when there is none in the .xpm
x-fontsize               = 16           ; Font size (pt)
x-font                   = Times-Roman  ; A PostScript Font
x-tickfontsize           = 10           ; Font size (pt)
x-tickfont               = Helvetica    ; A PostScript Font
y-major                  = 20
y-minor                  = 5
y-firstmajor             = 0
y-majorat0               = no
y-majorticklen           = 8.0
y-minorticklen           = 4.0
y-label                  =
y-fontsize               = 16
y-font                   = Times-Roman
y-tickfontsize           = 10
y-tickfont               = Helvetica
```

或：  

```
linewidth = 6 
titlefont                = Arial //标题字符类型
titlefontsize            = 80 //标题字符大小
legend                  = yes //显示legend
legendfont              = Arial //legend字符类型，used when there is none in the .xpm
legendlabel              = RMSD (nm) //legend 名字，
legend2label            = //when merging two xpm's
legendfontsize          = 66  //legend字符大小
xbox                    = 10 //x-size of a matrix element 该值的大小影响画布的大小，得到的像素*像素的值改变，当xbox和ybox设置的值一样时，矩阵正方形，不一样时，是长方形
ybox                    = 10
matrixspacing            = 20  //Space between 2 matrices
xoffset                  = 300  //Between matrix and bounding box控制矩阵左边离box边的距离，同时改变x size，例如本来是2600*3400,当设置xoffset为300，则变成了2300*3400，左边离画布边的留白变小300，但是右边离画布边没有任何变化！真是bug！但是可以通过左边留白，把标题放左边
yoffset                  = 300 //控制矩阵下面离box边的距离
boxlinewidth            = 20 //box边框的宽度
ticklinewidth            = 8 //标度tick的宽度
zerolinewidth            = 0 
x-lineat0value          = none // Draw line at matrix value==0
x-major                  = 20 //x轴大分隔符间距为20，根据自己的数值设定
x-minor                  = 10 //x轴小分隔符间距为20，一般设置为major的一半
x-firstmajor            = 0  //Offset for major tick 调节第一个标度从?开始
x-majorat0              = no  // Additional Major tick at first frame
x-majorticklen          = 30 //大标度tick的长度
x-minorticklen          = 25 //小标度tick的长度
x-label                  = Time (ns)  //x轴标题
x-fontsize              = 66 //x轴标题字体大小
x-font                  = Arial //x轴标题字体类型 (Time (ns))
x-tickfontsize          = 60 //x轴标度数字大小(0,20,40...) 我发现设置为60时大小刚好，但是！右侧的最后一个数值显示不全，如上图所示，200被截断 了，只显示20，怎么调画布都不行，是个bug！自己画图时需要自己手动补全
x-tickfont              = Arial   //x轴标度数字类型
y-lineat0value          = none
y-major                  = 20 
y-minor                  = 10
y-firstmajor            = 0
y-majorat0              = no
y-majorticklen          = 30
y-minorticklen          = 25
y-label                  = Time (ns)
y-fontsize              = 66
y-font                  = Arial
y-tickfontsize          = 60
black&white              = no
y-tickfont              = Arial
```

### 参考资料：
1. [XPM文件的基本结构](https://sites.google.com/site/notegainexp/c_cplusplus/xpmwenjiandejibenjiegou)
1. [jerkwin:xpm2ps中文翻译](http://jerkwin.github.io/GMX/GMXprg/#gmx-xpm2ps-%E5%B0%86xpmxpixelmap%E7%9F%A9%E9%98%B5%E8%BD%AC%E6%8D%A2%E4%B8%BApostscript%E6%88%96xpm%E7%BF%BB%E8%AF%91-%E9%BB%84%E4%B8%BD%E7%BA%A2)
1. [gromacs xpm eps文件查看](https://www.jianshu.com/p/7c2309d146bb)
1. [使用gnuplot绘制xpm文件对应的数据](https://jerkwin.github.io/2020/08/23/%E4%BD%BF%E7%94%A8gnuplot%E7%BB%98%E5%88%B6xpm%E6%96%87%E4%BB%B6%E5%AF%B9%E5%BA%94%E7%9A%84%E6%95%B0%E6%8D%AE/)
1. [jerkwin:xpm文件处理脚本](https://jerkwin.github.io/2018/05/09/xpm%E6%96%87%E4%BB%B6%E5%A4%84%E7%90%86%E8%84%9A%E6%9C%AC/)
1. [使用xpm2all脚本计算蛋白二级结构演化及含量](https://jerkwin.github.io/2020/07/10/%E4%BD%BF%E7%94%A8xpm2all%E8%84%9A%E6%9C%AC%E8%AE%A1%E7%AE%97%E8%9B%8B%E7%99%BD%E4%BA%8C%E7%BA%A7%E7%BB%93%E6%9E%84%E6%BC%94%E5%8C%96%E5%8F%8A%E5%90%AB%E9%87%8F/)


![](/img/wc-tail.GIF)
