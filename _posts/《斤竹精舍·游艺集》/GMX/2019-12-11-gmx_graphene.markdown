---
layout:     post
title:      "gmx 石墨烯建模"
subtitle:   ""
date:       2019-12-11 20:38:00
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
1. [使用Gromacs模拟碳纳米管的一个简单例子](http://sobereva.com/268)
1. [Gromacs Carbon Nanotube](http://www.gromacs.org/Documentation/How-tos/Carbon_Nanotube)

### 无限延展的石墨烯

1. VMD建模。Extension --> Modelling --> Nanotube builder，构建两个方向皆为8 nm的石墨烯，保存为GRA.gro文件。
1. 设定盒子，在原有最大尺寸的基础上，x方向加2.456 A，y方向加1.418 A。这是因为在石墨烯六边形中，横向两个点间距离为2.456 A，纵向两个点间距离为1.418 A。
1. 用VMD进行周期性显示，测量边界处成键距离和六边形点间距以确保盒子大小合适。
1. 在力场文件夹中添加用于生成拓扑的“atomname2type.n2t”文件，内容参见上述参考资料。
1. 用`gmx x2top -f GRA.gro -o GRA.top -ff select -name GRA -kb 400000 -kt 600 -kp 150`生成拓扑文件GRA.top，参数解释见参考资料。（GMX内置的力场没有专门给碳球、管、板用的成键参数，但这些参数并不需要很准确，用x2top默认的参数即可。）（不建议用acpypr和ATB，此二者适用于小分子）
1. 检查GRA.top文件中边界原子是否有成键，若无误，删除多余内容（[moleculetype]之前的内容以及最后面的[system]和[molecule]）后改为itp文件。
1. 生成或建立体系的topol.top文件。
1. LJ参数：Hummer, G., Rasaiah, J. & Noworyta, J. Water conduction through the hydrophobic channel of a carbon nanotube. Nature 414, 188–190 (2001) doi:10.1038/35102535
1. mdp中需添加`periodic_molecules = yes `以保证体系中的“跨盒子与自身成键的分子”正确判断跨越盒子边界的键。
1. 若freeze石墨烯则用NVT，若允许石墨烯运动则用NPT。


![](/img/wc-tail.GIF)
