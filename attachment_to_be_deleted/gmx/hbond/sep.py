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



