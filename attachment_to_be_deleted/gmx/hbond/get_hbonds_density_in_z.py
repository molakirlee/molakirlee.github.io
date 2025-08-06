#!/opt/local/bin/python
# python 3.6
# python + py_file + tpr_file + trj_file + outfile + start_frame + end_frame
# python get_hbonds.py xxx.tpr xxx.xtc xxx.csv xxx.csv 5 290 301
# csv is out of pandas frame, 1st is the detail and 2nd is the hydrogen bond number in every bins
# bin size is 5 angstrom
# from configure(traj) frame 290 to frame 300;


import sys
import pandas as pd
import numpy as np
import MDAnalysis, MDAnalysis.analysis.hbonds

## get input file names and read in data
groFile=sys.argv[1]
xtcFile=sys.argv[2]

u=MDAnalysis.Universe(groFile,xtcFile)

istart=int(sys.argv[6]) # Initial frame
istop=int(sys.argv[7]) # Ending frame
if istop<istart:
	istop=None

## create peptoid and water selections
#peptoid=u.select_atoms('resname ACE MEGP LYPP GLPP')
peptoid=u.select_atoms('resname DAH GLU LYS PHE')
#peptoid_O=u.select_atoms('resname ACE MEGP LYPP GLPP and name O')
peptoid_O=u.select_atoms('resname  DAH GLU LYS PHE and name O')
water=u.select_atoms('resname SOL')
#peptoid_sel='resname ACE SARP MEGP LYPP GLPP LYS DAH and name O OG OE OE1 OE2 OZ NZ N HE HE1 HZ HZ1 HZ2 HZ3'
#peptoid_sel='resname  DAH GLU LYS PHE and name O OG OE OE1 OE2 OZ NZ N HE HE1 HZ HZ1 HZ2 HZ3'
peptoid_sel='resname  DAH GLU LYS PHE and name OZ OE2 OE1 O NZ N HZ3 HZ2 HZ1 HZ HNT HN'
#peptoid_O_sel='resname ACE SARP MEGP LYPP GLPP LYS DAH and name O'
peptoid_O_sel='resname  DAH GLU LYS PHE and name O'

#h=MDAnalysis.analysis.hbonds.HydrogenBondAnalysis(u,peptoid_sel,'resname SOL',detect_hydrogens='heuristic',start=istart,stop=istop)
h=MDAnalysis.analysis.hbonds.HydrogenBondAnalysis(u,peptoid_sel,'resname SOL',detect_hydrogens='heuristic',angle=150)

h.run(start=istart,stop=istop)
h.generate_table()
data_frame=pd.DataFrame.from_records(h.table)
#print (data_frame)
#print (data_frame["donor_index"])
#data_frame.to_csv(sys.argv[3])

################################
# Separeate box in z direction #
################################
box_dim=u.dimensions
#print ("size in z (A):", box_dim[2])
# bin size, A
bin=float(sys.argv[5])
#
CellNum=int(box_dim[2]/bin)
#print ("CellNum: ", CellNum)
timesteps=data_frame.time.unique()
#print ("timesteps: ", timesteps)
#print ("len(timesteps): ", len(timesteps))
CellSize=(len(timesteps),CellNum+1)
#print (CellSize)
CellHbd=np.zeros(CellSize)
#print (CellHbd)
###########   END   ############
#
########################################
# Add coordinate of donor and acceptor #
########################################
HbdPosMar=[]
for row in data_frame.itertuples():
#	print (getattr(row,'donor_index'), getattr(row,'acceptor_index'))
	DonAtoNum=getattr(row,'donor_index')
	AceAtoNum=getattr(row,'acceptor_index')
	DonAtoPos=u.select_atoms("index " + str(DonAtoNum))
	AceAtoPos=u.select_atoms("index " + str(AceAtoNum))
#	print (DonAtoPos.positions[0])
#	print (AceAtoPos.positions)
	HbdPos=(DonAtoPos.positions+AceAtoPos.positions)/2
#	print (HbdPos[0])
	HbdPosMar.append(HbdPos[0])
#print (HbdPosMar)
HbdPosMar2=np.array(HbdPosMar)
#print (HbdPosMar2)
df2=pd.DataFrame(HbdPosMar2)
df2.columns=['x','y','z']
#print (df2)
dfcat=pd.concat([data_frame,df2],axis=1)
#print (dfcat)
# Output
dfcat.to_csv(sys.argv[3])
#############    END    ################
#
###############################
# Distribute Hbond into Cells #
###############################
t=dfcat['time']
AccInd=dfcat['acceptor_index']
DonInd=dfcat['donor_index']
AccName=dfcat['acceptor_atom']
DonName=dfcat['donor_atom']
x=dfcat['x']
y=dfcat['y']
z=dfcat['z']

i=0
for tt,aa,dd,an,dn,xx,yy,zz in zip(t,AccInd,DonInd,AccName,DonName,x,y,z):
	if tt in CellHbd[i-1]:
#		print (CellHbd)
		HbdCellNo=int(zz/bin)
#		print (HbdCellNo)
		CellHbd[i-1][HbdCellNo]+=1
#		print (zz)
	else:
		if i==0:
			CellHbd[i][0]=tt
			i+=1
			HbdCellNo=int(zz/bin)
			CellHbd[i-1][HbdCellNo]+=1
		else:
			i+=1
			CellHbd[i-1][0]=tt
			HbdCellNo=int(zz/bin)
			CellHbd[i-1][HbdCellNo]+=1
#print (CellHbd)
df_hbdZ=pd.DataFrame(CellHbd)
#Cell2dis=np.arange(0,CellNum)*bin
Cell2dis=list(range(0,CellNum))
for i in Cell2dis:
	Cell2dis[i]=i*bin+bin/2
#print (Cell2dis)
Cell2dis.insert(0,"time")
#print (Cell2dis)
df_hbdZ.columns=Cell2dis
#print (df_hbdZ)
# Output
df_hbdZ.to_csv(sys.argv[4])





