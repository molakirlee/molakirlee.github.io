#!/bin/bash

###########################################################################################
#                                                                                         #
# This script is used to sub VASP, Gaussian, LAMMPS, CASTEP, & DMol3 jobs.                #
# Author: Xilock                                                                          #
# Updated Date: 2020.08.31                                                                #
# Usage: Choose the queue, jobname, and number of core, especially JOBTYPE.               #
#        yhbatch ./job.slurm  ([yhbatch ./job.slurm jobname]for CASTEP)                   #
#                                                                                         #
# gromacs_2019.3: yhbatch ./job.slurm jobname (such as:  yhbatch ./job.slurm nvt_30ns)    #
###########################################################################################


#SBATCH -p qnyh         # Queue
#SBATCh -N 1            # Node count required for the job
#SBATCH -n 24           # Number of tasks to be launched
#SBATCH -J Oxygen           # Job name
#SBATCH -o %J.out       # Standard output
#SBATCH -e %J.err       # File in which to store job error messages


JOBTYPE='VASP54'
                     #  'VASP54', 'vasp_std', 'vasp_gam', 'vasp_ncl', &
                     #  'QE64', 'CP2K', 'gromacs2019', 'LAMMPS', 'CASTEP_80', 'DMol3_80'

VASP54EXE='/THFS/opt/vasp/5.4.4_neb/vasp.5.4.4/bin/vasp_std'
CASTEP_80EXE='/THFS/home/shu_lyh/Accelrys/MaterialsStudio8.0/etc/CASTEP/bin/RunCASTEP.sh'
DMOL3_80EXE='/THFS/home/shu_lyh/Accelrys/MaterialsStudio8.0/etc/DMol3/bin/RunDMol3.sh'
LAMMPSEXE='/THFS/opt/lammps/lammps-11Aug17/src/lmp_intel_cpu_mpich'
QE64EXE='/THFS/opt/qe/qe-6.4/bin/ph.x'
CP2KEXE='/THFS/opt/cp2k/4.1/cp2k-4.1/exe/Linux-x86-64-intel-host/cp2k.popt'
#GROMACSEXE='/THFS/opt/gromacs/2019.3/bin/gmx_mpi'
GROMACSEXE='/THFS/opt/gromacs/2019.3/bin/mdrun_mpi'

export LC_ALL=C
export I_MPI_FABRICS=shm:tcp
echo 'For you, a thousand times over!  --for HAN'

case $JOBTYPE in
    VASP54 )
        # VASP 5.4.4
  
		export LD_LIBRARY_PATH=/THFS/opt/intel/composer_xe_2013_sp1.3.174/mkl/lib/intel64:/THFS/opt/intel/composer_xe_2013_sp1.3.174/compiler/lib/intel64:$LD_LIBRARY_PATH
		# yhrun -N 1 -p free -n 24 $VASP54EXE
		yhrun $VASP54EXE
  
        ;;
    LAMMPS )
        # LAMMPS 16Mar2018 version
        export LD_LIBRARY_PATH=/THFS/opt/lammps/lammps-11Aug17/src/jpeg-v8c/lib:/THFS/opt/intel/composer_xe_2013_sp1.3.174/compiler/lib/intel64:/THFS/opt/MPI/mpich3.2-icc/lib:$LD_LIBRARY_PATH
        yhrun $LAMMPS -in in.ZnO
        ;;
	QE64 )
        # QE-6.4n
        export LD_LIBRARY_PATH=/THFS/opt/intel/intel15.2/composer_xe_2015.2.164/mkl/lib/intel64:/THFS/opt/qe/qe-6.4:$LD_LIBRARY_PATH
        yhrun $QE64EXE <ph.in>ph.out
        ;;
	CP2K )
        # CP2K-4.1
        export LD_LIBRARY_PATH=/THFS/opt/intel/composer_xe_2015.2.164/compiler/lib/intel64:$LD_LIBRARY_PATH
		yhrun $CP2KEXE -in cp2k.inp
        ;;
	gromacs2019 )
        # gromacs 2019.3
        BASENAME=$1
        source /THFS/opt/gromacs/2019.3/bin/GMXRC
		export PATH=/THFS/opt/gromacs/2019.3/bin:$PATH
		export LD_LIBRARY_PATH=/THFS/opt/intel/18_1/compilers_and_libraries_2018.0.128/linux/mkl/lib/intel64_lin:/THFS/opt/intel/18_1/compilers_and_libraries_2018.0.128/linux/mpi/intel64/lib:/THFS/opt/intel/18_1/compilers_and_libraries_2018.0.128/linux/compiler/lib/intel64:$LD_LIBRARY_PATH
		export LD_LIBRARY_PATH=/THFS/opt/gcc/5.2/lib64/:$LD_LIBRARY_PATH
		yhrun $GROMACSEXE -v -deffnm $1
        ;;
    CASTEP_80 )
        # Materials Studio 8.0

		BASENAME=$1

		yhrun -p free -N $SLURM_JOB_NUM_NODES -n $SLURM_TASKS_PER_NODE hostname > .names.log

		awk -v iPROCS_PER_NODE="$SLURM_TASKS_PER_NODE" '{print $1":"iPROCS_PER_NODE}' .names.log > ./machines.LINUX
		cat .names.log > mpd.hosts
		export DSD_MachineList="./machines.LINUX"
		export DSD_NumProc=$NSLOTS

		$CASTEP_80EXE -np $SLURM_NPROCS $BASENAME
        ;;
    DMol3_80 )
        # Materials Studio 8.0
        echo "Started at `date`" >> jobinfo.txt
        $DMOL3_80EXE -np $ncpus $LSB_JOBNAME
        echo "Completed at `date`" >> jobinfo.txt
        ;;
    * )
        echo "Error: JOBTYPE is invalid."
        ;;
esac
