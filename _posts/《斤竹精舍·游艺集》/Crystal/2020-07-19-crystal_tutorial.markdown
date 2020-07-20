---
layout:     post
title:      "Crystal教程"
subtitle:   ""
date:       2020-07-19 09:31:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - 2020
    - Crystal

---

## Block1 - geometry input

### 代码示例
```
MgO bulk
CRYSTAL
0 0 0
225
4.21
2
12  0.0  0.0  0.0
8   0.5  0.5  0.5
```

### 注释

1. MgO bulk : title
1. CRYSTAL : Dimensionality. 对于3D, 2D, 1D and 0D系统分别为CRYSTAL, SLAB, POLYMER 和 MOLECULE; EXTERNAL allows geometry input from external file.
1. 0 0 0 : Crystallographic information (for 3D systems only). 三个数分别代表: 1. convention for the space group identification: sequential number (0) or alphanumeric code (1); 2. type of cell for rhombohedral groups: hexagonal (0) or rhombohedral (1); 3. setting of the origin (see CRYSTAL User's Manual for further details).
1. 225 : Space Group number
1. 4.21 : The minimal set of crystallographic cell parameters is indicated (in Angstrom and degrees).
1. 2 : 晶格内非对称原子个数
1. 12 0.    0.    0. : 非对称原子坐标，以conventional atomic number和coordinates in fractional units of the crystallographic lattice vectors表示.
1. 8 0.5   0.5   0.5 : 第2个非对称原子的坐标
1. END : Closing the geometry input section，在前面可以添加optional keyword，如TESTGEOM（终止计算用以检查）
1. 遇见不明白的格式去查manual，里面有详细的格式说明，比如origin项非0时。

### 其他设定
###### super cell
1. keyword: SUPERCEL
###### 对称性
1. keyword: KEEPSYMM, 
1. keyword: BREAKSYMM [default] 
1. keyword: SYMMREMO, removes all point symmetry operators.
1. keyword: MODISYMM, removal selected symmetry operators (写在基组部分).
1. keyword: ATOMSYMM, prints the point group associated with each atomic position and the set of symmetry related atoms.
1. keyword: SYMMDIR, prints the symmetry allowed directions, corresponding to the internal degrees of freedom (to obtain printing full crystal input must be submitted, block 1 2 3 4, with keyword TESTPDIM in block 3).
###### Substitution, displacement of atoms
1. keyword: ATOMSUBS, allows substitution of selected atoms in the cell.
1. keyword: ATOMDISP, allows displacement of selected atoms in the cell as defined (分子弛豫). 
1. keyword: ATOMINSE/ATOMREMO, removes selected atoms from the primitive cell. 
1. keyword: MOLEXP, 个数与The minimal set of crystallographic cell parameters一致，allows to modify the cell parameters according to increments given in input. However, although the volume of the cell is modified, the symmetry and the internal geometry of the molecules in the cell are kept.
###### slab
###### molecule


## Block2 - basic set input 
###### Standard input
###### Input for pre-defined basis sets

## Block3 - Hamiltonian,computational parameters, SCF & C
###### Hamiltonian - Hartree-Fock Theory (HF) methods
###### Hamiltonian - Density Functional Theory  (DFT) methods
1. Local (-density approximation, LDA): functionals of the electron density only;
1. Gradient-corrected (GGA): functionals of the electron density and its gradient;
1. meta-GGA: as for GGA, but also including either the kinetic energy density or the Laplacian of the electron density.
1. Global-Hybrid (GH): the exchange functional is a linear combination of Hartree-Fock and DFT (LDA or GGA or mGGA) exchange term.
1. Range-Separated Hybrid (RSH): hybrid functionals in which the amount of HF exchange included depends on the distance between electrons. Short-, long- and middle-range hybdrid functional are available.
1. Double-Hybrid (DH): Along with the hybridization of the exchange term, it combines also a DFT correlation functional with an a-posteriori PT2 correlation contribution.
###### Sampling of k points in reciprocal space (necessary)
###### Convergence criteria
###### SCF initial guess
###### Convergence tool
1. FMIXING: % of Hamiltonian matrix mixing (Default=30%)
1. LEVSHIFT: 
###### 

## 参考资料：
###### tutorial
1. [Manual](/molakirlee.github.io/_posts/《斤竹精舍·游艺集》/Crystal/crystal14.pdf)
###### geometry input
1. [CRYSTAL geometry input](http://tutorials.crystalsolutions.eu/tutorial.html?td=geometry&tf=geom_tut)
1. [结构输入输出算例 List of CRYSTAL geometry input examples](http://tutorials.crystalsolutions.eu/tutorial.html?td=geometry&tf=list) 
###### basic set input
1. [CRYSTAL Basis Set Input](http://tutorials.crystalsolutions.eu/tutorial.html?td=basis_set&tf=basis_set_tut)
###### Hamiltonian input
1. [Hamiltonian,computational parameters, SCF & C](http://tutorials.crystalsolutions.eu/tutorial.html?td=hamil_scf&tf=hamil_scf_tut)
###### geometry optimization
1. [A quick tour of CRYSTAL: geometry optimization](http://tutorials.crystalsolutions.eu/tutorial.html?td=others&tf=quick_opt)
1. [Geometry optimization](http://tutorials.crystalsolutions.eu/tutorial.html?td=optgeom&tf=opt_tut)
###### vibrational
IR/Raman/LO-TO splitting/Isotopic substitution/Thermodynamic analysis/Frequencies of a fragment/Phonon dispersion/Anharmonic correction to X-H stretching modes  

1. [Vibrational frequencies calculation](http://tutorials.crystalsolutions.eu/tutorial.html?td=vibfreq&tf=vibfreq_tut#ref1)
1. [A quick tour of CRYSTAL:vibrational frequencies calculation](http://tutorials.crystalsolutions.eu/tutorial.html?td=others&tf=quick_freq)


![](/img/wc-tail.GIF)
