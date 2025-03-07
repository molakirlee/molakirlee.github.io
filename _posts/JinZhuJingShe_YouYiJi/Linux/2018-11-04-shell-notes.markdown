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
    - Linux
    - 2018


---

### bash内实现交互界面
如gmx添加离子过程中实现离子替换水分子的过程  
```
gmx genion -s ions.tpr -o water-ion_box.gro -p topol.top -nn 200 -nname CL -np 200 -pname NA<<EOF
2
EOF
```

### 交互
传参等见参考资料：《Shell脚本之处理用户输入》

### 批处理
###### shell脚本文件夹内文件依次执行
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

###### shell脚本文件夹内文件依次执行2

```
#!/bin/bash

for dir in `ls`; do

	if [ -d ${dir} ];then
		cd $dir
		###################################################################
			echo 'hello world' > test.txt      #运行指令放到这里
        ###################################################################
			echo ${dir} completed 
		cd ..
	fi
	
done
```

###### Minglun's jobs submition of gromacs
```
#!/bin/bash
echo "Let us begin simulation!"

#build box
gmx solvate -cs spc216.gro -o water_box.gro -box 6.0 7.5 6.8 -p topol.top

#add ion
gmx grompp -f ions.mdp -c water_box.gro -p topol.top -o ions.tpr

gmx genion -s ions.tpr -o water-ion_box.gro -p topol.top -nn 200 -nname CL -np 200 -pname NA<<EOF
2
EOF

#Energy minimization
gmx grompp -f minim.mdp -c water-ion_box.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em


gmx energy -f em.edr -o potential.xvg<<EOF
4 0
EOF

#nvt
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
gmx mdrun -deffnm nvt

gmx energy -f nvt.edr -o temperature.xvg<<EOF
9 0
EOF

#npt
gmx grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
gmx mdrun -deffnm npt

gmx energy -f npt.edr -o density.xvg<<EOF
16 0
EOF

#run MD
gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr
gmx mdrun -deffnm md_0_1

#analysis Hbond
gmx hbond -f md_0_1.xtc -s md_0_1.tpr -num md_0_1_Hbond.xvg<<EOF
1 1
EOF

#analysis Radial distribution function
gmx rdf -f md_0_1.xtc -s md_0_1.tpr -o rdf_ion_NA.xvg -ref NA -sel SOL
gmx rdf -f md_0_1.xtc -s md_0_1.tpr -o rdf_ion_CL.xvg -ref CL -sel SOL

```

###### Supernova's jobs submition of gromacs

```
#!/bin/bash

for pep in *.pdb
do
	#prepare structure
	gmx pdb2gmx -f $pep -p $pep"-topol.top" -o $pep".gro" -water tip3p -ff charmm36m -ignh
	gmx editconf -f $pep".gro" -d 1 -o $pep"_box.gro"
	gmx solvate -cp $pep"_box.gro" -p $pep"-topol.top" -o $pep"_sol.gro"
	gmx grompp -f em.mdp -c $pep"_sol.gro" -p $pep"-topol.top" -o $pep"_em" -maxwarn 1
	echo 13 | gmx genion -s $pep"_em.tpr" -p $pep"-topol.top" -o $pep"_sol.gro" -neutral -conc 0.15
	#run simulation
	gmx grompp -f em.mdp -c $pep"_sol.gro" -p $pep"-topol.top" -o $pep"_em"
	gmx mdrun -v -deffnm $pep"_em"
	gmx grompp -f md.mdp -c $pep"_em.gro" -p $pep"-topol.top" -o $pep"_md.tpr" -maxwarn 2
	gmx mdrun -v -deffnm $pep"_md"
done

exit
```


### 相关阅读：  
[Linux常用命令](https://mp.weixin.qq.com/s?__biz=MzU5OTMyODAyNg==&mid=2247484700&idx=1&sn=10cacf3afd4781989ca30a5ff0a4fc50&chksm=feb7d169c9c0587f0778e7f7bd4266661a10da32d1b335328362d37589b79643d6fbef8a7282&mpshare=1&scene=24&srcid=0424EZoT5RnWFtL6ZjGTcHvV#rd)
1. [Shell脚本之处理用户输入](https://shixiangwang.github.io/home/cn/post/2017-08-19-working-with-user-input/)

![](/img/wc-tail.GIF)