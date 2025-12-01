---
layout:     post
title:      "gmx Martini粗粒化反映射全原子"
subtitle:   ""
date:       2021-01-22 22:28:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2021


---

### 参考资料
1. [Martini粗粒化体系到全原子体系的反向映射](https://zhuanlan.zhihu.com/p/340091675)
1. [Martini自定义分子到全原子的反向映射](https://zhuanlan.zhihu.com/p/340504696)
1. [Martini自定义残基到全原子的反向映射](https://zhuanlan.zhihu.com/p/340945967	)

###### CG2AT
1. [Backmapping systems with CG2AT](https://cgmartini.nl/docs/tutorials/Martini3/cg2at/)

1. 可以从[Github库](https://github.com/pstansfeld/cg2at)直接下载；或`conda install -c stansfeld_rg cg2at`后将其添加路径`export PATH="path_to_CG2AT2:$PATH"`
1. 测试例教程见[官网](https://cgmartini.nl/docs/tutorials/Martini3/cg2at/)，所需文件可点击[这里](https://cgmartini-library.s3.ca-central-1.amazonaws.com/0_Tutorials/m3_tutorials/cg2at/tutorial_files.tar.gz)下载
```
tar -xzf tutorial_files.tar.gz
cd tutorial_files
cg2at -c dynamic.gro -a kalp-AA.pdb -ff charmm36-jul2020-updated -fg martini_3-0_charmm36 -w tip3p
```
1. 系统会开展以下流程,If the programme fails, in each folder (and any sub-folders) the gromacs-outputs file will record if there are any warnings/errors.比如你的gmx不是并行版可能会报错，把代码中的-ntmp改掉
- Initialisation
- Read in CG system
- Build protein systems
- Build non-protein system
- Merge and minimise de novo
- NVT on de novo
- Creating aligned system

1. 待解决问题：win系统提示 “You have selected the forcefield: charmm36-jul2020-updated You have selected the fragment library: martini_3-0_charmm36 Cannot find fragments for:  other You have selected the water model: TIP3P Cannot find fragment: ARG/ARG.pdb”，而linux运行不会有该问题。


###### Backward
1. linux系统下成功，win系统下的anaconda中会有路径问题，相关文件太多xilock暂未解决.
1. [Reverse coarse-graining with Backward](https://cgmartini.nl/docs/tutorials/Martini3/Backward/)
1. [Martini粗粒化体系到全原子体系的反向映射](https://zhuanlan.zhihu.com/p/340091675)






###### CG2AT vs. Backward

| 维度 | CG2AT（CG2AT2） | Backward |
|------|----------------|----------|
| **核心原理** | 基于**片段（fragment）**的几何匹配与能量最小化。先将预先准备好的原子片段对齐到对应的粗粒化（CG）珠子上，再进行简短的 NVT 平衡和/或受控的 steered MD，以恢复原子间的几何关系[[1]]。 | 采用**几何投影**的方式：把原子放置在对应 CG 珠子的加权平均位置上，随后通过手工编写的映射文件对特定原子进行位置微调，最后进行能量最小化和短时 MD 进行松弛[[2]]。 |
| **实现方式** | - 片段库（fragment database）由实验或高分辨率模拟提供。<br>- 自动对齐 + 逐片段能量最小化。<br>- 可选 **steered MD** 将结构“拉回”到参考原子结构。 | - 纯几何规则：原子坐标 = CG 珠子坐标的线性组合。<br>- 需要 **.map** 文件描述每个 CG 珠子对应的原子集合。<br>- 通过 **initram.sh** 生成临时文件，随后执行 **backward.py** 完成投影与松弛[[3]]。 |
| **对立体化学（手性、顺反）处理** | 片段库中已包含正确的手性信息，映射时直接使用对应的片段，避免翻转或手性错误[[4]]。 | 依赖映射文件手动指定原子顺序，若映射不完整或不当，容易出现 **翻转（flipped）或手性错误**，文献中多次报告此类问题[[5]]。 |
| **输入要求** | - CG 结构（Martini 等）。<br>- 可选 **-d**（复制链）和 **-vs**（虚拟位点）等标志。<br>- 片段库（随软件提供）和映射文件（自动生成或手动编辑）。 | - CG 结构（Martini 2/3）。<br>- 完整的 **.map** 文件（需用户自行编写或从模板修改）。<br>- 可选的 **initram.sh** 脚本参数。 |
| **后处理步骤** | 1️) 初始片段对齐<br>2️) 能量最小化（EM）<br>3️) 短时 NVT（≈10 ps）<br>4️) 如需更高精度，可执行 **steered MD**（可选）[[6]]。 | 1️) 几何投影<br>2️) 初始随机 “kick” 以避免原子重叠<br>3️) 两轮能量最小化（EM1、EM2）<br>4️) 短时 NVT/ NPT 松弛（通常 10–20 ps）[[7]]。 |
| **计算效率** | 片段匹配后只需少量 EM 与短 NVT，**线性随原子数增长**，在大系统（> 800 k 原子）仍保持约 **2–3 倍** 的速度优势[[8]]。 | 由于几何投影后原子重叠较多，第二轮 EM 常出现 **并行受限**，在同等规模系统上运行时间约为 CG2AT 的 **2–3 倍**，且在极大系统（≈ 800 k 原子）会出现异常长的计算时间[[9]]。 |
| **成功率 / 稳定性** | 在文献测试中 **≈ 98 %** 的成功率（仅少数因映射文件错误而失败），且大多数系统在第一次运行即可得到合理结构[[10]]。 | 成功率约 **60 %**（文献中 37/60 成功），常因第二轮 EM 期间出现 **原子冲突导致崩溃**，需要手动调参或重新运行[[11]]。 |
| **适用场景** | - 需要 **高保真手性**、**复杂分子**（蛋白质、脂质、配体） 的多尺度模拟。<br>- 对 **速度** 与 **成功率** 有较高要求的高通量工作流。 | - 对 **快速原型** 或 **小型系统**（单膜、少量蛋白） 的快速回转需求。<br>- 已有成熟的 **.map** 文件库，且对手性要求不严格的场景。 |
| **主要优缺点** | **优点**：片段库保证手性/立体化学；运行快、成功率高；可选 steered MD 提升精度。<br>**缺点**：需要维护片段库，初始学习曲线略高。 | **优点**：实现简单、依赖少（仅映射文件），适合快速实验。<br>**缺点**：手性易出错、运行慢、成功率低，尤其在大系统上更易崩溃。 |


- **如果项目强调原子级手性准确性、对大体系有需求且希望流程尽可能稳健**，推荐使用 **CG2AT（CG2AT2）**。其片段化方法在保持立体化学的同时，提供了更快的计算速度和更高的成功率[[12]]。
- **如果仅需对小规模系统进行快速原型验证，且已有完整的 `.map` 文件**，则 **Backward** 仍是一个轻量级的可行选择，但需注意可能出现的翻转或崩溃问题[[13]]。

在实际工作流中，常见的做法是先用 **Backward** 进行快速测试，确认系统可行后再切换到 **CG2AT** 进行正式的高精度回映射，以兼顾效率与可靠性。



![](/img/wc-tail.GIF)
