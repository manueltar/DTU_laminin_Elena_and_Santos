#!/bin/bash

eval "$(conda shell.bash hook)"
 
  
Rscripts_path=$(echo "/home/manuel.tardaguila/Scripts/R/")

MASTER_ROUTE=$1
analysis=$2
RSEM_DIR=$3

##########################################################################

output_dir=$(echo "$MASTER_ROUTE""$analysis""/")

mkdir -p $output_dir

Log_files=$(echo "$output_dir""/""Log_files/")
 
mkdir -p $Log_files
 
### DTU at 

Threshold_ratio=$(echo '0.1')



type=$(echo "DTU_at_""$Threshold_ratio")
outfile_DTU=$(echo "$Log_files""outfile_1_""$type"".log")
touch $outfile_DTU
echo -n "" > $outfile_DTU
name_DTU=$(echo "$type""_job")


Rscript_DTU=$(echo "$Rscripts_path""501_DRIMSeq_DTU_vSantos.R")

sample_array=$(echo 'LM411_R1_t0,LM411_R2_t0,LM411_R3_t0,LM411_R1_t1,LM411_R2_t1,LM411_R3_t1,LM411_R1_t2,LM411_R2_t2,LM411_R3_t2,LM411_R1_t3,LM411_R2_t3,LM411_R3_t3,LM411_R1_t4,LM411_R2_t4,LM411_R3_t4,LM511_R1_t0,LM511_R2_t0,LM511_R3_t0,LM511_R1_t1,LM511_R2_t1,LM511_R3_t1,LM511_R1_t2,LM511_R2_t2,LM511_R3_t2,LM511_R1_t3,LM511_R2_t3,LM511_R3_t3,LM511_R1_t4,LM511_R2_t4,LM511_R3_t4')


mem=$(echo "4096")
processors=$(echo "16")
total_memory=$(( mem * processors ))

echo "$processors"
echo "$total_memory"

# 15 8192
 
myjobid_DTU=$(sbatch --job-name $name_DTU --output=$outfile_DTU --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=$processors --mem-per-cpu=$mem --parsable --wrap="Rscript $Rscript_DTU --RSEM_DIR $RSEM_DIR --Threshold_ratio $Threshold_ratio --sample_array $sample_array --processors $processors --total_memory $total_memory --type $type --out $output_dir")
myjobid_seff_DTU=$(sbatch --dependency=afterany:$myjobid_DTU --open-mode=append --output=$outfile_DTU --job-name="seff" --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=1 --mem-per-cpu=128M --parsable --wrap="seff $myjobid_DTU >> $outfile_DTU")

conda deactivate

