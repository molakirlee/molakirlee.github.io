---
layout:     post
title:      "gmx 以指定行数分割数据"
subtitle:   ""
date:       2020-05-15 13:17:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2020

---

在有多个相同分子时，得到的数据并不会将不同分子的同一残基数据归纳到一起以便分析，而是在输出一个分子的数据后，以相同序号再输出第二个分子的数据，如先对分子1输出其残基1-10的某参数，然后对具有相同结构的分子2又重新从1-10开始输出，而不是直接将分子2的数据置于分子1后面。下面代码可解决上述问题：

###### Coding
```
# coding: UTF-8
# multi-chain brushes, every chain have same residues number and the residues numbers of xvg file are repeated. We separate them and calculate.
# Use: python sep.py xxx.dat xxx.dat 20
# python + python_file+infile + outfile+elements number in a group
# python 2.7
import numpy as np
import sys

# Main Part
#filename = "rmsf_linear.xvg"
filename = sys.argv[1]
f = open (filename) 
lines = f.readlines()
a = []
for line in lines:
	if line[0] == '#' or line[0] == '@':
		continue
	line=line.strip('\n') # remove the line break
	sep = filter(None, line.split(' ')) # filter is better than split, it deal with the multiple blank space problem.
	fline = map(float,sep) # convert into float 
	fline = list (fline)
	a.append(fline)
#	os.system("pause")
f.close()

#resTotal = input ("How many elements in a group: ") 
resTotal = int(sys.argv[3])
group_num = len(a)/resTotal 
res_var = np.zeros((resTotal,group_num+1))
count = np.zeros(resTotal)
for i in range(resTotal):
	res_var[i][0] = i+1
for i in range(len(a)):
	resNum = i%resTotal
	res_var[resNum][count[resNum]+1] += a[i][1]
	count[resNum] += 1


ouf=open(sys.argv[2],'w')

for i in range(resTotal):
	for j in range(group_num):
		print >> ouf, "%7.4f" % res_var[i][j],  #py2
	print >> ouf

```


![](/img/wc-tail.GIF)
