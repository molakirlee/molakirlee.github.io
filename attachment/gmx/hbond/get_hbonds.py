#!/opt/local/bin/python
# python 3.6
# python + py_file + tpr_file + trj_file + outfile + start_frame + end_frame
# python get_hbonds.py xxx.tpr xxx.xtc xxx.csv 290 301
# from configure(traj) frame 290 to frame 300, csv is out of pandas frame

import sys, numpy, pandas
import MDAnalysis, MDAnalysis.analysis.hbonds

## get input file names and read in data
groFile=sys.argv[1]
xtcFile=sys.argv[2]

u=MDAnalysis.Universe(groFile,xtcFile)

istart=int(sys.argv[4]) # Initial frame
istop=int(sys.argv[5]) # Ending frame
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
data_frame=pandas.DataFrame.from_records(h.table)
data_frame.to_csv(sys.argv[3])
