#!/bin/bash

eval "$(conda shell.bash hook)"
 

MASTER_ROUTE=$1
analysis=$2
reference_fasta=$3
path_to_rsem_ref=$4 #"/scratch/manuel.tardaguila/rsem_Ref/hg38_rsem"


trimmed_dir=$(echo "/group/soranzo/manuel.tardaguila/Bulk_RNA_seq/Santos/fastq/")




output_dir=$(echo "$MASTER_ROUTE""$analysis""/")

mkdir -p $output_dir

Log_files=$(echo "$output_dir""/""Log_files/")


mkdir -p $Log_files

sample_array=$(echo 'LM411_R1_t0,LM411_R2_t0,LM411_R3_t0,LM411_R1_t1,LM411_R2_t1,LM411_R3_t1,LM411_R1_t2,LM411_R2_t2,LM411_R3_t2,LM411_R1_t3,LM411_R2_t3,LM411_R3_t3,LM411_R1_t4,LM411_R2_t4,LM411_R3_t4,LM511_R1_t0,LM511_R2_t0,LM511_R3_t0,LM511_R1_t1,LM511_R2_t1,LM511_R3_t1,LM511_R1_t2,LM511_R2_t2,LM511_R3_t2,LM511_R1_t3,LM511_R2_t3,LM511_R3_t3,LM511_R1_t4,LM511_R2_t4,LM511_R3_t4')


a=($(echo "$sample_array" | tr "," '\n'))


declare -a arr

array_2_length=${#a[@]}

for (( i=0; i<${array_2_length}; i=i+1 ));
do

    sample_array_sel=${a[$i]}
    echo "$sample_array_sel"


    prefix=$(echo "$output_dir""$sample_array_sel""_")


    echo "1 $prefix"

    r1_TRIMMED=$(echo "$trimmed_dir""$sample_array_sel""_""1.fq.gz")

    r2_TRIMMED=$(echo "$trimmed_dir""$sample_array_sel""_""2.fq.gz")

    echo "R1: $r1_TRIMMED"
    echo "R2: $r2_TRIMMED"



    ################## STAR alingment  #######################################################################################

     type=$(echo "$sample_array_sel""_STAR_alingment")
     outfile_STAR_alingment=$(echo "$Log_files""outfile_1_""$type"".log")
     touch $outfile_STAR_alingment
     echo -n "" > $outfile_STAR_alingment
     name_STAR_alingment=$(echo "$type""_job")
     seff_name=$(echo "seff""_""$type")

     processors=$(echo '8')
     mem=$(echo '4096')
     total_memory=$(echo "scale=0; ($mem / 1) * $processors" | bc)
     total_memory=$(echo "$total_memory""M")

     echo "$total_memory"

    myjobid_STAR_alingment=$(sbatch --job-name=$name_STAR_alingment --output=$outfile_STAR_alingment --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=$processors --mem-per-cpu=$mem --parsable --wrap="module load STAR/2.7.10a && STAR  \
    							    				 		  		  	    				  		      --runMode alignReads \
                                                                                                                                                                                      --genomeDir $reference_fasta \
                                                                                                                                                                                      --readFilesIn $r1_TRIMMED $r2_TRIMMED \
    																						      --runThreadN $processors \
    																						      --outFileNamePrefix $prefix \
    																						      --quantMode TranscriptomeSAM \
    																						      --outSAMtype BAM SortedByCoordinate \
    																						      --outSAMattributes NH HI AS nM \
    																						      --readFilesCommand zcat")

    myjobid_seff_STAR_alingment=$(sbatch --dependency=afterany:$myjobid_STAR_alingment --open-mode=append --output=$outfile_STAR_alingment --job-name=$seff_name --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=1 --mem-per-cpu=128M --parsable --wrap="seff $myjobid_STAR_alingment >> $outfile_STAR_alingment")


     ################## rsem_step  #######################################################################################

     type=$(echo "$sample_array_sel""_rsem_step")
     outfile_rsem_step=$(echo "$Log_files""outfile_2_""$type"".log")
     touch $outfile_rsem_step
     echo -n "" > $outfile_rsem_step
     name_rsem_step=$(echo "$type""_job")
     seff_name=$(echo "seff""_""$type")

     processors=$(echo '16')
     mem=$(echo '4096')
     total_memory=$(echo "scale=0; ($mem / 1) * $processors" | bc)
     total_memory=$(echo "$total_memory""M")

     echo "$total_memory"


     input_bam=$(echo "$prefix""Aligned.toTranscriptome.out.bam")
     sample_quant=$(echo "$sample_array_sel""_""Quant")
     rsem_dir=$(echo "$prefix""rsem_quantification""/")

     mkdir -p $rsem_dir

     echo $rsem_dir

     # --dependency=afterany:$myjobid_STAR_alingment

     myjobid_rsem_step=$(sbatch --dependency=afterany:$myjobid_STAR_alingment --job-name=$name_rsem_step --output=$outfile_rsem_step --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=$processors --mem-per-cpu=$mem --parsable --wrap="conda run -p /home/manuel.tardaguila/conda_envs/rsem rsem-calculate-expression --num-threads $processors --paired-end --alignments --temporary-folder $rsem_dir $input_bam $path_to_rsem_ref $sample_quant")
     

    myjobid_seff_rsem_step=$(sbatch --dependency=afterany:$myjobid_rsem_step --open-mode=append --output=$outfile_rsem_step --job-name=$seff_name --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=1 --mem-per-cpu=128M --parsable --wrap="seff $myjobid_rsem_step >> $outfile_rsem_step")





done


