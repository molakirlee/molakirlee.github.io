---
layout:     post
title:      "常用shell命令总结"
subtitle:   "发现自己总忘，就整理了一下贴在这里了"
date:       2018-10-26 19:52:00
author:     "XiLock"
header-img: "img/in-post/2018-10-26-git-notes/post-bg-rwd.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - 2018


---

### shell脚本文件夹内文件依次执行
这个脚本非常简单，个人觉得也很实用，对于初学linux或者bash的小伙伴们，我觉得在很多地方可以解放我们的小手。写的这个脚本是因为师弟师妹们有很多高斯文件需要计算，高斯的计算文件一般以 gjf或者 com结尾。所以要师弟师妹们把文件放到一个文件夹下，然后批量执行。为了以后的方便我还写了通过识别后缀是否执行。脚本全文如下:
```
#!/bin/bash


for  i in `ls` ;
do
    echo "文件的后缀为"${i##*.}    
if [ ${i##*.} = "gjf" ]||[ ${i##*.} = "com" ];then
        echo $i"后缀正确，开始计算"
        g09 $i
    fi
done
    echo "计算完成"
```

首先通过一个for循环结合 ls查看文件命令依次读取文件，然后用一个 if命令判定后缀是否后缀正确， ##*.表示删除最后一个点以及左边的字符。


### 相关阅读：  
[Linux常用命令](https://mp.weixin.qq.com/s?__biz=MzU5OTMyODAyNg==&mid=2247484700&idx=1&sn=10cacf3afd4781989ca30a5ff0a4fc50&chksm=feb7d169c9c0587f0778e7f7bd4266661a10da32d1b335328362d37589b79643d6fbef8a7282&mpshare=1&scene=24&srcid=0424EZoT5RnWFtL6ZjGTcHvV#rd)


![](/img/wc-tail.GIF)