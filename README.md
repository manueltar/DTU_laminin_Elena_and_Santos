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

# 8. The EXP1/TPM_Counts_Subset.tsv file has the TPM values for the following genes:

Adipor1,Akap8l,Arap1,Arhgdib,Arhgef39,Ascc1,Atxn7l1,Aurkaip1,Bcl2l1,Brd2,Cage1,Cdk2ap2,Chmp2a,Cic,Ctsc,Ctsw,Cyrib,Cyth1,Dcaf11,Derl2,Dgcr6,Dicer1,Dnah10,Dnajb5,Dnajc5,Dusp22,Dynlt1f,E130317F20Rik,Eed,Eif2s3y,Eif4a2,Entpd5,Exoc4,Fbxw11,Fosb,Fubp3,Furin,Fxyd5,Fyn,gene_name,Ggnbp1,Gm1043,Gm11423,Gm12258,Gmfg,Golga4,Gpcpd1,Gramd3,Gvin2,Hdlbp,Hnrnph2,Idh3a,Ikzf4,Il6st,Kansl1,Kcmf1,Kmt2b,Lcorl;Gm3414,Lmf1,Loxl3,Map7,Mcm9,Med12l,Mettl15,Mtmr7,Myo7a,NA,Nab2,Nbeal2,Ndufb1,Nedd9,Nfatc1,Nfkbiz,Nin,Nkapd1,Nr4a1,Nrn1,Nsd3,Nupl1,Nxf1,Ocel1,Ogdh,Oxr1,Pdcd6ip,Pde11a,Pign,Pla2g4c,Plekhj1,Polr1d,Prkar1a,Psmb10,Ptprc,Rabep1,Rasgrp2,Rbl1,Rbm33,Rer1,Rgs3,Rnasel,Rps6ka3,Rps9,Rptor,Scamp1,Sec31a,Shisa5,Sigirr,Sin3b,Sla,Slc25a32,Slc27a1,Slc38a1,Smad2,Sp100,Srek1,St6gal1,Stard9,Stat1,Stk11,Stx3,Sulf2,Susd3,Tbc1d25,Tex264,Themis,Tm6sf1,Tm9sf3,Tnfaip3,Tnfaip8,Tnrc6b,Trim33,Trim46,Triobp,Ttc39b,U2af2,Ube3a,Unc13d,Wapl,Yae1d1,Zbtb38,Zbtb44,Zdhhc21,Zfp287,Zgpat,Zmym2

# 9. Script to extract all target genes at different levels of condifence for mouse TFs in Dorothea

$ bash ~/Scripts/Wraper_scripts/214_Dorothea_targets_mouse.sh /group/soranzo/manuel.tardaguila/Bulk_RNA_seq/Santos/Reanalysis_2025/ Elena_mouse_Dorothea

