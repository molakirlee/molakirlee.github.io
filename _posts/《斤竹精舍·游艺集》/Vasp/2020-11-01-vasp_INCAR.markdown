---
layout:     post
title:      "Vasp INCAR"
subtitle:   ""
date:       2020-11-01 10:55:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Vasp
    - 2020


---

### 基本输入
```
# ------------
# - 1. INCAR -
# ------------
# 写INCAR的时候，不要使用 tab，用空格替换tab；
# 官网有些旧的文件可能用的不是 # 号，而是 !。 大家记住: ! 可能会出错；
# 下文中的“分子原子体系”指的就是“把分子或者原子放到一个box里面”。

SYSTEM = O atom       # 该计算的说明，任意写，没有也没有影响.
ISMEAR = 0            
# ----------------------------
# 展宽方法，一般ISMEAR = 0 (Gaussian Smearing) 可以满足大部分的体系（金属，导体，半导体，分子）；
# 对于分子或者原子，用0;
# 对于金属来说，ISMEAR的取值一般为0或1；
# 半导体和绝缘体体系不大于0，一般用0；
# K 点少，半导体或者绝缘体，那么只能用 ISMEAR = 0；
# 对所有体系，如果想获取更加精确能量的时候用-5(如DOS计算)：但使用-5的时候，K点数目小于3则程序会罢工；
# ----------------------------
SIGMA = 0.01          
# ----------------------------
# 对于分子原子体系，死死记住下面组合就可以了，ISMEAR = 0; SIGMA = 0.01。
# 对于金属(ISMEAR=1或0)，非金属(ISMEAR=0)，一般取SIGMA=0.10即可，默认值是0.20，不放心的话，用0.05；
# 如果用了ISMEAR = -5； SIGMA的值可以忽略，也可以不管；
# 判断标准： SIGMA的取值要保证OUTCAR 中的 entropy T*S (展宽entropy而非物化entropy)这一项，平均到每个原子上，要小于 1-2 meV；
# ----------------------------
```

### 一般附加
```
ISTART = 0   # Default: ISTART = 1 if a WAVECAR file exists,  = 0 else; 
# ----------------------------
# 1: the usual setting for convergence tests with respect to the cut-off energy and for all jobs where the volume/cell-shape varies (e.g. to calculate binding energy curves looping over a set of volumes).
# 2: Continuation job， "restart with constant basis set". Orbitals are read from the WAVECAR file.
# ----------------------------
ICHARG = 2  # Default: ICHARG = 2 if ISTART=0, = 0 else
# ----------------------------
# 0: Calculate charge density from initial wave functions.
# 1: Read the charge density from file CHGCAR.
# 11: To obtain the eigenvalues (for band structure plots) or the DOS for a given charge density read from CHGCAR.
# 2: Take superposition of atomic charge densities
# ----------------------------

ALGO = FAST   # specify the electronic minimisation algorithm
IALGO = 38   #
# ----------------------------
# default: 8 for VASP.4.4 and older,= 38 else (if ALGO is not set)
# IALGO=5 steepest descent
# IALGO=6 conjugated gradient
# IALGO=7 preconditioned steepest descent
# IALGO=8 preconditioned conjugated gradient
# IALGO=38: Blocked-Davidson algorithm (ALGO=N)
# ----------------------------
LWAVE =  .TRUE.   # default LWAVE = .TRUE. ; determines whether the wavefunctions are written to the WAVECAR file at the end of a run.
LCHARG = .TRUE.   # dafault: .TRUE. 
LVTOT = .FALSE.   # dafault: .FALSE.
```

### 其他附加
``` 
LREAL = Auto # 
# ----------------------------
# LREAL determines whether the projection operators are evaluated in real-space or in reciprocal space
# 1. LREAL=.FALSE.    projection done in reciprocal space
# 2. LREAL=.TRUE.     projection done in real space, (old, superseded by LREAL=O)
# 3. LREAL=On or O    projection done in real space, projection operators are re-optimized
# 4. LREAL=Auto or A  projection done in real space, fully automatic optimization of projection operators (no user interference required)
# 不能把LREAL=.FALSE.和LREAL=ON/.TRUE.计算的结果进行能量比较
# ----------------------------
ISIF =    
# ----------------------------
# determines whether the stress tensor is calculated and which principal degrees-of-freedom are allowed to change in relaxation and molecular dynamics runs.
# Default: =0 for IBRION=0 (molecular dynamics), = 2 else
# 3: yes for calculating forces and stress tensor; yes for degree-of-freedom of position, cell shape, and cell volume. 
# 2: yes for calculating forces and stress tensor; yes for degree-of-freedom of position but not for degree-of-freedom of cell shape, and cell volume. 
# ----------------------------
GGA = PE 
# ----------------------------
# specifies the type of generalized-gradient-approximation one wishes to use.
# Default: GGA = type of exchange-correlation in accordance with the POTCAR file 
# PE: Perdew-Burke-Ernzerhof
# ----------------------------
NELM = 100 
# ----------------------------
# default: 60
# sets the maximum number of electronic SC (selfconsistency) steps which may be performed.
# ----------------------------
ADDGRID=.TRUE. 
# ----------------------------
# default: .FALSE. ; 
# determines whether an additional support grid is used for the evaluation of the augmentation charges.
# ----------------------------
```

