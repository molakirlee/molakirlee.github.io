---
layout:     post
title:      "LAMMPS 聚电解质刷"
subtitle:   ""
date:       2020-10-18 10:23:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### Method: MD simulations
Simulations applied a commonly used model for polyelectrolytes. 64 polyelectrolyte chains of 100 spherical charged LJ beads of diameter $\sigma$ were grafted to a surface of cubic lattice points. To set the length scale of the simulations, we assumed $\sigma$ = 0.23 nm, which was obtained by matching the simulated $l_B$ (3$\sigma$) to the experimental $l_B$ for water at 300 K (0.7 nm). Using this value for $\sigma$, the estimated grafting density for 5$\sigma$ and 10$\sigma$ spacing is ~0.2 and ~0.8 chains/nm2, respectively. Provided that our chain MW is a factor of ~10 smaller than that in the experiments, this increased grafting density relative to the experiments is a reasonable approximation for the experimental system. Each bead in the polymer chain was bonded to its nearest neighbor using the finite extensible nonlinear elastic potential having an average bond length of 1.1$\sigma$. A polyelectrolyte persistence length of 1$\sigma$ was enforced using a three-body cosine-$\delta$ bending potential between neighboring monomers. This system of 6400 polyelectrolyte beads was in equilibrium with 6400 monovalent counterion beads (representative of salt particles in solution), embedded in a dielectric environment corresponding to the $l_B$ (we assumed $l_B$ = 3$\sigma$ for standard water and $l_B$ = 12$\sigma$ for IPA). Extra salt particles were added to the simulation cell corresponding to the monovalent/trivalent salt concentrations of the solution. Electrostatic interactions were treated using a P3M Ewald sum in the slab geometry, with solvent fluctuations incorporated via a Langevin thermostat. Dynamics were evolved using the velocity-Verlet algorithm. Two million time steps of 0.005$\tau$ were run for polyelectrolyte brush equilibration, with 5 million steps for the production run. Periodic boundary conditions were applied in the dimensions parallel to the substrate, and impenetrable walls were placed at z=0 and z=200$\sigma$.

**注释：**  
1. Discussions concerning solvent quality will refer to experimental solubility, which depends on a combination of the van der Waals solvent quality of the polymer backbone (Flory parameter) and the strength of the charge on the polyelectrolyte. The latter contribution is quantified by the solvent dielectric constant or, more concretely, the Bjerrum length, $l_B$.
1. $l_B = e^2/ (4 \pi \epsilon kBT )$ (见参考资料)。
1. The Bjerrum length, $l_B$, the separation at which two charges have an electrostatic interaction of magnitude kBT (for water at room temperature, $l_B$ is on the order of 0.5 nm). Water was used as a good solvent for PSS, despite it being a poor solvent for the polystyrene backbone, because it has a high dielectric constant (low $l_B$). Isopropyl alcohol (IPA) was used as a poor solvent for PSS because it is a similarly poor solvent for the polystyrene backbone but has a much lower dielectric constant (high $l_B$). These solvent variations are fundamental in elucidating the collapse mechanism and provide a strong basis for detailed MD simulations that explore the relative contributions of solvophobic and electrostatic effects.
1.  For this case, we used a $l_B = 3 \sigma$ and a Lennard-Jones (LJ) parameter of 0.4 kBT, which corresponds to a good solvent.
1. IPA can be mixed with water in any ratio and is not as good a solvent as water is for PSS, in that the larger lB causes more significant chain neutralization, leading to a stronger emergence of the solvophobic backbone character.
1. a low $l_B$ will cause the polyelectrolyte to behave as if it is more soluble and a high $l_B$ will cause it to behave as if it is less soluble.
1. `dielectric value`:Set the dielectric constant for Coulombic interactions (pairwise and long-range) to this value. The constant is unitless, since it is used to reduce the strength of the interactions. The value is used in the denominator of the formulas for Coulombic interactions - e.g. a value of 4.0 reduces the Coulombic interactions to 25% of their default strength. See the pair_style command for more details.


