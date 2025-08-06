---
layout:     post
title:      "gmx Gromacs如何自定义残基"
subtitle:   ""
date:       2019-07-10 20:20:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2019

---

参考1:[GROMACS非标准残基教程1：修改力场与增加残基](https://jerkwin.github.io/2017/09/14/GROMACS%E9%9D%9E%E6%A0%87%E5%87%86%E6%AE%8B%E5%9F%BA%E6%95%99%E7%A8%8B1-%E4%BF%AE%E6%94%B9%E5%8A%9B%E5%9C%BA%E4%B8%8E%E5%A2%9E%E5%8A%A0%E6%AE%8B%E5%9F%BA/)    
参考2:[GROMACS非标准残基教程2：芋螺毒素小肽实例](https://jerkwin.github.io/2017/09/20/GROMACS%E9%9D%9E%E6%A0%87%E5%87%86%E6%AE%8B%E5%9F%BA%E6%95%99%E7%A8%8B2-%E8%8A%8B%E8%9E%BA%E6%AF%92%E7%B4%A0%E5%B0%8F%E8%82%BD%E5%AE%9E%E4%BE%8B/)    
参考3[使用AmberTools+ACPYPE+Gaussian创建小分子GAFF力场的拓扑文件](https://jerkwin.github.io/2015/12/08/%E4%BD%BF%E7%94%A8AmberTools+ACPYPE+Gaussian%E5%88%9B%E5%BB%BA%E5%B0%8F%E5%88%86%E5%AD%90GAFF%E5%8A%9B%E5%9C%BA%E7%9A%84%E6%8B%93%E6%89%91%E6%96%87%E4%BB%B6/)  

### 前言

***先看上面的参考资料，下面的介绍仅为参考资料的补充。***    

pdb2gmx在生成拓扑结构时按照以下顺序：r2b->hdb->rtp->tdb  
aminoacids.c.tdb和aminoacids.n.tdb是对端基的处理，在amber力场中均为空。（大概因此amber力场无-ter）  

下面以amber99sb-ildn力场为例介绍端基残基的生成：  
实现自定义氨基酸残基要处理的文件主要有4个：  
1. top/residuetypes.dat  
1. top/amber99sb-ildn_m.ff/aminoacids.r2b  
1. top/amber99sb-ildn_m.ff/xxx.hdb  
1. top/amber99sb-ildn_m.ff/xxx.rtp  

xxx为自定义残基的名字，为了不污染原有的aminoacids.hdb和aminoacids.rtp而将其独立出来。  

### 步骤
###### 生成top文件
1. 片段结构的获取：若为端基残基，则用另一中性氨基酸配成酰胺键后用H将外加氨基酸的C端加氢（或N端减氢），实现中性化封端。若为中间氨基酸，则两端用其它氨基酸分别配成酰胺键后用H将外加氨基酸C端加氢（或N端减氢），实现中性化封端。
1. 生成mol2文件，现发现VMD生成的mol2文件不能用，gaussian view生成的可以。
1. 利用acpype生成含有自定义残基的片段结构的拓扑文件，生成的同时确定好带电情况，因为两端均做中性化，所以带电量为自定义残基带电量。检查生成的gro文件结构合理性。acpype要用sf版，sf版中二面角默认类型为9或4，可通过-z改变；github版中为3或1。（见参考3）
###### xxx.rtp文件的生成
1. 拓扑文件中只保留下列部分的内容后另存为rtp格式: [ atoms ], [ bonds ], [ angles ], [ dihedrals ] ; propers, [ dihedrals ] ; impropers。  
1. 调整电荷。如果采用AM1-BCC电荷, 简单的处理方法是将相邻残基的净电荷加到相应的连接原子上。RESP电荷看参考资料。  
1. acpype生成的拓扑文件的原子类型均为小写，将其改为大写，其中**C3**改写为**CT**，**HN**改写为**H**。
1. 效仿自带库中的氨基酸修改原子名称，可参考[氨基酸在PDB文件中的原子命名规则](http://blog.sciencenet.cn/blog-3387981-1118283.html)  
1. rtp文件主要内容如下，其中XXX为自定义残基名，处理方式见参考资料，文件内容样式可参考力场自带的aminoacids.rtp但内容比其要多。

```
[ bondedtypes ]
;
   1  1  9  4  1  3  1  0
[ XXX ]
[ atoms ]
...
[ bonds ]
...
[ angles ]
...
[ dihedrals ] ; propers
...
[ impropers ]
...
```


###### xxx.hdb文件的生成
参照参考资料和力场自带的aminoacids.hdb的内容自行编写，原子名称一定要与前面写的xxx.rtp文件一致。**注意：如果一个原子上要加多个H时会按照xxx.hdb里的H原子名+序号的顺序生成，比如要加3个名为“HA”的氢原子，则会在位点生成名为“HA1”“HA2”“HA3”的3个H原子，如果这3个原子名称在xxx.rtp文件中没有定义则会报错，所以一定要在xxx.rtp中做好相应的定义。**  

###### 生成文件的放置位置
将生成的xxx.rtp和xxx.hdb添加到自定义力场top/amber99sb-ildn_m.ff/中，在top/residuetypes.dat中添加自定义残基的名称。

###### 检查
找一个包含自定义残基的pdb文件并将其中的自定义残基名与xxx.rtp调成一致。  
用 `gmx pdb2gmx -f xxx.pdb -ignh` 检查能否正常运行。  

### Q&A
1. 之前试过用gaussian view画出来的pdb结构跑不通（会包其他残基的错误）但从网上下载的pdb可以跑通，还不清楚原因。
1. Warning:"Residue 1 named MET of a molecule in the input file was mapped to an entry in the topology database, but the atom H used in an interaction of type angle in that entry is not found in the input file. Perhaps your atom and/or residue naming needs to be fixed."是个废话警告，参见：[链接1](https://mailman-1.sys.kth.se/pipermail/gromacs.org_gmx-users/2017-June/113727.html)或[链接2](https://www.mail-archive.com/gromacs.org_gmx-users@maillist.sys.kth.se/msg34572.html)。此情况出现，可能因为有多个同种H虽在[atom]里做了区分但在后面的[bond][angle]等里未区分，将其区别表示后即可解决，不解决也可能得到正确结果，因为参数一样。
1. WARNING: "Duplicate line found in or between hackblock and rtp entries." 说明rtp有问题，比如没有设定键长和力常数。参考[链接](https://www.mail-archive.com/gromacs.org_gmx-users@maillist.sys.kth.se/msg20274.html)



### 附录
自己写过的几个自定义残基：  
[中性的C端LEU:clec.rtp](https://github.com/molakirlee/Blog_Attachment_A/blob/main//gmx/custom_residues/clec.rtp)
[中性的C端LEU:clec.hdb](https://github.com/molakirlee/Blog_Attachment_A/blob/main//gmx/custom_residues/clec.hdb)  
[中性的N端VAL:nvan.rtp](https://github.com/molakirlee/Blog_Attachment_A/blob/main//gmx/custom_residues/nvan.rtp)
[中性的N端VAL:nvan.hdb](https://github.com/molakirlee/Blog_Attachment_A/blob/main//gmx/custom_residues/nvan.hdb)  

[中性的C端LYN:clyn.rtp](https://github.com/molakirlee/Blog_Attachment_A/blob/main//gmx/custom_residues/clyn.rtp)
[中性的C端LYN:clyn.hdb](https://github.com/molakirlee/Blog_Attachment_A/blob/main//gmx/custom_residues/clyn.hdb)  
[中性的N端PHE:nphn.rtp](https://github.com/molakirlee/Blog_Attachment_A/blob/main//gmx/custom_residues/nphn.rtp)
[中性的N端PHE:nphn.hdb](https://github.com/molakirlee/Blog_Attachment_A/blob/main//gmx/custom_residues/nphn.hdb)  

![](/img/wc-tail.GIF)
