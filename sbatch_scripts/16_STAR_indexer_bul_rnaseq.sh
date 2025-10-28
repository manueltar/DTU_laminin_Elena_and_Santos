#!/bin/bash
#SBATCH --job-name=STAR_indexing
#SBATCH --mail-type=ALL
#SBATCH --mail-user=manuel.tardaguila@fht.org
#SBATCH --partition=cpuq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --output=STAR_indexing_%j.log
#SBATCH --mem=64G
#SBATCH --time=36:00:00

module load STAR

echo "========================"
echo "Initiated: $(date)"

output_dir=$1

mkdir -p $output_dir

reference_genome=$2
reference_gtf=$3


STAR --runMode genomeGenerate \
     --genomeDir $output_dir \
     --genomeFastaFiles $reference_genome \
     --sjdbGTFfile $reference_gtf \
     --runThreadN 16 \
     --sjdbOverhang 99



echo "========================"
echo "Completed: $(date)"



