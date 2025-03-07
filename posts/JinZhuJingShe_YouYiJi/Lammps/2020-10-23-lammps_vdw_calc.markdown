---
layout:     post
title:      "LAMMPS 计算范德华相互作用能"
subtitle:   ""
date:       2020-10-23 21:06:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-07-howtowritepaper/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - LAMMPS
    - 2020

---

### `compute ID group_ID pair lj/cut evdwl`
The scalar value will be in energy units.
###### 代码示例
```
compute vdwcalc all pair lj/cut evdwl
variable t equal step
variable VDW_system equal c_vdwcalc
fix vdwo all print 1 "$t ${VDW_system}" file VDW_of_System.dat screen no
run 10
unfix vdwo
```

###### 批处理脚本
make_group.bsh
```
for i in {1..39..13}
do
j=$[$i/13+1]
cat > run.in.vdw_xilock_$j <<EOF

# ------------------------------- Initialization Section --------------------
include         "system.in.init"
boundary        p p p
pair_style      lj/cut 2.5
read_data       "system_after_nvt_4.data"
# ------------------------------- Settings Section --------------------------
include         "system.in.settings"

# -- simulation protocol --
timestep        0.001
velocity all zero linear   # <- eliminate drift due to non-zero total momentum
                           #fix 1 all momentum 1000 linear 1 1 1 # also works
thermo          100
print "---------------------------------------------------------------------------"
print "--- Now Calculate VDW ---"
print "---------------------------------------------------------------------------"

group KB_$j id $i:$[$i+12]

compute vdwcalc_$j KB_$j pair lj/cut evdwl
variable t equal step
variable VDW_system equal c_vdwcalc_$j
fix vdwo all print 1 "\$t \${VDW_system}" file VDW_of_System_$j.dat screen no
run 1
unfix vdwo
EOF
done
```
说明：
1. 玺洛克的体系中有100个KB分子，每个分子13个原子，想先拿其中3个分子做测试，想得到KB分子间结合能的vdw部分。
1. 玺洛克的思路是：在当前构象下，先分别计算每个分子的vdw势能，然后计算所有分子总的势能，最后用总的势能减去所有单个分子的vdw势能，即可得到相互作用呢的vdw部分。
1. 然而！！！单个KB分子的vdw势能竟然都一样而且跟总的一样？？Why？？






###### 参考资料
1. [compute pair command](https://lammps.sandia.gov/doc/compute_pair.html)




### `compute ID group1_ID group/group group2_ID`
###### 代码示例
计算DRUG和NANOTUBE的VDW
```
compute  vdwlint DRUG group/group NANOTUBE
thermo_style custom step temp c_vdwlin
```

###### 参考资料
1. [Re: [lammps-users] evdwl](https://lammps.sandia.gov/threads/msg14241.html)
1. [compute group/group command](https://lammps.sandia.gov/doc/compute_group_group.html)
1. [thermo_style command](https://lammps.sandia.gov/doc/thermo_style.html)

![](/img/wc-tail.GIF)
