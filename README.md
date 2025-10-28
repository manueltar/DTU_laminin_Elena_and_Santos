# path saved: /group/soranzo/manuel.tardaguila/Bulk_RNA_seq/Santos/Reanalysis_2025/
# scratch path: /scratch/manuel.tardaguila/Santos/

# 1. Index genomes with STAR and rsem (Mus_musculus.GRCm39.115)

$ sbatch ~/Scripts/sbatch/16_STAR_indexer_bul_rnaseq.sh /scratch/manuel.tardaguila/Santos/STAR_indexed_genome/ /scratch/manuel.tardaguila/Santos/Mus_musculu\
s.GRCm39.dna.primary_assembly.fa  /scratch/manuel.tardaguila/Santos/Mus_musculus.GRCm39.115.gtf



$ sbatch ~/Scripts/sbatch/17_rsem_prepare_reference.sh \
    /scratch/manuel.tardaguila/Santos/rsem_Ref \
    /scratch/manuel.tardaguila/Santos/Mus_musculus.GRCm39.dna.primary_assembly.fa \
    /scratch/manuel.tardaguila/Santos/Mus_musculus.GRCm39.115.gtf \
    m39_rsem


# 2. Align and quantify

$ bash ~/Scripts/Wraper_scripts/199_STAR_rsem_Santos.sh /scratch/manuel.tardaguila/Santos/ STAR_rsem /scratch/manuel.tardaguila/Santos/STAR_indexed_genome/ \
/scratch/manuel.tardaguila/Santos/rsem_Ref/m39_rsem

  (input fasta is here: /group/soranzo/manuel.tardaguila/Bulk_RNA_seq/Santos/fastq/)

# 3. MPI DTU model

$ bash ~/Scripts/Wraper_scripts/198_HPC_DTU_Santos.sh /group/soranzo/manuel.tardaguila/Bulk_RNA_seq/Santos/Reanalysis_2025/ EXP1 /group/soranzo/manuel.tarda\
guila/Bulk_RNA_seq/Santos/Reanalysis_2025/

# 4. DE analysis

-----------> Jupyter notebook: DE_DESeq2.ipynb

# 5. DTE analysis

-----------> Jupyter notebook: DTE_DESeq2_v2.ipynb

# 6. DTU annotation and exploration

-----------> Jupyter notebook: DTU_annotation_and_exploration.ipynb

# 7. Functional annotation and alignment

-----------> Jupyter notebook: DTU_annotation_and_exploration.ipynb

 ~/Scripts/R/502_gemini_solution_for_alignment_of_proteins.R
 ~/Scripts/R/503_gemini_solution_for_alignment_of_DNA.R