### Code
```
################################################################################################
# Title: Multivalent ions induce lateral structural inhomogeneities in polyelectrolyte brushes 
# Author: Nicholas E. Jackson                                      
# Representative large-scale atomic/molecular massively parallel simulator input
# (used to generate data in Fig. 6C).
################################################################################################
units lj
atom_style full
pair_style lj/cut/coul/long 2.5 5.5
pair_modify shift yes mix arithmetic
bond_style fene
angle_style cosine/delta
boundary p p f
neighbor 0.5 bin
neigh_modify every 1 delay 3 check yes one 10000
#
kspace_style pppm 0.001
kspace_modify slab 3.0
special_bonds fene
# ------------- Particle Definitions ------------
read_data "brush.data"
# Non-bonded interactions (pair-wise): epsilon, sigma, cutoff1, cutoff2
pair_coeff 1 1 0.0 1.0
pair_coeff 1 2 0.0 1.0
pair_coeff 1 3 0.0 1.0
pair_coeff 1 4 0.0 1.0
pair_coeff 1 5 0.0 1.0
pair_coeff 2 2 0.4 1.0
pair_coeff 2 3 0.4 1.0
pair_coeff 2 4 0.4 1.0
pair_coeff 2 5 0.4 1.0
pair_coeff 3 3 0.4 1.0
pair_coeff 3 4 0.4 1.0
pair_coeff 3 5 0.4 1.0
pair_coeff 4 4 0.4 1.0
pair_coeff 4 5 0.4 1.0
pair_coeff 5 5 0.4 1.0
#
# FENE Stretching Interactions
#bond_coeff bondtype: k, R0, epsilon, sigma
bond_coeff 1 30.0 1.5 1.0 1.0
#
# Harmonic Angle Interaction
angle_coeff 1 1.0 180.0
# ------------- Run Section -----------
thermo 1000
run_style verlet
timestep 0.005
dielectric 0.333
restart 50000 brush.restart
#
#SIMULATION BOX FIXES
group substrates type 1
group bot_substr id <= 81
group top_substr subtract substrates bot_substr
group polymers type 2
group ctr_ions type 3
group salt subtract all substrates polymers ctr_ions
group dump_group subtract all top_substr
#
fix 1 substrates setforce 0.0 0.0 0.0
group not_substr subtract all substrates
# wall parameters: face(e.g. zlo), coordinate(e.g. EDGE), epsilon, sigma, cutoff
fix wall1 not_substr wall/lj126 zlo EDGE 0.1 1.0 2.5
fix wall2 not_substr wall/lj126 zhi EDGE 0.1 1.0 2.5
#
compute real_temp not_substr temp
thermo_style custom step dt c_real_temp press vol etotal ke pe ebond eangle evdwl ecoul elong
#
# Minimize the simulation box.
fix poly_hold polymers setforce 0.0 0.0 0.0
minimize 1.0e-6 1.0e-6 2000 2000
unfix poly_hold
#
# Initial Safe Equilibration to remove bad contacts
velocity not_substr create 1.0 98644713
fix temper not_substr nve/limit 0.1
fix temper2 not_substr langevin 1.0 1.0 100.0 986537
fix rescale0 not_substr temp/rescale 2 1.0 1.0 0.2 1.0
dump 1 dump_group custom 100000 equil.trj id type x y z
run 2000000
unfix rescale0
unfix temper2
unfix temper
undump 1
#
# Run NVT Sampling
fix 11 not_substr nve
fix 3 not_substr langevin 1.0 1.0 100.0 67016776
dump 2 polymers custom 100000 polymers.trj id type q xu yu zu
dump 55 polymers custom 100000 poly_wrap.trj id type q x y z
dump 3 ctr_ions custom 100000 ctrions.trj id type q x y z
dump 4 salt custom 100000 salt.trj id type q x y z
run 5000000
unfix 3
unfix 11
undump 2
undump 55
undump 3
undump 4
```




### 参考资料
1. 原文链接：[Multivalent ions induce lateral structural inhomogeneities in polyelectrolyte brushes](https://advances.sciencemag.org/content/3/12/eaao1497?intcmp=trendmd-adv)
1. [dielectric command](https://lammps.sandia.gov/doc/dielectric.html)
1. [Bjerrum Pairs in Ionic Solutions: a Poisson-Boltzmann Approach](https://arxiv.org/pdf/1702.04853.pdf)

![](/img/wc-tail.GIF)
