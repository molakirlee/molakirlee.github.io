---
layout:     post
title:      "Rosseta dock"
subtitle:   ""
date:       2023-08-31 22:06:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Rosseta
    - 2023

---

### 小康教程
###### 算例及结构预处理

Rosetta给的官方教程：Protein-Protein Docking](https://new.rosettacommons.org/demos/latest/tutorials/Protein-Protein-Docking/Protein-Protein-Docking)为Colicin-D与其抑制剂IMM之间的对接，相关文件在`/demos/tutorials/Protein-Protein-Docking`。需要提供两个精炼的输入文件COL_D.pdb和IMM_D.pdb文件，以及1v74.pdb文件在input_files文件夹下，准备的方法详细可以查看输入和输出一章的[准备结构](https://www.rosettacommons.org/demos/latest/tutorials/input_and_output/input_and_output#controlling-input_common-stucture-input-files)一节。
若模型为同源建模等方法进行构建，可以首先进行一个结构的relax,当然也可以用其他软件进行制作。若您的模型为同源建模等进行的，模型评价效果不理想可以采用GROMACS等软件进行能量最小化的工作。 若模型质量佳或为解析结构，结构准备更多的是为了将输入结构转化为Rosetta的标准规范，官网给了一个简单的例子：`/demos/tutorials/input_and_output/flag_input_relax`

`$ROSETTA3/bin/relax.default.linuxgccrelease -in:file:s input_files/from_rcsb/1qys.pdb @flag_input_relax`

```
-nstruct 2

-relax:constrain_relax_to_start_coords
-relax:ramp_constraints false

-ex1
-ex2

-use_input_sc
-flip_HNQ
-no_optH false

```

说明：
1. nstruct：增大数值可以提高模型结果的质量，如nstruct 10将会获得10个模型。
1. constrain_relax_to_start_coords：约束重原子，从而使得骨架较初始不会移动太多。
1. ramp_constraints false：表示不进行倾斜约束（PS：官方文档上有说明进行整体约束该选项需要设置为false）
1. flip_HNQ：在氢键原子位置优化期间考虑翻转HIS，ASN，GLN。
1. no_optH：表示是否在PDB加载期间进行氢原子位置优化。
一般后面5个设置为基本设置

###### 局部对接
局部对接就是假设已知两个蛋白的结合（口袋）区域。首先我们需要将两个蛋白结合口袋大致的对着对方约10埃的位置。
```
-in:file:s input_files/col_complex.pdb
-in:file:native input_files/1v74.pdb
-unboundrot input_files/col_complex.pdb

-nstruct 1

-partners A_B
-dock_pert 3 8

-ex1
-ex2aro

-out:path:all output_files
-out:suffix _local_dock
```
注：
1. 链B对接进入链A； 
1. 在开始单独的模拟之前随机的将配体（链B）进行一个3埃的平移和8度的旋转。 
1. 若为对接的多链蛋白（如一个蛋白为链A和B，一个为链L和H） 那么设置为-partners LH_AB即可。
1. 同时想和1v74.pdb进行计算比较。


`$ROSETTA3/main/source/bin/docking_protocol.linuxgccrelease @flag_local_docking`
大约1min即可完成，请确保-nstruct 500或者更大的设置

局部优化对接结构：
一些小的冲突可能导致蛋白对接的得分非常高（越小越好），在Relax之前我们需要对界面处进行一定的修复。因为已经对接完成，我们需要避免大的蛋白移动。所以我们跳过之前的第一步（质心步骤）而仅进行第二部分计算。我们替换局部对接的flags:
```
-in:file:s input_files/1v74.pdb

-nstruct 1

-docking_local_refine
-use_input_sc

-ex1
-ex2aro

-out:file:fullatom
-out:path:all output_files
-out:suffix _local_refine
```

`$ROSETTA3/main/source/bin/docking_protocol.linuxgccrelease @flag_local_refine`

###### 全局对接
全局对接假设蛋白质为球型，而更小的蛋白质配体围绕蛋白质受体寻转，其原理个人理解与rDock双球对接类似。因为其随机起始位置，故输入的结构位置显得不是那么重要。全局对接对小复合物相对较好（残基数小于450）。采样样本量更加大，故为了得到精确的结果，需要大量的运行，一般高达10,000-100,000次.另一种方法为使用[ClusPro](https://cluspro.bu.edu/login.php)进行预对接确定结合口袋然后再运行局部对接。
```
-in:file:s input_files/col_complex.pdb
-in:file:native input_files/1v74.pdb
-unboundrot input_files/col_complex.pdb

-nstruct 1

-partners A_B
-dock_pert 3 8
-spin
-randomize1
-randomize2

-ex1
-ex2aro

-out:path:all output_files
-out:suffix _global_dock
```

`$ROSETTA3/main/source/bin/docking_protocol.linuxgccrelease @flag_global_docking`

###### 柔性对接
正如之前所提到的，Rosetta假设蛋白骨架为柔性的进行对接。其假设蛋白蛋白结合过程前后构象发生了较大的变化，我们对蛋白构象簇（ensembles ）进行对接。而不是像之前一般一个配体构象和一个受体构象。在蛋白对接第一步（质心步骤）我们在构象簇中不断的变化着来进行对接。这样可以相当于固定骨架与多个骨架之前进行采样。 这个簇可以使用无约束的relax进行完成。对于这个教程我们使用小簇- 3 COL_D 和 3 IMM_D构象。在设置其为输入文件之前要确认链名和残基数量每个簇中都一样。 簇的设置类似如下：

```
input_files/COL_D_ensemble/COL_D_0001.pdb
input_files/COL_D_ensemble/COL_D_0002.pdb
input_files/COL_D_ensemble/COL_D_0003.pdb

```
IMM_D_ensembel情况类似，-ensemble必须包含蛋白质PDB列表。即使有一个蛋白只有一个构象，两个ensemble也都要申明。 具体设置为：
```
-in:file:s input_files/col_complex.pdb
-in:file:native input_files/1v74.pdb
-unboundrot input_files/col_complex.pdb

-nstruct 1

-partners A_B
-dock_pert 3 8

-ensemble1 COL_D_ensemblelist
-ensemble2 IMM_D_ensemblelist

-ex1
-ex2aro

-out:path:all output_files
-out:suffix _ensemble_dock
```

`$ROSETTA3/main/source/bin/docking_protocol.linuxgccrelease @flag_ensemble_docking`

在对接之前我们还要进行一步前处理（prepacking）。前处理可以消除由于构象异构体而产生的不同能量贡献，其设置与对接类似类似，仅仅删除-dock_pert设置. 其大约运行30s，将会得到prepacked PDBs文件，以及规范化的质心得分和全原子得分，如下：
```
input_files/COL_D_ensemble/COL_D_0001.pdb.ppk
input_files/COL_D_ensemble/COL_D_0002.pdb.ppk
input_files/COL_D_ensemble/COL_D_0003.pdb.ppk
0.77058
0
1.00377
-93.3588
-94.2715
-93.9065
```

### 上交教程
###### 算例及结构预处理

算例：

```
思源一号：
mkdir ~/test_rosetta
cd ~/test_rosetta
cp -r /dssg/share/sample/rosetta/input_files ./
mkdir output_files

π2.0：
mkdir ~/test_rosetta
cd ~/test_rosetta
cp -r /lustre/share/samples/rosetta/input_files ./
mkdir output_files
```

结构预处理：
```
#!/bin/bash
#SBATCH --job-name=rosetta
#SBATCH --partition=small
#SBATCH -N 1
#SBATCH --ntasks-per-node=2
#SBATCH --output=%j.out
#SBATCH --error=%j.err

module load rosetta/3.12
mpirun relax.mpi.linuxgccrelease -in:file:s input_files/1qys.pdb -nstruct 2 -relax:constrain_relax_to_start_coords -relax:ramp_constraints false -ex1 -ex2 -use_input_sc -flip_HNQ -no_optH false
```
参数说明：
1. in:file:s                              #输入数据
1. nstruct                                #nstruct可以提高模型结果的质量，如nstruct 10将会获得10个模型
1. relax:constrain_relax_to_start_coords  #约束重原子，从而使得骨架较初始不会移动太多
1. relax:ramp_constraints                 #设为false则不进行倾斜约束（进行整体约束该选项需要设置为false）
1. use_input_sc                           #turns on inclusion of the current rotamer for the packer
1. flip_HNQ                               #在氢键原子位置优化期间考虑翻转HIS，ASN，GLN
1. no_optH                                #是否在PDB加载期间进行氢原子位置优化

###### 局部对接
```
#!/bin/bash
#SBATCH --job-name=rosetta
#SBATCH --partition=small
#SBATCH -N 1
#SBATCH --ntasks-per-node=2
#SBATCH --output=%j.out
#SBATCH --error=%j.err

module load rosetta/3.12
mpirun docking_protocol.mpi.linuxgccrelease -in:file:s input_files/col_complex.pdb -in:file:native input_files/1v74.pdb -nstruct 1 -partners A_B -dock_pert 3 8 -ex1 -ex2aro -out:path:all output_files -out:suffix _local_dock
```

参数说明：
1. in:file:s      #输入数据
1. in:file:native #native file，与该文件进行计算比较
1. nstruct        #请注意在进行实际数据分析时，此处的值应当至少为500
1. partners       #partners A_B意味着，链B对接进入链A
1. dock_pert      #dock_pert 3 8意味着，在开始单独的模拟之前随机的将配体（链B）进行一个3埃的平移和8度的旋转
1. out:path:all   #输出路径
1. out:suffix     #输出文件名后缀

###### 对接结果的局部优化
```
#!/bin/bash
#SBATCH --job-name=rosetta
#SBATCH --partition=small
#SBATCH -N 1
#SBATCH --ntasks-per-node=2
#SBATCH --output=%j.out
#SBATCH --error=%j.err

module load rosetta/3.12
mpirun docking_protocol.mpi.linuxgccrelease -in:file:s input_files/1v74.pdb -nstruct 1 -docking_local_refine -use_input_sc -ex1 -ex2aro -out:file:fullatom -out:path:all output_files -out:suffix _local_refine
```

###### 全局对接
若没有蛋白结合位点的信息，则使用全局对接。全局对接假设蛋白质为球型，而更小的蛋白质配体围绕蛋白质受体。全局对接对小复合物相对较好（残基数小于450）

```
#!/bin/bash
#SBATCH --job-name=rosetta
#SBATCH --partition=small
#SBATCH -N 1
#SBATCH --ntasks-per-node=2
#SBATCH --output=%j.out
#SBATCH --error=%j.err

module load rosetta/3.12
mpirun docking_protocol.mpi.linuxgccrelease -in:file:s input_files/col_complex.pdb -in:file:native input_files/1v74.pdb -unboundrot input_files/col_complex.pdb -nstruct 1 -partners A_B -dock_pert 3 8 -spin -randomize1 -randomize2 -ex1 -ex2aro -out:path:all output_files -out:suffix _global_dock
```
参数说明：
1. unboundrot  #将指定结构的旋转异构体添加到旋转异构体库中
1. nstruct     #请注意在进行实际数据分析时，此处的值应当为 10,000~100,000

###### 柔性对接

prepack：
```
#!/bin/bash
#SBATCH --job-name=rosetta
#SBATCH --partition=small
#SBATCH -N 1
#SBATCH --ntasks-per-node=2
#SBATCH --output=%j.out
#SBATCH --error=%j.err

module load rosetta/3.12
ls input_files/COL_D_ensemble/*.pdb > COL_D_ensemblelist
ls input_files/IMM_D_ensemble/*.pdb > IMM_D_ensemblelist
mpirun docking_prepack_protocol.mpi.linuxgccrelease -in:file:s input_files/col_complex.pdb -in:file:native input_files/1v74.pdb -unboundrot input_files/col_complex.pdb -nstruct 1 -partners A_B -ensemble1 COL_D_ensemblelist -ensemble2 IMM_D_ensemblelist -ex1 -ex2aro -out:path:all output_files -out:suffix _ensemble_dock
```

柔性对接：
Rosetta假设蛋白骨架为柔性的进行对接。Rosetta假设蛋白-蛋白结合过程前后构象发生了较大的变化，并对蛋白构象簇（ensembles）进行对接，而非一个配体构象和一个受体构象。
```
#!/bin/bash
#SBATCH --job-name=rosetta
#SBATCH --partition=small
#SBATCH -N 1
#SBATCH --ntasks-per-node=2
#SBATCH --output=%j.out
#SBATCH --error=%j.err

module load rosetta/3.12
mpirun docking_prepack_protocol.mpi.linuxgccrelease -in:file:s input_files/col_complex.pdb -in:file:native input_files/1v74.pdb -unboundrot input_files/col_complex.pdb -nstruct 1 -partners A_B -dock_pert 3 8 -ensemble1 COL_D_ensemblelist -ensemble2 IMM_D_ensemblelist -ex1 -ex2aro -out:path:all output_files -out:suffix _ensemble_dock
```

### 参考
1. [Rosetta快速入门指引](https://zhuanlan.zhihu.com/p/65248904)
1. [上海交大超算平台用户手册 Rosseta](https://docs.hpc.sjtu.edu.cn/app/bioinformatics/rosetta.html)
1. [小康学习 Rosetta蛋白蛋白对接](https://kangsgo.cn/p/rosetta%E8%9B%8B%E7%99%BD%E8%9B%8B%E7%99%BD%E5%AF%B9%E6%8E%A5/)

![](/img/wc-tail.GIF)
