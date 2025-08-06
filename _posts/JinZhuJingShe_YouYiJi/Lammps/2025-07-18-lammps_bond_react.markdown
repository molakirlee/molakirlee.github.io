---
layout:     post
title:      "LAMMPS 交联fix bond/react"
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

开发者的PPT: [REACTER 2.0: Advanced Reaction Constraints and Automated Interaction Typing REACTER 2.0: Advanced Reaction Constraints and Automated Interaction Typin](https://download.lammps.org/workshops/Aug21/day3/jacob-gissinger.pdf)


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

1. **注意这里的cleanedpre_reaction.data和cleanedpost_reaction.data两个文件必须是未成键的在前,成键的在后，(The order of files for the map should always be "pre-bond post-bond")，否则会报错，可以生成molecule和map文件后把两个顺序自己调整过来就行了**

###### 运行计算
```
lmp -in run.bond
```
因为在in文件中有`thermo_style custom step f_fxrct[*]`，所以在结果log文件中的` Step  f_fxrct[1]  f_fxrct[2] ……  `处可以看到成键情况。

### 其它
1. 采用bond/react的时候，只能做“一类”化学键的成/断，因为只能输入两个数，`The first mandatory section begins with the keyword “InitiatorIDs” and lists the two atom IDs of the initiator atom pair in the pre-reacted molecule template. `。注意是“一类”而非“一个”，关键看map和molecule文件的编写。如果是不同类的话只能采用multi-step来分别做了（像lammps的PACKAGE/reaction文件夹里的示例）


### xilock示例
1. [示例文件](https://github.com/molakirlee/Blog_Attachment_A/blob/main/lammps/AutoMapper_xilockCase_reverse.rar)
1. 在MS中将成键分子的结构画出来，然后将该分子在同一个文件中复制后改成断键的结构，一同导出成data文件。
1. 在ovito中只保留断键前、断键后的分子结构，分别导出成bonded.data和unbond_r1.data。
1. bonded.data、unbond_r1.data和system.in.settings文件放到automapper.py所在文件夹下，system.in.settings必须给二元交互的而非每个原子/成键/键角类型，如果没有可以先用示例中的，最后run之前在data文件中修改过来即可。
1. `python AutoMapper.py . clean bonded.data unbond_r1.data --coeff_file system.in.settings` #  clean的时候可以先用system.in.settings ，最后run之前在data文件中修改过来即可
1. `python AutoMapper.py . map cleanedunbond_r1.data cleanedbonded.data --save_name post-molecule.data pre-molecule.data --ba 749 500 362 113 --ebt C C O O N C C C C O N O H H H S S H` # 因为输入文件时要让未成键的在前，成键的在后，但生成新文件时将文件名改了过来；`--ba`是未成键/成键状态下对应原子序号；`--ebt`是元素名称
1. 修改IN文件后运行，与普通NVT相比添加的如下：

```
# ========= Reaction protocol =========
# --------- 反应前后原子类型 ---------
molecule      unreact      ${Dir_molecule}/${NM_unreact_mol}   # unreact molecular
molecule      reacted      ${Dir_molecule}/${NM_reacted_mol}   # reacted molecular
# --------- 反应成/断键情况 ---------
# statted_grp is user-assigned prefix for the dynamic group of atoms not currently involved in a reaction
# The xmax value keyword (0.03) should typically be set to the maximum distance that non-reacting atoms move during the simulation.
variable P_rxn1_f equal 1       # 正反应发生的概率
variable P_rxn1_r equal 0.5     # 逆反应发生的概率
fix		fxrct all bond/react stabilization yes statted_grp .03 &
		react rxn1_f all ${react_step} 2.0  10.0  unreact reacted  ${Dir_map}/${NM_map} prob ${P_rxn1_f} stabilize_steps ${react_step} &
		react rxn1_r all ${react_step} 0.0   2.8  reacted unreact  ${Dir_map}/${NM_map} prob ${P_rxn1_r} stabilize_steps ${react_step}

# ……

fix  1 statted_grp_REACT nvt temp ${TI} ${TF} 100
fix  4 bond_react_MASTER_group temp/rescale 100 ${TI} ${TF} 10 1  # Reset the temperature of reacting atoms by explicitly rescaling their velocities.
thermo_style custom step f_fxrct[*]
```

### 使用笔记
###### WARNING: Fix bond/react: The BondingIDs section title has been deprecated. Please use InitiatorIDs instead. (src/REACTION/fix_bond_react.cpp:4033)
新版本把map文件中的`BondingIDs`改成了`InitiatorIDs`，这个警告可忽略也可手动修改。

###### Arrhenius equation
k与反应的概率直接相关（参见[Why is the rate of a reaction proportional to the concentrations of reactants raised to their stoichiometric coefficients?](https://chemistry.stackexchange.com/questions/81019/why-is-the-rate-of-a-reaction-proportional-to-the-concentrations-of-reactants-ra)），据 fix bond/react作者jrgissing在["Arrhenius equation in fix bond/react command"](https://matsci.org/t/arrhenius-equation-in-fix-bond-react-command/47329)一文中所说，为了让k能直接和概率相关，指前因子A并不是实验所得的指前因子，而是在所关心的温度范围内进行了归一化，原文如下：As far as determining A and n (n is zero for the standard Arrhenius equation), that is a system-specific question because A is determined empirically. A few pointers include that A for simulations is not quantitatively comparable to experiment. Instead, it should be used to scale the Arrhenius equation between 0 and 1 for the temperature range of interest. I highly encourage plotting this function! This constraint is typically most useful for simulations that have differences in temperature, either in space or in time. For example, it could be used to activate a polymerization reaction at a certain temperature.

###### [“bond atom missing” when using the bond/react command for a reversible reaction](https://matsci.org/t/bond-atom-missing-when-using-the-bond-react-command-for-a-reversible-reaction/50848)
The issue was with the water molecule coming off, because it was not well stabilized during the reaction. Adjusting the ‘xmax’ argument of the ‘stabilization’ keyword, or perhaps the stabilization time (‘stabilize_steps’ keyword), can generally fix this sort of issue. In this case, increasing xmax to 0.3 seems to have solved the issue. Please see attached for input file and output file.

###### 成/断键Rmin和Rmax选取
1. 成键关注最大值，断键关注最小值
1. 断键：在断键的反应过程中，选取rmin和rmax的原则依然基于断裂键的物理特性，但重点稍有不同：rmin一般设为距离略小于或接近断裂键的典型键长，防止在过于靠近时就触发断裂反应，保证键仍处于稳定状态时不反应。rmax应设为键断裂时原子最大可能分离的距离，即断裂过程中的关键临界距离，通常比平衡键长大得多。这个距离覆盖从键刚开始断裂到完全断开的范围。具体值可以参考键断裂能势图中对应临界距离，也可以根据模拟中键断裂的动态轨迹来调整。例如，如果断裂键在平衡状态下是1.5 Å的碳-碳键，rmin可以取在1.4-1.5 Å附近，rmax可能设置为2.5-3.0 Å，以覆盖键实际断裂过程中的距离范围。
1. 成键：参考化学键的典型键长和振动范围,Rmin一般设为接近或稍小于该键的典型平衡键长（bond length），以防止距离过短的不合理键反应。Rmax则应设为键断裂或形成时可能达到的最大距离，常略大于平衡键长，以覆盖键长振动和自由度范围。例如，Rmax可以是化学键典型键长的1.1~1.3倍。这种选择确保反应只发生在合理的物理距离范围内。

参考资料
1. [fix bond/react command](https://docs.lammps.org/fix_bond_react.html)


![](/img/wc-tail.GIF)
