---
layout:     post
title:      "LAMMPS 建模"
subtitle:   ""
date:       2025-07-18 21:52:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2025

---

### 前言
采用`fix bond/react`指令可以实现聚合物交联等反应过程，视频资料可参考 [LAMMPS+VMD+Python：聚合物“交联”+石墨稀表面接枝，拉伸力学性能、聚合物链取向](https://www.bilibili.com/video/BV1uPpMeXE5t?spm_id_from=333.788.videopod.sections&vd_source=42d15d5f7bb7814555b23126c5a774fb)，资料见[LAMMPS公开课第三期链接(提取码: pd5r)](https://pan.baidu.com/s/19tAY68mh8zc-ZSX03DFGQA?pwd=pd5r)

工作流见[《REACTER: Suggested Workflow》](https://www.reacter.org/tutorial)，[Gallery](https://www.reacter.org/gallery)里有一些case的视频资料，有些文章可以看看：
1. [On the Network Topology of Cross-Linked Acrylate Photopolymers: A Molecular Dynamics Case Study](https://pubs.acs.org/doi/10.1021/acs.jpcb.0c05319)
1. [Construction of polydisperse polymer model and investigation of heat conduction: A molecular dynamics study of linear and branched polyethylenimine](https://www.sciencedirect.com/science/article/pii/S003238611930727X?via%3Dihub)

### [Molydyn](https://github.com/molakirlee/lammps_AutoMapper)
[AutoMapper: A Tool for Accelerating the Fix Bond/React Workflow](https://www.lammps.org/workshops/Aug21/lightning/matthew-bone/)是作者的介绍，
示例文件见[Example_Workflow](https://github.com/molakirlee/lammps_AutoMapper/tree/main/Example_Workflow)，相关论文见[《A Novel Approach to Atomistic Molecular Dynamics Simulation of Phenolic Resins Using Symthons》](https://www.mdpi.com/2073-4360/12/4/926)。更多例子可去repository的Test_Cases文件夹里找

###### Clean the data files and system.in.settings coefficient file
为了保持pre-reaction和post-reaction的各种“类型”（原子类型、成键类型、键角类型等）一致，原始的data文件中可能有冗余的信息（在生成原始data文件环节，可以将反应前后的分子放在同一个文件中，然后采用MS等生成data文件，在采用ovito分别选择和导出，拆成2个data文件，这样能保证反应前后的各种“类型”一致），该步骤主要是删去不相关信息以提高计算效率。
```
AutoMapper.py . clean pre_reaction.data post_reaction.data --coeff_file system.in.settings
```

因为AutoMapper.py在调用coeff_file时要求里面写明原子两两之间的相互作用情况，但有些时候生成的相互作用参数并非折算成二元交互而是直接给出每个原子/成键/键角类型的（如MS class II生成到data文件中的相互作用参数），因此在clean这步的时候可以先用示例中的system.in.settings ，最后run之前在data文件中替换修改过来即可。

###### Create the map and molecule files

```
AutoMapper.py . map cleanedpre_reaction.data cleanedpost_reaction.data --save_name pre-molecule.data post-molecule.data --ba 4 19 4 19 --da 13 10 25 29 10 30 --ebt H H C C O O
```

1. *注意这里的cleanedpre_reaction.data和cleanedpost_reaction.data两个文件必须是未成键的在前,成键的在后，(The order of files for the map should always be "pre-bond post-bond")，否则会报错，可以生成molecule和map文件后把两个顺序自己调整过来就行了*

###### 运行计算
```
lmp -in run.bond
```
在结果log文件中的`Step f_fxrct[1] `处可以看到成键情况（因为写了`thermo_style custom step f_fxrct[1]`）

### 其它
1. 采用bond/react的时候，只能做“一类”化学键的成/断，因为只能输入两个数，`The first mandatory section begins with the keyword “InitiatorIDs” and lists the two atom IDs of the initiator atom pair in the pre-reacted molecule template. `。注意是“一类”而非“一个”，关键看map和molecule文件的编写。如果是不同类的话只能采用multi-step来分别做了（像lammps的PACKAGE/reaction文件夹里的示例）


参考资料
1. [fix bond/react command](https://docs.lammps.org/fix_bond_react.html)


![](/img/wc-tail.GIF)
