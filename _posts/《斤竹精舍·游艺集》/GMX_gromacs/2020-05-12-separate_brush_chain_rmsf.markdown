---
layout:     post
title:      "gmx 多链brush的rmsf计算"
subtitle:   ""
date:       2020-05-11 23:34:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2020

---

因为在计算多链brush的rmsf时发现gmx自带的tools里计算得到的rmsf没有根据残基号进行归类，所以写了个小脚本处理一下：

###### 更新20200512
使用范例：
```
python data_sep.py pep1.xvg
```
然后输入每个brush所含的残基总数即可得到每个残基rmsf的平均值和standard deviation.  

代码如下：  
File name: data_sep.py  
```
# coding: UTF-8
# multi-chain brushes, every chain have same residues number and the residues numbers of xvg file are repeated. We separate them and calculate.
# Use: python data_sep.py xxx.xvg
# import os
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

resTotal = input ("Input the total residue number: ") 
group_num = len(a)/resTotal # how many chains
res_rmsf = np.zeros((resTotal,group_num+1))
# Separate lines into groups
count = np.zeros(resTotal)
for i in range(len(a)):
	resNum = i%resTotal
	res_rmsf[resNum][count[resNum]+1] += a[i][1]
	count[resNum] += 1
# Calculate
average = np.zeros((resTotal,2))
average_after_sqr = np.zeros((resTotal,2))
for i in range(len(res_rmsf)):
	average[i][0] = i+1 # 定义残基序号
	average[i][1] = sum(res_rmsf[i][1:])/len(res_rmsf[i][1:])
	average_after_sqr[i][1] = sum(res_rmsf[i][1:]**2)/len(res_rmsf[i][1:])
#print (res_rmsf)
print ("Average=")
print (average)

stdev = np.zeros((resTotal,2))
for i in range(len(res_rmsf)):
	stdev[i][0] = i+1 # 定义残基序号
	stdev[i][1] = np.sqrt(sum((res_rmsf[i][x] - average[i][1]) ** 2 for x in range(1,group_num)) / group_num) # stdev = sqrt(sum(x-average)/number)
print ("STDEV=")
print (stdev)

stdev2 = np.zeros((resTotal,2))
for i in range(len(res_rmsf)):
	stdev2[i][0] = i+1 # 定义残基序号
	stdev2[i][1] = np.sqrt(average_after_sqr[i][1] - average[i][1]**2) # stdev = sqrt(sum(x**2)/number-average**2)
print ("STDEV2=")
print (stdev2)

filename_sep = filename.split('.')
ouf=open(filename_sep[0] + ".dat",'w')
print >> ouf, ("%s, %s, %s, %s" % ('resid', 'Average', 'StDev1', 'StDev2'))
for i in range(len(res_rmsf)):
    print >> ouf, ("%3d, %7.4f, %7.4f, %7.4f" % (i+1,average[i][1],stdev[i][1],stdev2[i][1]))
```

###### 旧代码
使用范例：
```
python data_sep.py pep1.xvg
```
然后输入每个brush所含的残基总数即可得到每个残基rmsf的平均值和standard deviation.  

代码如下：  
File name: data_sep.py  
```
# coding: UTF-8
# multi-chain brushes, every chain have same residues number. We separate them and calculate.
# Use: python data_sep.py xxx.xvg
import os
import numpy as np
import sys

# Main Part
#filename = "rmsf_linear.xvg"
filename = sys.argv[1]
f = open (filename) 
lines = f.readlines()[16:] # start from zero, 16 means line17 which is the first data
a = []
for line in lines:
    line=line.strip('\n') # remove the line break
    sep = filter(None, line.split(' ')) # filter is better than split, it deal with the multiple blank space problem.
    fline = map(float,sep) # convert into float 
    fline = list (fline)
    a.append(fline)
#    os.system("pause")
f.close()

resTotal = input ("Input the total residue number: ") 
group_num = len(a)/resTotal # how many chains
res_rmsf = np.zeros((resTotal,group_num+1))
# Separate lines into groups
count = np.zeros(resTotal)
for i in range(len(a)):
	resNum = i%resTotal
	res_rmsf[resNum][count[resNum]+1] += a[i][1]
	count[resNum] += 1
# Calculate
average = np.zeros((resTotal,2))
for i in range(len(res_rmsf)):
	average[i][0] = i+1 # 定义残基序号
	average[i][1] = sum(res_rmsf[i][1:])/len(res_rmsf[i][1:])
#print (res_rmsf)
print ("Average=")
print (average)

stdev = np.zeros((resTotal,2))
for i in range(len(res_rmsf)):
	stdev[i][0] = i+1 # 定义残基序号
	stdev[i][1] = np.sqrt(sum((res_rmsf[i][x] - average[i][1]) ** 2 for x in range(1,group_num)) / group_num) # stdev = sqrt((x-average)/number)
print ("STDEV=")
print (stdev)
```



![](/img/wc-tail.GIF)
