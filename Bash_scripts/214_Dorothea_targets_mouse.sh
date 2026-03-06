#!/bin/bash
  
MASTER_ROUTE=$1
analysis=$2


Rscripts_path=$(echo "/home/manuel.tardaguila/Scripts/R/")
module load R/4.1.0


bashrc_file=$(echo "/home/manuel.tardaguila/.bashrc")

source $bashrc_file
eval "$(conda shell.bash hook)"


output_dir=$(echo "$MASTER_ROUTE""$analysis""/")

mkdir -p $output_dir

Log_files=$(echo "$output_dir""/""Log_files/")

mkdir -p $Log_files


#### Dorothea_extraction ###################################

Dorothea_confidence_array=$(echo 'A,A_B,A_B_C,A_B_C_D,A_B_C_D_E')

a=($(echo "$Dorothea_confidence_array" | tr "," '\n'))

 declare -a arr

 for i  in "${a[@]}"
 do

     Dorothea_confidence_array_sel=$i
     echo "$Dorothea_confidence_array_sel"

     type=$(echo "Dorothea_""$Dorothea_confidence_array_sel""_extraction""_""$analysis")
     outfile_Dorothea_extraction=$(echo "$Log_files""outfile_0_""$type"".out")
     touch $outfile_Dorothea_extraction
     echo -n "" > $outfile_Dorothea_extraction
     name_Dorothea_extraction=$(echo "$type""_job")
     seff_name=$(echo "seff""_""$type")

     Rscript_Dorothea_extraction=$(echo "$Rscripts_path""515_Dorothea_TF_all_TFs_mouse_Elena.R")


     myjobid_Dorothea_extraction=$(sbatch --job-name=$name_Dorothea_extraction --output=$outfile_Dorothea_extraction --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=2 --mem-per-cpu=1024M --parsable --wrap="Rscript $Rscript_Dorothea_extraction --Dorothea_confidence $Dorothea_confidence_array_sel --type $type --out $output_dir")
     myjobid_seff_Dorothea_extraction=$(sbatch --dependency=afterany:$myjobid_Dorothea_extraction --open-mode=append --output=$outfile_Dorothea_extraction --job-name=$seff_name --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=1 --mem-per-cpu=128M --parsable --wrap="seff $myjobid_Dorothea_extraction >> $outfile_Dorothea_extraction")

done