### 结构优化
###### IBRION
1. `IBRION` determines how the ions are updated and moved. 
1. default = -1 (no update) for NSW = -1 or 0;= 0 else.
一般来说，优化结构的时候有3个选择：
1. IBRION=3：你的初始结构很差的时候；
1. IBRION=2：共轭梯度算法，很可靠的一个选择，一般来说用它基本没什么问题。
1. IBRION=1：用于小范围内稳定结构的搜索。

###### NSW
NSW 控制几何结构优化的步数。也就是VASP进行多少离子步。
1. 它必须是大于等于0的整数。
1. 一般来说，简单的体系200步内就可以正常结束。
1. 不知道什么时候收敛，初始结构很差，或者设置了很严格的收敛标准，那么你就要增大一下NSW的取值了，比如NSW=500或者更大。

###### POTIM = 0.05   
```
# ----------------------------
# sets the time step (MD) or step width scaling (ionic relaxations)
# POTIM = none, must be set if IBRION= 0 (MD); = 0.5 if IBRION= 1,2,3 (ionic relaxation) and 5 (up to VASP.4.6); = 0.015 for IBRION=5 (up from VASP.5.1).
# 一般0.1就很不错
# ----------------------------
```

###### 示例
```
IBRION = 2
NSW = 500
POTIM = 0.05   
ISIF= 3   # 2 default
```

### 精度控制
```
ENCUT = 400   # 截断能
EDIFF = 1E-6   # 电子步收敛精度, 1E-6 default is enough
EDIFFG = -0.01   # 离子弛豫精度,-0.01已经很严格，除非特殊需要，不要设置-0.001；若很多步仍不收敛可尝试-0.02.
NGX =  47
NGY =  47
NGZ =  146

```
1. NGX sets the number of grid points in the FFT-grid along the first lattice vector. Default NGX = set in accordance with PREC and ENCUT.

### slab
1. 真空层的厚度要适中，太小肯定不行，太大也不合适。真空层太厚意味着模型尺寸变大，从而导致计算变慢；太小则无法消除周期性的影响。一般来说，对于表面反应的计算，15A的真空层厚度足够了。但是，对于功函数这一类对真空层敏感的计算来说，我们需要注意。
1. slab模型一般需要添加偶极矫正：`LDIPOL = .TRUE. ; IDIPOL = 3`
```
LDIPOL = .TRUE.
IDIPOL = 3    # (3指的是在z方向上)这两个参数来消除上下不对称的slab表面导致的偶极矩影响.
```

### 频率计算
```
IBRION=5  # 告诉vasp要进行频率计算；
NFREE = 2   # 原子在某一方向上正反两个方向移动. do not use NFREE = 1.
PREC = NORMAL    # specifies the "precision"-mode. default: Normal for VASP.5.X
```

### 磁性
```
ISPIN = 2
MAGMOM = 5*2
```

### 加U
```
LDAU  =  .TRUE
LDAUTYPE  =  2
LDAUU  = 0  0  5    9    0
LDAUJ  = 0  0  0.64 1.5  0
LDAUPRINT  = 0
# LMAXMIX =    # default = 2. 
# ----------------------------
# "LMAXMIX" controls up to which l-quantum number the one-center PAW charge densities are passed through the charge density mixer and written to the CHGCAR file.
# L(S)DA+U calculations require in many cases an increase of LMAXMIX to 4 for d-electrons (or 6 for f-elements) in order to obtain fast convergence to the groundstate.
# ----------------------------
```

### [parallel parameter](https://www.vasp.at/wiki/wiki/index.php/LPLANE)
```
NCORE = 12   # 一般为节点核数的一半
LPLANE=.TRUE.
NPAR=2   # NPAR flag should be equal to the number of core.
LSCALU=.FALSE.   # switches on the parallel LU decomposition (using scaLAPACK) in the orthonormalization of the wave functions.
NSIM=4   # sets the number of bands that are optimized simultaneously by the RMM-DIIS algorithm.
```

### 能带 energy band
```
LORBIT = 11
# ----------------------------
# "LORBIT" together with an appropriate RWIGS, determines whether the PROCAR or PROOUT files are written.
# 11: RWIGS tag ignored; files written (DOSCAR and lm-decomposed PROCAR)
# LORBIT >= 11 and ISYM = 2 the partial charge densities are not correctly symmetrized and can result in different charges for symmetrically equivalent partial charge densities.
# 对轨道选取的影响
# LORBIT=10: 把态密度分解到每个原子以及原子的spd轨道上面，称为为局域态密度，Local DOS (LDOS).故点击 dxy的时候，则其他的d轨道(dyz,dxz,dz2,dx2)也会同时被选中;
# LORBIT=11: 在10的基础上，还进一步分解到px，py，pz等轨道上，称为投影态密度（Projected DOS）或者分波态密度(Partial DOS)，即PDOS.故点击dxy时，则仅仅选择dxy，其他的d轨道不会选中;
# ----------------------------
```

### 其他说明
###### K point奇偶的选择
For grids centred on the Gamma-point, even grids sometimes have better convergence than odd grids. This is precisely because they avoid the gamma-point itself, which is a very high symmetry point and not a good representative sampling point.

For systems with hexagonal symmetry, however, you should basically *never* use an even-grid (gamma-centred) because the hexagonal symmetry operations applied to an even grid generate points outside the Brillouin zone (see the papers of Chadi and Cohen for details; link below). You may find this discussion useful:

https://www.researchgate.net/post/Is_there_an_optimum_number_of_k_points_in_the_irreducible_Brilloiun_zone_that_is_necessary_for_good_calculations_of_bulk_total_energy

### 参考资料：


![](/img/wc-tail.GIF)
