#!/opt/local/bin/python
# python 3.6
# 1. Calculate the hbond between waters and every residues.
# 2. Two outfile is the histogram of hbond(water - every residues) and hbond(water-type of residues)
# 3. For multipule chains, use sep.py to separate residues into groups.
# python + py_file + tpr_file + csv_file + outfile1 + outfile2 + residue number + chain number + elements
# python xxx.py xxx.tpr xxx.csv 1.dat 2.dat 20 30 OZ OE2 OE1 O NZ N HZ3 HZ2 HZ1 HZ HNT HN

import numpy, pandas, MDAnalysis, collections, sys, os

#nhbond_max=20
nhbond_max=100 # The maxmun of hydrogen bonds, to generate histograms (maxmun of the histogram x axial).

## set number of residues, chains, etc
## do this first because I always forgot and
## this will make it fail sooner
nResChain=int(sys.argv[5])
nChain=int(sys.argv[6])
nRes=nChain*nResChain

## read in configuration (needed pnly for getting indices of acceptor atoms)
## and pandas data frame
u=MDAnalysis.Universe(sys.argv[1])
data_frame=pandas.read_csv(sys.argv[2])

## extract ids for acceptors and create look up dictionary
print ("extracting acceptor/donor ids")
acc_sel='name'
acc_names=sys.argv[7:]
for acc in acc_names:
    acc_sel=acc_sel+' '+acc
acceptors=u.select_atoms(acc_sel)
nacc=len(acceptors)

resnames=acceptors.residues.resnames

histogram_dict={}
for resname in set(acceptors.residues.resnames):
    print (resname)
    histogram_dict[resname]=numpy.zeros((nhbond_max+1))

acc_id=[]
id_to_res={}
for acc in acceptors:
    acc_id.append(acc.index)
    id_to_res[acc]=acc.resid


## get unique timesteps
timesteps=data_frame.time.unique()

## initialise arrays
nhbond_ave=numpy.zeros((nRes))
nhbond_sqr=numpy.zeros((nRes))
nsets=0

## extract columns from data frame
## and organise into dictionary
print ("extracting data")
t=data_frame['time']
acc=data_frame['acceptor_index']
dcc=data_frame['donor_index']
aname=data_frame['acceptor_atom']
dname=data_frame['donor_atom']
acc_dict={}

#print (t)
#os.system("pause")
#print (acc)
#os.system("pause")
#print (dcc)
#os.system("pause")
#print (aname)
#os.system("pause")
#print (dname)
#os.system("pause")

for tt,aa,dd,an,dn in zip(t,acc,dcc,aname,dname):

#    if acc_dict.has_key(tt):
    if tt in acc_dict:
        if an in acc_names:
            acc_dict[tt].append(aa)
        if dn in acc_names:
            acc_dict[tt].append(dd)
    else:
        if an in acc_names:
            acc_dict[tt]=[aa]
#            acc_dict[tt]=aa
        if dn in acc_names:
            acc_dict[tt]=[dd]
#            acc_dict[tt]=dd

#print (acc_dict)
#os.system("pause")
## loop over timesteps
print ("looping over timesteps")
for ts in timesteps:

    print (ts)
    ## tally up number of times each acceptor
    ## appears
    d=collections.Counter(acc_dict[ts])
    nhbond_step=numpy.zeros((nRes))
    
#    print (d)
#    os.system("pause")
#    nhbond_step=numpy.zeros(d)


    ## assign H-bonds to residues
    for acc in acceptors:

#        if d.has_key(acc.index):
        if acc.index in d:
            ires=id_to_res[acc]
            nhbond_step[ires-1] += d[acc.index]

    ## update averages
    nhbond_ave+=nhbond_step
    nhbond_sqr+=nhbond_step**2
    nsets+=1.0

    for ires in range(nRes):
        ibin=int(nhbond_step[ires])
        histogram_dict[resnames[ires]][ibin]+=1.0

## get final averages
nhbond_ave/=nsets
nhbond_sqr/=nsets
nhbond_std=numpy.sqrt(nhbond_sqr-nhbond_ave**2)

ouf=open(sys.argv[3],'w')
for ires in range(nRes):
    print (ires+1,nhbond_ave[ires],nhbond_std[ires],file=ouf)


ouf=open(sys.argv[4],'w')
print ('##',end=' ',file=ouf)
k=list(histogram_dict.keys())
k.sort()
for kk in k:
    print (kk,end=' ',file=ouf)
print ('',file=ouf)
#print >> ouf
for ihbond in range(nhbond_max+1):
    print (ihbond,end=' ',file=ouf)
    for kk in k:
        print (histogram_dict[kk][ihbond],end=' ',file=ouf)
    print (" ",file=ouf)
