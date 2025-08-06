---
layout:     post
title:      "gmx 批处理提交计算扩散系数的脚本"
subtitle:   ""
date:       2019-08-21 20:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2019

---

### 说明
因为要分别计算60个Ca离子的扩散系数，所以就写了这个脚本，使用时需要提供三种文件：
- .tpr
- .xtc
- .ndx

ndx文件要提前处理，利用make_ndx的'splitat'等将每个Ca写入单独的分组，如：  
```
[CA58]
95227
[CA59]
95228
[CA60]
95229
```



### 脚本
用./文件名 运行脚本，记得提高文件权限。  
Calculate_Diffusion_Ceofficient_of_Cacium_ions.sh  

```
#!/bin/bash

#计算每一个Ca离子的msd
for ((i=1; i<=60; i ++))
do
#从第26个组开始是第1个Ca离子
nca=$[i+25]
#执行gmx命令
echo $nca | gmx msd -s nvt_50ns.tpr -f nvt_0-80ns.xtc -b 78000 -e 78750 -n index_ca -o msd_$i.xvg
#完成
done
#
#将60个Ca离子的msd文件中的第19行提取出，里面有扩散系数Df
for ((i=1; i<=60; i ++))
do
#提取第19行
sed -n 19p msd_$i.xvg >> 1.txt

done
```

### 脚本链接
参见[链接](https://github.com/molakirlee/Blog_Attachment_A/blob/main/gmx/Calculate_Diffusion_Ceofficient_of_Cacium_ions.sh)

![](/img/wc-tail.GIF)
