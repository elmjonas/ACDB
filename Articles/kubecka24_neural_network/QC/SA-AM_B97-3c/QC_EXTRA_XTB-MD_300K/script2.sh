#!/bin/bash
file=task$SLURM_ARRAY_TASK_ID.txt
length=`cat $file | wc -l`
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
export LD_LIBRARY_PATH=/home/kubeckaj/Applications/orca_5_0_4_linux_x86-64_shared_openmpi411/
module load gcc; module load openmpi 2>/dev/null

for i in `seq 1 $length`
do
  xyz=`head -n $i $file | tail -n 1`
  base=$(basename $xyz .xyz)
  mkdir $base
  cd $base
  fl=`cat ../../STRUCTURES/$xyz | wc -l`
  flM2=`echo $fl-2 | bc`
  echo """! MD XTB1
%md
  Timestep 0.1_fs # This is a comment
  Initvel 300_K
  Thermostat NHC 300_K Timecon 10.0_fs
  Dump Position Stride 200 Filename \"trajectory.xyz\"
  Run 1000
end
%PAL NPROCS 1 END
%maxcore 3000
* xyz 0 1""" > input.inp
  tail -n $flM2 ../../STRUCTURES/$xyz >> input.inp
  echo "*" >> input.inp

  #CREATING WORKING DIRECTORY
  if [ ! -d /scratch/$SLURM_JOB_ID/TMP ]; then mkdir /scratch/$SLURM_JOB_ID/TMP; fi
  ADD=""
  test=0
  while [ $test -eq 0 ]
  do
    CALC_NAME=/scratch/$SLURM_JOB_ID/TMP/ORCA${SLURM_JOBID}_$base${ADD}
    if [ -d $CALC_NAME ]; then ADD="_${RANDOM}"
    else test=1;fi
  done

  mkdir $CALC_NAME
  CDIR=$PWD
  cp input.inp $CALC_NAME/
  cd $CALC_NAME
  /home/kubeckaj/Applications/orca_5_0_4_linux_x86-64_shared_openmpi411//orca input.inp > $CDIR/result.out 2> $CDIR/result.out
  cp trajectory.xyz $CDIR/
  cd $CDIR
  rm -rf $CALC_NAME

  cd ..
done

