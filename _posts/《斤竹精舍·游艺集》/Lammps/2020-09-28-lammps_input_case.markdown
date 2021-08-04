---
layout:     post
title:      "LAMMPS的input文件"
subtitle:   ""
date:       2020-09-28 21:45:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---


### Summary
为了方便取拿，总结了一下LAMMPS的input文件，主要包括以下部分及内容：

###### Initialization

```
#####################
# 1. Initialization #
#####################
# Box and units  (use LJ units and periodic boundaries)
units lj                 # use lennard-jones (i.e. dimensionless) units
atom_style full         # angle:atoms with bonds and angles; full:
boundary p p p           # p p p : all boundaries are periodic; p p f: x/y are periodic

# Neighbours list
neighbor 0.5 bin
neigh_modify every 1 delay 3 check yes one 10000

# Medium
dielectric 0.333 
```

###### Atom Data

```
######################
# 2. Atom definition #
######################
# READ "start" data file 
read_data initial_configuration.txt 
```

###### Setting
```
####################################
# 3 Setting: Bond - Nonbond - Pair #
####################################
# Bonds
bond_style   fene
special_bonds fene #<=== I M P O R T A N T prevents LJ from being counted twice
# For style FENE, specify: bond type / K (energy/distance^2) /  R0 (distance) / epsilon / sigma
bond_coeff   1    30.0   1.5   1.0   1.0

# Angles
angle_style cosine/delta
angle_ceoff 1 1.0 180.0

# Non-bonded
pair_style      lj/cut/coul/long 2.5 2.5
pair_modify shift yes mix arithmetic       # option to ensure energy is calculated corectly
#  pair_coeff for LJ, specify 4: atom type interacting with / atom type / energy / mean diameter of the two atom types / cutoff
pair_coeff      1 1 1.0 1.0 1.12246152962189
```

```
#################
# 4 Additional  #
#################
# Define groups 
group substrates type 1 
group bot_substr id <= 81
group top_substr subtract substrates bot_substr
group polymers type 2
group ctr_ions type 3
group salt substract all polymers ctr_ions
group dump_group subtract all top_substr

# Generate regular RESTART files to store state of simulation
#restart 50000 polymer.restart

# Reset timestep / set timestep of integrator
reset_timestep 0 
timestep 0.005
```



###### RUN
```
#########
# 5.1 Output #
#########
## Output thermodynamic info  (temperature, energy, pressure, etc.)
thermo 1000
compute real_temp not_substr temp
thermo_style   custom   step  temp dt c_real_temp press vol etotal ke pe ebond eangle evdwl ecoul elong
## Output thermodynamic info to file
variable t equal step
variable mytemp equal temp
variable myepair equal epair
fix mythermofile all print 1000 "$t ${mytemp} ${myepair}" file thermo_output.dat screen no
## Set up a compute for R_g and write it to a file
compute myRG2compute all gyration
variable RG2 equal c_myRG2compute
fix myRG2file all print 1000 "$t ${RG2}" file radius_of_gyration_squared.dat screen no
```


```
###################
# 5.2 Fix and Run #
###################
# Set up fixes
variable seed equal 54654651     # a seed for the thermostat
fix 1 all nve                             # NVE integrator
fix 2 all langevin   1.0 1.0 100.0 ${seed}  # langevin thermostat

# now do a longer run and  write a final restart file
run_style verlet
run 50000
write_restart final.restart
```


### Case
1. [run.in.case](https://molakirlee.github.io/attachment/lammps/run.in.case)


![](/img/wc-tail.GIF)
