---
layout:     post
title:      "MS Stress - Strain"
subtitle:   ""
date:       2021-05-01 23:02:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - MS
    - 2021

---

### 导入StressStrain脚本
MS2017自带StreeStrain.pl脚本(使用Souza-Martins方法计算应力-应变曲线的脚本)可以用来分析应力应变曲线，导入过程参见`Tutorials > Scripting tutorials > Executing scripts from the User menu`。  

简单概括如下：
1. Open the `Script Library` dialog and, on the `Library` tab, click `Add` button for `Location`.
1. Change the name of the new folder to `Examples`.
1. In the bottom panel of the `Library` tab, click the `<click to add path>` item.
1. In the `type path here` field, enter the full path to your \share\Examples\Scripting folder.如`C:\Program Files (x86)\BIOVIA\Materials Studio 2017\share\Examples\Scripting`.
1. On the `User Menu` tab, click the `Import...` button. Navigate to the `Examples\Scripting` folder and open `StressStrain User Menu.xml`.添了一个名为StressStrain的commond.
1. Select the `StressStrain` command.出现了commond的detail，脚本名此时是红色的.
1. Click the "..." button for the Script.出现一个tree
1. Expand the `Examples` folder and select `StressStrain.pl`, click the `OK` button and then close the Script Library dialog.现在脚本名变黑了，可以用了.
1. Select `File | Save Project` from the menu bar, followed by `Window | Close All`.

### 参考资料
1. [在MS/user中添加StressStrain脚本](https://zhuanlan.zhihu.com/p/340276430)

![](/img/wc-tail.GIF)
