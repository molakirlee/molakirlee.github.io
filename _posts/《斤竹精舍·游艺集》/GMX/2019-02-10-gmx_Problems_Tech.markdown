---
layout:     post
title:      "Gromacs问题与小知识"
subtitle:   ""
date:       2019-02-10 20:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2019

---

Google找不到可以在这个mail box里找一下，里面有很多相关的提问和回答：[mail-archive](https://www.mail-archive.com/)


### 遇到过的问题
#### ... no domain decomposition for 20 ranks...
```
Fatal error:
There is no domain decomposition for 20 ranks that is compatible with the given box and a minimum cell size of 0.929375 nm  
Change the number of ranks or mdrun option -rcon or -dds or your LINCS settings  
Look in the log file for details on the domain decomposition  
For more information and tips for troubleshooting, please check the GROMACS website at http://www.gromacs.org/Documentation/Errors  
```

Solution:
Use following command line: `gmx mdrun -v -deffnm em -nt 8`  
I used the option "-nt 1" to make it work. Sometimes the simulation is too small to be divided.  
sob老师说是因为原子数较少所致的域分解错误，可以用-ntmpi 1解决。

参见[Gromacs Errors](http://www.gromacs.org/Documentation/Errors#There_is_no_domain_decomposition_for_n_nodes_that_is_compatible_with_the_given_box_and_a_minimum_cell_size_of_x_nm)  

#### 盐离子团聚
Q:水环境体系中K+和Cl-为什么跑完动力学以后都团聚到一块了？  
A:amber99力场描述高浓度离子不合理,当年sob老师也遇到了相同的问题(doi: 10.3866/PKU.WHXB201506191)，后来改用KBFF力场就没问题了。明显是amber力场的缺陷。  
Q:在研究盐对蛋白的影响，如果浓度不太高的话用amber99合理吗？比如生理环境中的137mM。  
A:生理环境没问题,只要看见结晶肯定不行  
更新：  
这是amber力场的缺陷，通过修改LJ参数可以进行修正，具体参数见文献：  
1. Joung I S, Cheatham III T E. Determination of alkali and halide monovalent ion parameters for use in explicitly solvated biomolecular simulations[J]. The journal of physical chemistry B, 2008, 112(30): 9020-9041.
2. Auffinger P, Cheatham T E, Vaiana A C. Spontaneous formation of KCl aggregates in biomolecular simulations: a force field issue?[J]. Journal of chemical theory and computation, 2007, 3(5): 1851-1859. （文中的rmin应为0.5rmin）
3. Joung I S, Cheatham III T E. Molecular dynamics simulations of the dynamic and energetic properties of alkali and halide ions using water-model-specific ion parameters[J]. The Journal of Physical Chemistry B, 2009, 113(40): 13279-13290. (文献1基础上考察更多参数)

#### Right hand side '1.0  1.0' for parameter 'tau_p' in parameter file is not a real value
在NPT中使用semiisotropic的时候，若将`tau_p`设置为两个参数则可能会报错。实际上，与温度耦合不同，压力耦合的`tau_p`就是一个参数（虽然`ref_p`和`compressibility`是两个参数）。  
参见mailing list: [strange behaviout in 5.1.2](https://mailman-1.sys.kth.se/pipermail/gromacs.org_gmx-users/2016-February/103459.html)  


### 技巧
#### 续算
一、意外中断的任务md1  
```
gmx mdrun -v -deffnm md1 -cpi md1.cpt
```  
二、md1已跑完，延续之前的模拟参数，再跑额外的10ns  
法1：在原来的md1.trr/xtc/log/edr/gro之外得道md2.part0002.trr/xtc/log/edr/gro  
```
gmx convert-tpr -s md1.tpr -extend 10000 -o md2.tpr  
gmx mdrun -v -deffnm md2 -cpi md1.cpt  -noappend
```
法2：直接在md1上续写内容  
```
gmx convert-tpr -s md1.tpr -extend 10000 -o md1.tpr
gmx mdrun -v -deffnm md1 -cpi md1.cpt
```

#### Gromacs中pH值设定  
It is not possible to define pH in an MD system as there are no hydronium ions floating around (you can't plausibly model that) and protons can't be exchanged in classical MD, anyway.  
 You set a dominant protonation state representative of a given pH using options in pdb2gmx to alter the protonation state of titratable residues based on their individual pKa values.  
参考：[How to set the pH in Gromacs?](https://www.researchgate.net/post/How_to_set_the_pH_in_Gromacs)

#### pdb2gmx中的-chainsep和-merge的区别  
在处理二硫键时，若两个S原子分别在两条链上，则需要将两条链进行合并，否则二硫键不会成键。（因为gromacs不能处理成/断键，所以若想保证成键必须是一个分子）  
在pdb2gmx时，若想合并两/多条链则可以用-chainsep或-merge，但两者不同。  
1. 使用-chainsep合并两条链时两条链之间会形成肽键，所以有时会出现原子类型OTX（C端O）不识别的情况，若参照“aminoacids.arn”将OTX改成OC1则可运行，但合成出来的两条链分别脱O（因为C端已经去质子化，所以不是OH而是O）、H（N端），以肽键相连。  
1. 使用-merge合并时，只是将两条链合并到一个[moleculartype]中，不会强迫两条链以肽键链接。  

如对pH=2时的胰岛素的处理，胰岛素同时具有A、B两条链且链间用二硫键连接：  
```
gmx pdb2gmx -f 5miz.pdb -ignh -o insulin.gro -p insulin.top -glu -ss -merge all -ter
```

#### 盐桥计算
用gromacs的盐桥计算基本算不动，所以Xilock用VMD进行盐桥计算，因为载入的gro文件识别不了链，所以会提示不unique（即便之间index文件里面有分类），转换成pdb文件并标注链后则能区分是相同链还是不同链之间形成盐桥（链标识只能是一个字符单位）。  
生成的文件包括所有存在过盐桥的位置以及距离随时间的关系，为dat文件，也可以额外生成一个汇总的Log文件，但log文件里只有位点没有距离随时间的关系。  
若想得到每一时刻可能存在的盐桥数量则可以用这个[matlab脚本](https://molakirlee.github.io/attachment/gmx/Matlab_cal_salt_bridge.m)，将该脚本与所有的dat文件放在同一文件夹下运行，则脚本会自动筛选出属于同一条链的盐桥并将其距离随时间的关系拼合到同一个xls文件中。  

### 提取轨迹中某一帧  
```
gmx trjconv -f md.trr -s md.tpr -o 3000ps.gro -dump 3000
```
就可以提取最接近3000ps的那一帧  



![](/img/wc-tail.GIF)
