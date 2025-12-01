---
layout:     post
title:      "gmx Martini力场粗粒化-DNA/RNA模拟"
subtitle:   ""
date:       2020-05-06 09:57:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2020


---

###### Martini 3

1. [官网](https://cgmartini.nl/docs/downloads/force-field-parameters/martini3/nucleic_acids.html)
1. 截止20251122还只有DNA/RNA的**5种碱基小分子**的力场，没有完整的DNA/RNA力场，仍在开发中，所以更没有粗粒化转化用的东西，等吧(Note: An optimized version of the Martini 3 parameters for nucleic acids is currently under development. Please check back soon for updates.)
1. [过期示例：DNA (The material offered in this page is LEGACY material. )](https://cgmartini.nl/docs/tutorials/Legacy/martini2/dna.html)

###### RNA:reForge
1. [Github库](https://github.com/DanYev/reForge)
1. 可以处理适用于Martini3力场的RNA，但处理不了DNA

###### Martini 2
1. 从[Martini官网： Nucleic Acids](https://cgmartini.nl/docs/downloads/force-field-parameters/martini2/nucleic_acids.html)下载martini-dna-150909.tar，里面包括粗粒化转换用的`martinize-dna.py`以及各种相关力场


3条注意事项及相关指令：
1. 虽然官方推荐gro格式（Martinize-dna.py works better with GRO files so convert your PDB files using editconf or another program. ），但xilock实测自定义的大体系gro生成的会缺原子，所以建议检查是要用pdb还是gro
1. 与蛋白一样，粗粒化之前要清洗pdb文件，如去除杂原子等
1. top中，`#define RUBBER_BANDS`放在`DNA.itp`上面时，该约束一直起效果，放在其下面时，需要在mdp中`define = -DRUBBER_BANDS`
1. 生成的拓扑链数不对时检查`CUT-OFF_CHANGE`
1. In your .top file the `#define RUBBER_BANDS` has to be set before you include an itp file with elastic network in order for that EN to be active.
1. There are four separate topology types that martinize-dna.py can create. For simulating single-stranded DNA there are parameters without elastic network. For double-straned DNA there is a weakly restrained model that allows more realistic bending of DNA but still has known issues with the alignment of bases and stability when used with a longer time step. A very stiff elastic network model is offered as an alternative solution for systems where DNA structure is not expected to change. For structures formed out of single strand but with a well defined structure also a stiff elastic network is offered to prevent the structure from changing. There is also an option to restrain several strands using the same elastic network which can be used as basis for elastic networks of more complicated DNA structures. 

1 - ssDNA parameters
`python martinize-dna.py -dnatype ss -f [input.gro] -o [topology.top] -x [cg-structure.pdb]`

2 - dsDNA parameters with soft elastic network
`python martinize-dna.py -dnatype ds-soft -f [input.gro] -o [topology.top] -x [cg-structure.pdb]`

3 - dsDNA parameters with stiff elastic network
`python martinize-dna.py -dnatype ds-stiff -f [input.gro] -o [topology.top] -x [cg-structure.pdb]`

4 - ssDNA parameters with stiff elastic network
`python martinize-dna.py -dnatype ss-stiff -f [input.gro] -o [topology.top] -x [cg-structure.pdb]`

5 - General DNA parameters with soft elastic network
`python martinize-dna.py -dnatype all-soft -f [input.gro] -o [topology.top] -x [cg-structure.pdb]`

6 - General DNA parameters with stiff elastic network
`python martinize-dna.py -dnatype all-stiff -f [input.gro] -o [topology.top] -x [cg-structure.pdb]`


![](/img/wc-tail.GIF)
