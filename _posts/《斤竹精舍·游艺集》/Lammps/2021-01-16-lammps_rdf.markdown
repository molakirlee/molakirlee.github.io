---
layout:     post
title:      "LAMMPS 未分类指令集"
subtitle:   ""
date:       2021-01-16 19:12:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2021

---




###### [compute heat/flux command](https://lammps.sandia.gov/doc/compute_heat_flux.html)
```
compute ID group-ID heat/flux ke-ID pe-ID stress-ID
ID, group-ID are documented in compute command

1. heat/flux = style name of this compute command
1. ke-ID = ID of a compute that calculates per-atom kinetic energy
1. pe-ID = ID of a compute that calculates per-atom potential energy
1. stress-ID = ID of a compute that calculates per-atom stress

eg. compute myFlux all heat/flux myKE myPE myStress
```

###### [compute rdf command](https://lammps.sandia.gov/doc/compute_rdf.html)
```
compute ID group-ID rdf Nbin itype1 jtype1 itype2 jtype2 ... keyword/value ...

1. ID, group-ID are documented in compute command
1. rdf = style name of this compute command
1. Nbin = number of RDF bins
1. itypeN = central atom type for Nth RDF histogram (see asterisk form below)
1. jtypeN = distribution atom type for Nth RDF histogram (see asterisk form below)
1. zero or more keyword/value pairs may be appended
1. keyword = cutoff

eg. compute 1 all rdf 100 * 3 cutoff 5.0
```

###### [fix ave/atom command](https://lammps.sandia.gov/doc/fix_ave_atom.html)
```
fix ID group-ID ave/atom Nevery Nrepeat Nfreq value1 value2 ...

1. ID, group-ID are documented in fix command
1. ave/atom = style name of this fix command
1. Nevery = use input values every this many timesteps
1. Nrepeat = # of times to use input values for calculating averages
1. Nfreq = calculate averages every this many timesteps one or more input values can be listed
1. value = x, y, z, vx, vy, vz, fx, fy, fz, c_ID, c_ID[i], f_ID, f_ID[i], v_name

eg. 
compute my_stress all stress/atom NULL
fix 1 all ave/atom 10 20 1000 c_my_stress[*]
```

![](/img/wc-tail.GIF)
