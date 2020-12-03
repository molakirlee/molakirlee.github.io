---
layout:     post
title:      "gmx 水分析"
subtitle:   ""
date:       2019-12-19 19:15:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2019

---

参考资料：
1. [GROMACS分析教程：使用g_select计算平均滞留时间](https://jerkwin.github.io/2016/03/11/GROMACS%E5%88%86%E6%9E%90%E6%95%99%E7%A8%8B-%E4%BD%BF%E7%94%A8g_select%E8%AE%A1%E7%AE%97%E5%B9%B3%E5%9D%87%E6%BB%9E%E7%95%99%E6%97%B6%E9%97%B4/)  
1. 

###### 氢键分析

`gmx hbond -s -f -num -life -dist -b`

注：
1. `-num`生成氢键数
1. `-life`计算氢键寿命，能够说明氢键的稳定性，第一列（横坐标）是时间，第二列大抵是氢键能连续保持这么长时间不断掉的几率。第三列是前两列相乘。（Manual: 8.13 Hydrogen bonds）
1. `-dist`: distance distribution of all hydrogen bonds.
1. `-ang`: angle distribution of all hydrogen bonds.

###### 溶剂可及表面积(SASA, solvent accessible surface areas)

`gmx sasa -s nvt_30ns.tpr -f nvt_30ns.xtc -n -b 25000 -o -odg`  

注：
1. `-odg`: Estimated solvation free energy as a function of time.


###### 水的径向分布函数(RDF, radial distribution functions)

`gmx rdf -s nvt_30ns.tpr -f nvt_30ns.xtc -n -b 25000 -seltype whole_res_cog`  

注：
1. `-seltype` 用于指定**对每个选区要计算的**默认位置类型；`-selrpos` 用于指定**按坐标选择原子时**使用的默认位置类型。我们不是用坐标而是直接选择，所以用`-seltype`。
1. `-seltype` 和`-selrpos`的可选设定为“atom（默认）, res_com, res_cog, mol_com, mol_cog, whole_res_com, whole_res_cog, whole_mol_com, whole_mol_cog, part_res_com, part_res_cog, part_mol_com, part_mol_cog, dyn_res_com, dyn_res_cog, dyn_mol_com, dyn_mol_cog”，其中：com和cog分别指center of mass/geometry；res和mol分别指residue和molecule；whole指即原子便不在所选组中但只要在相同res或mol中也会被用来计算com/cog，part表示只选择所选组中的包含所选组所在res或mol部分的原子用来计算com/cog。如：示例命令执行前的ndx中有一个组只选择了体系中所有lysine的侧链N（命名为NZ），part_res_com会使得选择过程中若以NZ为参考则**以residue为单位选中属于每个lysine残基**且**在所选组NZ中的原子**计算每个lysine residue的**质心**；whole_res_com会**以residue为单位选中每个lysine残基**的**所有原子**计算每个lysine residue的**质心**，**无论该原子是否在所选组中（只要在所选组中原子所在的res中即会被选中）**。[select命令参考资料](http://jerkwin.github.io/GMX/GMXsel/)
1. 上一条的原文：The specified positions for the atoms in ATOM_EXPR. POSTYPE can be atom, res_com, res_cog, mol_com or mol_cog, with an optional prefix whole_ part_ or dyn_. whole_ calculates the centers for the whole residue/molecule, even if only part of it is selected. part_ prefix calculates the centers for the selected atoms, but uses always the same atoms for the same residue/molecule. The used atoms are determined from the the largest group allowed by the selection. dyn_ calculates the centers strictly only for the selected atoms. If no prefix is specified, whole selections default to part_ and other places default to whole_. The latter is often desirable to select the same molecules in different tools, while the first is a compromise between speed (dyn_ positions can be slower to evaluate than part_) and intuitive behavior.[Manual](http://manual.gromacs.org/documentation/5.1/onlinehelp/selections.html)
1. 若分子太大不要以atom或mol为单位，以所关心的res为单位以避免奇怪的结果，如：只有第一水合层正确，之后g(r)越来越大（这是因为以molecular的质心或者atom的质心为中心计算时距离越大体系越复杂，难以准确描述）。

###### 第一溶剂化层水分子滞留时间分布

用RDF计算出第一溶剂化层以后，得到第一个波峰的位置的横坐标用以计算第一溶剂化层水分子滞留时间分布。  
如果想把第一水合层内水分子的平均滞留时间与氢键寿命作比较，则将OW原子的原子序号提取到excel里“去重复和排序”，然后做+1和+2处理得到两个氢的原子序号，然后再将其处理成ndx文件用以计算其与Protein等的氢键寿命，因为有些氢键在某些帧内不在第一水合层中，所以所得的氢键平均寿命会大于水分子的平均滞留时间。

```
gmx select -s nvt_30ns.tpr -f nvt_30ns.xtc -n index.ndx -os -oc -oi -om -on selFrm.ndx -selrpos whole_res_com  -b 25000  
>"1st shell" resname SOL and name OW and within 0.35 of group 46
```

注：  
1. 上述指令中group 46为lysine的侧链N，故会计算所有lysine质心0.35 nm范围内（第一溶剂化层）水的存在情况，mask.xvg文件为重点。
1. size.xvg: 每一时刻第一溶剂化层中原子的个数。
1. cfrac.xvg: 每一时刻第一溶剂化层中原子的覆盖比例。
1. index.dat: 每一时刻第一溶剂化层中原子的个数及其编号。
1. mask.xvg: 每一时刻分子是否处于第一溶剂化层中的掩码, 0: 不处于, 1:处于。
1. selFrm.ndx: 每一时刻第一溶剂化层中原子的索引组。

使用Jerkwin老师的脚本处理mask.xvg数据可得到第一溶剂化层内水分子的滞留时间分布及平均滞留时间（注意：调用脚本前删掉@开头的部分）：

```
file=mask.xvg
ftrs=${file%.*}_trs.dat
ffrq=${file%.*}_frq.dat

awk ' BEGIN {
	getline
	while($1=="#") getline
	Ncol=NF
	close(FILENAME)

	for(i=2; i<=Ncol; i++) {
		while(getline<FILENAME) if(NF==Ncol) printf "%s", $i
		print ""
		close(FILENAME)
	}
}' $file > $ftrs

awk -v file=$file '
BEGIN{ Navg=0; Tavg=0
	getline <file
	while($1=="#") getline <file; dt=$1
	getline <file; dt=$1-dt
	close(file)
}

{	gsub(/0+/, " ")
	Ntxt=split($0, txt)
	for(i=1; i<=Ntxt; i++) {
		T=length(txt[i])
		print T
		Navg++; Tavg += T
	}
}
END{ print "# Avaraged Residence Time(ps)=", Tavg*dt/Navg}
' $ftrs >$ffrq
```


###### 水的密度分布

`gmx density`

###### 水的自扩散系数

`gmx msd`用于计算选择组的“均方位移”和“自扩散系数”

`gmx msd`



![](/img/wc-tail.GIF)
