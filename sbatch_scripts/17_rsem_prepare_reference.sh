#!/bin/bash
#SBATCH --job-name=rsem_indexing_STAR
#SBATCH --mail-type=ALL
#SBATCH --mail-user=manuel.tardaguila@fht.org
#SBATCH --partition=cpuq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --output=rsem_indexing_%j.log
#SBATCH --mem=32G
#SBATCH --time=36:00:00
 
eval "$(conda shell.bash hook)"

conda activate /home/manuel.tardaguila/conda_envs/rsem/

echo "========================"
echo "Initiated: $(date)"

# Use clear variable names for clarity/debugging:
output_dir="$1"
reference_genome="$2"
reference_gtf="$3"
reference_prefix="$4" # The final name for the reference files, e.g., "hg38_rsem"

# Check if all required arguments were provided
if [ -z "$reference_prefix" ]; then
    echo "ERROR: Missing arguments. Usage: sbatch <script> <out_dir> <genome_fasta> <gtf_file> <reference_name>"
    exit 1
fi

rm -rf "$output_dir"
mkdir -p "$output_dir"

# The final RSEM prefix (e.g., /path/to/RSEM_Ref/hg38_rsem)
RSEM_REFERENCE_PATH="${output_dir}/${reference_prefix}"

rsem-prepare-reference \
    -p 8 \
    --gtf "$reference_gtf" \
    "$reference_genome" \
    "$RSEM_REFERENCE_PATH"

echo "========================"
echo "Completed: $(date)"
