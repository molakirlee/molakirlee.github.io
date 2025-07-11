---
layout:     post
title:      "ORCA 与gaussian比较"
subtitle:   ""
date:       2025-06-11 22:28:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Orca
    - 2025

---


1. 在高斯里6-31G(d)的d极化函数是笛卡尔函数，而在ORCA里是球谐函数，因此两者的能量是不能直接比的。参见http://sobereva.com/573
1. 至于时间，注意高斯的opt和freq的时间是分开打印的，最后打出来的只是freq时间，opt的时间在输出文件大概60%的地方（搜"Elapsed time:"），两者相加才是opt+freq的总时间。你这样比就会发现和orca用的时间基本没有区别。
1. 再者。高斯对于Pople系列基组做了特殊的优化，而RIJCOSX是针对Ahlrichs系列基组做优化的。所以ORCA里建议用def2-SVP这一类基组，这样性价比高一些。def2-SVP对应6-31G(d,p)，def2-SV(P)对应6-31G(d)。
1. ORCA用6-31G(d)、6-31G(d,p)可能慢一些，毕竟高斯是对6-31G(d)这一类Pople基组进行了特殊优化的。但是ORCA一直是不建议用Pople基组的，而建议用def2系列基组。ORCA无论是算纯泛函（任意基组）、杂化泛函（triple-zeta def2基组及以上）、双杂化泛函都有明显优势。至于是不是比高斯快，出于众所周知的原因我没办法在公共场合说，大家一测便知。杂化泛函double zeta基组是高斯相比ORCA最具有“比较优势”的情形。然而大家提到DFT计算，言必称B3LYP/6-31G(d)，哪怕ORCA用B97-3c之类的方法算得可能比B3LYP/6-31G(d)既更快又更准（disclaimer: 我没认真测过时间，所以说“可能”。但更准是公认的），只要不是B3LYP/6-31G(d)算的，很多人就不认。殊不知B3LYP/6-31G(d)这个计算级别正是被高斯带火的，因为高斯尤其擅长这个，而又有很长一段时间没有什么软件能和高斯竞争，所以B3LYP/6-31G(d)成了行业标准。如果当年是ORCA先一统江湖，高斯再崛起的话，说不定会轮到高斯新手用户抱怨高斯的B97-3c、BP86/def2-SVP太慢。
1. 对于没有TDDFT解析Hessian的G09、目前版本ORCA的情况，对几十原子体系做振动分析花一个礼拜左右时间是司空见惯的事。如果有G16，建议用支持TDDFT解析Hessian的G16算，耗时能低一个数量级

参考资料:
1. [谈谈不同量子化学程序计算结果的差异问题](http://sobereva.com/573)
1. [orca计算频率非常耗时的问题](http://bbs.keinsci.com/thread-24220-1-1.html)
1. [ORCA 计算频率耗时问题](http://bbs.keinsci.com/thread-30929-1-1.html)

![](/img/wc-tail.GIF)
