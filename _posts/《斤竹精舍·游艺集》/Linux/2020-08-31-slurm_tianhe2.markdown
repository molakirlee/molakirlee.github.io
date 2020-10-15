---
layout:     post
title:      "slurm&天河二号使用"
subtitle:   ""
date:       2020-08-31 15:27:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Linux
    - 2020

---
 
### 常用指令
1. 任务管理系统使用的是slurm，差别就是把slurm命令中的s替换成yh，得到 yhrun、yhbatch、yhqueue 等一系列命令。
1. 查看节点状态：`yhi`
1. 提交命令：`yhbatch`，具体使用方法参见slurm文件； 
1. 已用机时：`time`；
1. 查看正在运行的序列：`yhq`；
1. 取消作业： `yhcancel job_ID`
1. 作业用量查询：`yhreport  Cluster AccountUtilizationByUser start=1/1/15 end=now -t hour user=用户账号`；
1. 查看已用机时：`yhreport Cluster UserUtilizationByAccount -t hour start=1/5/20 end=now


### slurm文件说明

1. -p: 任务运行分区。可用分区通过yhi命令查看。
1. -N: 节点数。希望作业运行在几个节点上。
1. -n: 任务数。在MPI作业中，即进程数。（在非MPI作业中，如非mpi版gmx中，要指定其为1？）
1. -c: 每个任务需要ncpus 个处理器核，该值默认为1，非openMP程序一般用不到，指定了也不影响运行。
1. -x: 不给哪些节点分配给作业--exclude=node name list 
1. -w: 分配给哪些节点--nodelist=node name list

1. yhrun的执行效果和mpirun一致。
1. 天河2是独享作业，当一个节点上已经被分配出去之后，即便没有使用全部的核心，也无法继续提交作业，所以**计费也是以节点为基本单元计算核时！！**


### slurm示例

###### gromacs without MPI
job_gmx2019.slurm
```
#!/bin/bash

###########################################################################################
# gromacs_2019.6: yhbatch ./job.slurm jobname (such as:  yhbatch ./job.slurm nvt_30ns)    #
###########################################################################################


#SBATCH -p qnyh         # Queue
#SBATCh -N 1            # Node count required for the job
#SBATCH -n 1            # Number of tasks to be launched
#SBATCH -J Oxygen       # Job name
#SBATCH -o %J.out       # Standard output
#SBATCH -e %J.err       # File in which to store job error messages
#SBATCH -x cn1147       # Do not distribute task to node: cn1147


export LC_ALL=C
export I_MPI_FABRICS=shm:tcp
echo 'For you, a thousand times over!  --for HAN'


# gromacs 2019.6
BASENAME=$1
#------ No-MPI version ------
gmx mdrun -v -deffnm $1 -ntmpi 4 -pin on
```

###### gromacs with MPI
job_gmx2019_mpi.slurm
```
#!/bin/bash

###########################################################################################
# gromacs_2019.6: yhbatch ./job.slurm jobname (such as:  yhbatch ./job.slurm nvt_30ns)    #
###########################################################################################


#SBATCH -p qnyh         # Queue
#SBATCh -N 1            # Node count required for the job
#SBATCH -n 2            # Number of tasks to be launched
#SBATCH -c 12           # Number of cpu per task
#SBATCH -J Oxygen       # Job name
#SBATCH -o %J.out       # Standard output
#SBATCH -e %J.err       # File in which to store job error messages
#SBATCH -x cn1147       # Do not distribute task to node: cn1147


export LC_ALL=C
export I_MPI_FABRICS=shm:tcp
echo 'For you, a thousand times over!  --for HAN'


# gromacs 2019.6
BASENAME=$1
#------ MPI version ------
yhrun gmx_mpi mdrun -v -deffnm $1 
```

###### Attachments
1. [job_gmx2019.slurm](https://molakirlee.github.io/attachment/linux/job_gmx2019.slurm)
1. [job_vasp.slurm](https://molakirlee.github.io/attachment/linux/job_vasp.slurm)

### 参考资料
1. [单个节点上提交多个作业](https://blog.chembiosim.com/task-manage-in-Tianhe2/)
1. [TH-2 用户手册](http://www.nscc-gz.cn/userfiles/files/nsccth2sc.pdf)

![](/img/wc-tail.GIF)
