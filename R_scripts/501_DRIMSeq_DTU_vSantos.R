.libPaths()

assign(".lib.loc", "/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/", envir = environment(.libPaths))
.libPaths()

suppressMessages(library("data.table", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("withr", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("ggplot2", lib.loc = "/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("farver", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("labeling", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("optparse", lib.loc = "/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("dplyr", lib.loc = "/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("withr", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("backports", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("broom", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("rstudioapi", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("tzdb", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("svglite", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("ggeasy", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("tidyverse", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("BiocGenerics", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("S4Vectors", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("IRanges", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("GenomeInfoDb", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("GenomicRanges", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("Biobase", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("AnnotationDbi", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("GO.db", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("org.Mm.eg.db", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("ggrepel", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("RColorBrewer", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("svglite", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("cowplot", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("Matrix", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("rtracklayer", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("Biostrings", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("ggrepel", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("ggarchery", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("ggnewscale", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("splitstackshape", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("viridis", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("ggsci",lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("plyr", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("ggupset", lib.loc = "/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("magrittr", lib.loc = "/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("DRIMSeq", lib.loc = "/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("tximport", lib.loc = "/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("readr", lib.loc = "/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
library("codetools", lib.loc = "/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/")
library("future", lib.loc = "/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/")
suppressMessages(library("furrr", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))

opt = NULL

options(warn = -1)


log_info_simple <- function(message) {
  timestamp <- format(Sys.time(), "[%Y-%m-%d %H:%M:%S]")
  cat(timestamp, "INFO:", message, "\n")
}


multiVals <- function(x) paste(x,collapse=";")


DRIMSeq_function = function(option_list)
{
  
  opt_in = option_list
  opt <<- option_list
  
  cat("All options:\n")
  printList(opt)
  
  #### READ and transform processors ----
  
  processors = as.numeric(opt$processors)
  
  cat("processors\n")
  cat(sprintf(as.character(processors)))
  cat("\n")
  
  #### READ and transform memory ----
  
  #### READ and transform total_memory (memory in MB) ----
  total_memory = as.numeric(opt$total_memory) # Corrected variable name to match bash script
  cat("Total Memory (MB) for global objects:", as.character(total_memory), "\n") # Improved log message
  
  #### Assign resources -------------
  
  log_info_simple("plan stage")
  
  # Set up parallel processing: 'multiprocess' works on a single machine across cores.
  # 'total_memory' is expected in MB from the bash script, convert to bytes for future.globals.maxSize.
  plan("multicore", workers = processors)
  options(future.globals.maxSize = total_memory * 1024^2) # Corrected: Convert MB to bytes
  
  
  
  #### READ and transform type ----
  
  type = opt$type
  
  cat("TYPE_\n")
  cat(sprintf(as.character(type)))
  cat("\n")
  
  #### READ and transform out ----
  
  out = opt$out
  
  cat("out_\n")
  cat(sprintf(as.character(out)))
  cat("\n")
  
  
  #### READ and transform sample_array ----
  
  sample_names = unlist(strsplit(opt$sample_array, split=","))
  
  cat("sample_names\n")
  cat(sprintf(as.character(sample_names)))
  cat("\n")
  
  #### READ and transform RSEM_DIR ----
  
  RSEM_DIR = opt$RSEM_DIR
  
  cat("RSEM_DIR_\n")
  cat(sprintf(as.character(RSEM_DIR)))
  cat("\n")
  
  #### READ and transform Threshold_ratio ----
  
  Threshold_ratio = opt$Threshold_ratio
  
  cat("Threshold_ratio_\n")
  cat(sprintf(as.character(Threshold_ratio)))
  cat("\n")
  
  ##### Define files vector ----
  
  # Define the sample information and file names
  files <- file.path(RSEM_DIR, paste0(sample_names, "_Quant.isoforms.results"))
  names(files) <- sample_names
  
  cat("files_0\n")
  str(files)
  cat("\n")
  
  ### check all files exist
  
  for(i in 1:length(files)){
    
    files_sel<-files[i]
    
    cat("--------------->\t")
    cat(sprintf(as.character(files_sel)))
    cat("\n")
    
    if(file.exists(files_sel)){
      
    }else{
      stop("Absent file")
    }
  }# i in 1:length(files)
  
  
  # ----------------------------------------------------------------------
  # 1. Import RSEM Transcript Counts
  # ----------------------------------------------------------------------
  
  message("1. Importing RSEM data using tximport...")
  # tximport extracts the raw estimated counts required by DRIMSeq
  txIn <- tximport(
    files,
    type = "rsem",
    txIn = TRUE, # Import transcript-level information
    txOut = TRUE, # <--- CRITICAL: Ensures the output is kept at the transcript level
    txIdCol = "transcript_id" # Uses the correct column name from the file header
  )
  
  cat("txIn\n")
  str(txIn)
  cat("\n")
  
  ### Read in genes as a separate object ----
  
  rsem_sample_file <- read_tsv(files[1], show_col_types = FALSE)  
  
  # 2. Create the tx2gene data frame
  # This MUST have two columns named 'feature_id' and 'gene_id' for DRIMSeq's internal logic.
  tx2gene_map <- rsem_sample_file %>%
    dplyr::select(feature_id = transcript_id, gene_id) %>%
    distinct()
  
  cat("tx2gene_map\n")
  str(tx2gene_map)
  cat("\n")
  
  ### Metadata dataframe ----
  
  sample_data <- data.frame(
    sample_id = sample_names,
    treat = factor(c("LM411", "LM411", "LM411","LM411", "LM411", "LM411","LM411", "LM411", "LM411","LM411", "LM411", "LM411","LM411", "LM411", "LM411",
                     "LM511", "LM511", "LM511","LM511", "LM511", "LM511","LM511", "LM511", "LM511","LM511", "LM511", "LM511","LM511", "LM511", "LM511"), 
                   levels = c("LM411", "LM511")),
    batch = c("R1","R2","R3","R1","R2","R3","R1","R2","R3","R1","R2","R3","R1","R2","R3","R1","R2","R3","R1","R2","R3","R1","R2","R3","R1","R2","R3","R1","R2","R3"),
    time = factor(c("t0","t0","t0","t1","t1","t1","t2","t2","t2","t3","t3","t3","t4","t4","t4","t0","t0","t0","t1","t1","t1","t2","t2","t2","t3","t3","t3","t4","t4","t4"), 
                   levels = c("t0", "t1","t2","t3","t4"))
  )
  
  cat("sample_data\n")
  str(sample_data)
  cat("\n")
  
  
  ## Convert the counts matrix into a data frame with transcript IDs as rows -----------------
  
  counts_df <- as.data.frame(txIn$counts) %>%
    tibble::rownames_to_column(var = "feature_id")
  
  cat("counts_df\n")
  str(counts_df)
  cat("\n")
  
  ## Merge the counts data frame with the gene_id information ---------------
  
  dm_input_data <- dplyr::inner_join(
    tx2gene_map,  
    counts_df,  
    by = "feature_id"
  )
  
  # Reorder the columns to place gene_id and feature_id first
  dm_input_data <- dm_input_data %>%
    dplyr::select(gene_id, feature_id, dplyr::everything())
  
  cat("dm_input_data_0\n")
  str(dm_input_data)
  cat("\n")
  
  # Filter for low fraction----
  
  min_samples_threshold <- 3
  
  message("2a. Implementing parallel proportion-based pre-filtering using furrr and saving proportions...")
  
  # --- START PARALLEL FILTERING BLOCK ---
  
  # Define the filtering function to apply to each gene's treat (list element)
  filter_gene_group <- function(gene_group, sample_names, threshold, min_samps) {
    
    # 🛑 CRITICAL CHECK: Return NULL immediately if the gene treat is empty.
    # This prevents calculations (like colSums) and selections on zero rows.
    if (nrow(gene_group) == 0) {
      return(NULL)
    }
    
    # Select only the sample count columns
    count_data <- gene_group %>% dplyr::select(all_of(sample_names))
    
    # 1. Calculate the proportion of the current transcript relative to the gene's total in each sample
    # Handling cases where the entire gene treat has zero counts across all samples
    gene_totals <- colSums(count_data)
    
    # Replace any zero totals with a small non-zero value (e.g., 1) to avoid division by zero (though colSums should be >0 for any gene passed here)
    gene_totals[gene_totals == 0] <- 1
    
    proportion_matrix <- t(t(count_data) / gene_totals)
    
    # Convert proportions back to a data frame with proper column names
    proportion_df <- as.data.frame(proportion_matrix) %>% 
      # Rename proportion columns for clarity (e.g., Prop_MCO_wt1)
      dplyr::rename_with(~ paste0("Prop_", .x), .cols = all_of(sample_names))
    
    # Combine original data with calculated proportions
    gene_group_with_props <- dplyr::bind_cols(gene_group, proportion_df)
    
    # 2. Define proportion column names explicitly for robust selection
    proportion_cols_explicit <- paste0("Prop_", sample_names)
    
    # 3. Create a column counting how many samples meet the proportion threshold
    # This counts rows where the proportion is >= threshold
    Samps_Above_Frac <- rowSums(proportion_df >= threshold)
    
    # 4. Filter the combined gene treat based on the threshold
    gene_group_filtered <- gene_group_with_props[Samps_Above_Frac >= min_samps, ]
    
    # 5. Select the necessary columns:
    if (nrow(gene_group_filtered) > 0) {
      return(gene_group_filtered %>% 
               dplyr::select(gene_id, feature_id, 
                             all_of(sample_names), 
                             all_of(proportion_cols_explicit),
                             Samps_Above_Frac 
               ))
    } else {
      # Return NULL if no transcripts pass filtering for this gene
      return(NULL)  
    }
  }
  
  # Split the data by gene_id for parallel processing
  dm_input_data_split <- dm_input_data %>%
    dplyr::group_by(gene_id) %>%
    dplyr::group_split()
  
  # Apply the filtering function in parallel using future_map
  dm_input_data_filtered_list <- furrr::future_map(
    dm_input_data_split,  
    ~filter_gene_group(
      .x,  
      sample_names = sample_names, # Pass the column names
      threshold = Threshold_ratio,  
      min_samps = min_samples_threshold
    ),
    .options = furrr::furrr_options(seed = TRUE)  
  )
  
  
  
  # 3. Combine the results back into a single data frame, dropping NULLs
  dm_input_data_combined <- dplyr::bind_rows(dm_input_data_filtered_list)
  
  # Separate the counts data frame (for DRIMSeq) from the proportions data frame (for saving)
  # 1. This contains the counts only, in data.frame format, for dmDSdata input.
  dm_input_data_filtered_df <- dm_input_data_combined %>%
    dplyr::select(gene_id, feature_id, all_of(sample_names)) %>%
    as.data.frame()
  
  cat("dm_input_data_filtered_df_0\n")  # <-- ADD THIS
  str(dm_input_data_filtered_df)       # <-- ADD THIS
  cat("\n")                            # <-- ADD THIS
  
  # 2. This contains counts + proportions + metadata (for saving)

  proportions_to_save_df <- dm_input_data_combined %>%
    dplyr::select(-dplyr::any_of("Samps_Above_Frac")) %>% # Safely remove temporary column
    as.data.frame()
  
  proportions_to_save_df$gene_id <- gsub("\\..+$", "", proportions_to_save_df$gene_id)
  
  proportions_to_save_df$gene_name <- mapIds(
    org.Mm.eg.db,
    keys = proportions_to_save_df$gene_id,
    keytype = "ENSEMBL",
    column = "SYMBOL",
    multiVals = multiVals
  )
  
  # Reorder columns to place gene_name next to gene_id/feature_id for clarity
  proportions_to_save_df <- proportions_to_save_df %>%
    dplyr::select(gene_id, gene_name, feature_id, dplyr::everything())
  
  # Add a cat/str check to ensure it worked
  cat("proportions_to_save_df_mapped\n")
  str(proportions_to_save_df)
  cat("\n")
  
  # Set the working directory for output files
  setwd(out)
  
  # SAVE FILTERED PROPORTIONS (Contains counts, proportions, and is filtered)
  write.table(proportions_to_save_df,  
              file = paste("DRIMSeq_DTU_filtered_output_",Threshold_ratio,".tsv", sep=''),  
              row.names = FALSE,  
              quote = FALSE,  
              sep = "\t")
  
  
  
  # Fallback method if accessor functions fail:
  genes_count <- length(unique(dm_input_data_filtered_df$gene_id))
  features_count <- length(unique(dm_input_data_filtered_df$feature_id))
  
  message(sprintf("     - Final state: %d genes and %d transcripts loaded.",
                  genes_count,  
                  features_count))
  
  
  ## DRIMSeq object -------------
  
  
  dm <- DRIMSeq::dmDSdata(
    counts = dm_input_data_filtered_df,  
    samples = sample_data)
  
  genes_count <- length(dm@counts@partitioning)
  features_count <- nrow(dm@counts@unlistData)
  message(sprintf("     - Initial state state: %d genes and %d transcripts remaining.",
                  genes_count,
                  features_count))
  
  # Filter out lowly expressed genes, transcripts and transcripts that makes less than 5% of gene expression output in three samples ----------------------
  
  message("2. Filtering low-expressed transcripts...")
  
  # Filters are set to ensure robust detection in at least 3 samples (our N)
  dm_filtered <- dmFilter(
    dm,
    min_samps_gene_expr = 3,       # Gene expressed (TPM>1 equivalent) in at least 3 samples
    min_gene_expr = 10,            # Gene has at least 10 counts in those 3 samples
    min_samps_feature_expr = 3,    # Transcript expressed in at least 3 samples
    min_feature_expr = 10)
  
  
  genes_count <- length(dm_filtered@counts@partitioning)
  features_count <- nrow(dm_filtered@counts@unlistData)
  message(sprintf("     - Initial state state: %d genes and %d transcripts remaining.",
                  genes_count,
                  features_count))
  
  
  # Modeling and testing DTU --------------------------
  
  message("3. Modeling and testing for DTU...")
  
  # Define the design matrix (comparing all samples to the 'ctrl' base level)
  design_full <- model.matrix(~ treat + time, data = samples(dm_filtered))
  
  # Estimate the dispersion/precision parameter (handles count overdispersion)
  dm_filtered <- dmPrecision(
    dm_filtered,
    design = design_full,
    BPPARAM = BiocParallel::MulticoreParam(workers = processors) # Adjust 'workers' based on available cores
  )
  
  # Model fiting --------------------------
  
  dm_filtered <- dmFit(dm_filtered, design = design_full,
                       BPPARAM = BiocParallel::MulticoreParam(workers = processors))
  
  # This is the safe, standard R way to get the column names
  design_coefficients <- colnames(design_full)
  
  message("     - Available Coefficients for dmTest:")
  print(design_coefficients)
  
  # Statistical test ---------------------------
  
  # Statistical test ---------------------------
  
  # The coefficient we want to test is 'treatLM511' (LM511 relative to LM411).
  # We MUST use the coefficient name that R generated.
  
  # Find the exact coefficient name for the treatment effect:
  treat_coef_name <- design_coefficients[grepl("^treat", design_coefficients)]
  # In an additive model (~ treat + time), this will be "treatLM511"
  
  if (length(treat_coef_name) != 1) {
    stop("Error: Could not uniquely identify the treatment coefficient. Check your factor levels.")
  }
  
  dm_filtered <- dmTest(
    dm_filtered,
    coef = treat_coef_name # This will be "treatLM511" assuming LM411 is the first level
  )
  message("    - Testing Treatment effect using coefficient:", treat_coef_name)
  message("    - Modeling and testing complete.")
  
  
  # Extract and Interpret Results -----------------------------
  
  # Get the gene-level results table
  results_genes <- results(dm_filtered)
  # Apply Benjamini-Hochberg (BH) correction for Multiple Testing
  results_genes$adj_pvalue <- p.adjust(results_genes$pvalue, method = "BH")
  
  cat("results_genes_0/n")
  str(results_genes)
  cat("\n")
  
  # Map ENSG to SYMBOL -----------------------------------------
  
  results_genes$gene_id<-gsub("\\..+$","",results_genes$gene_id)
  
  cat("results_genes_1/n")
  str(results_genes)
  cat("\n")
  
  results_genes$gene_name <- mapIds(org.Mm.eg.db, keys=results_genes$gene_id, keytype="ENSEMBL",column="SYMBOL", multiVals=multiVals)
  
  cat("results_genes_2/n")
  str(results_genes)
  cat("\n")
  
  # Identify significant DTU genes (using a 5% FDR threshold) --------------------
  
  dtu_genes <- results_genes %>%
    filter(adj_pvalue < 0.05) %>%
    arrange(adj_pvalue) %>%
    dplyr::select(gene_name , lr, pvalue, adj_pvalue)
  
  message(sprintf("4. Found %d genes with significant DTU (FDR < 0.05).", nrow(dtu_genes)))
  
  # Get transcript proportions --------------------
  
  
  # Optional:  
  prop_estimates <- proportions(dm_filtered)
  
  cat("prop_estimates_0/n")
  str(prop_estimates)
  cat("\n")
  
  prop_estimates$gene_id<-gsub("\\..+$","",prop_estimates$gene_id)
  prop_estimates$gene_name <- mapIds(org.Mm.eg.db, keys=prop_estimates$gene_id, keytype="ENSEMBL",column="SYMBOL", multiVals=multiVals)
  
  
  cat("prop_estimates_1/n")
  str(prop_estimates)
  cat("\n")
  
  
  ### SAVE ------------------
  
  setwd(out)
  # Save the full results table
  write.table(results_genes, file = paste("DRIMSeq_DTU_Full_Results_",Threshold_ratio,".tsv", sep=''), row.names = FALSE, quote=F, sep="\t")
  write.table(prop_estimates, file = paste("DRIMSeq_DTU_prop_estimates_",Threshold_ratio,".tsv", sep=''), row.names = FALSE, quote=F, sep="\t")
  
}


printList = function(l, prefix = "     ") {
  list.df = data.frame(val_name = names(l), value = as.character(l))
  list_strs = apply(list.df, MARGIN = 1, FUN = function(x) { paste(x, collapse = " = ")})
  cat(paste(paste(paste0(prefix, list_strs), collapse = "\n"), "\n"))
}


#### main script ----

main = function() {
  cmd_line = commandArgs()
  cat("Command line:\n")
  cat(paste(gsub("--file=", "", cmd_line[4], fixed=T),
            paste(cmd_line[6:length(cmd_line)], collapse = " "),
            "\n\n"))
  option_list <- list(
    make_option(c("--RSEM_DIR"), type="character", default=NULL,  
                metavar="type",  
                help="Path to tab-separated input file listing regions to analyze. Required."),
    make_option(c("--sample_array"), type="character", default=NULL,  
                metavar="type",  
                help="Path to tab-separated input file listing regions to analyze. Required."),
    make_option(c("--Threshold_ratio"), type="numeric", default=NULL,  
                metavar="type",  
                help="Path to tab-separated input file listing regions to analyze. Required."),
    make_option(c("--processors"), type="numeric", default=NULL,  
                metavar="type",  
                help="Path to tab-separated input file listing regions to analyze. Required."),
    make_option(c("--total_memory"), type="numeric", default=NULL,  
                metavar="type",  
                help="Path to tab-separated input file listing regions to analyze. Required."),
    make_option(c("--type"), type="character", default=NULL,  
                metavar="type",  
                help="Path to tab-separated input file listing regions to analyze. Required."),
    make_option(c("--out"), type="character", default=NULL,  
                metavar="type",  
                help="Path to tab-separated input file listing regions to analyze. Required.")
  )
  parser = OptionParser(usage = "140__Rscript_v106.R
                         --subset type
                         --TranscriptEXP FILE.txt
                         --cadd FILE.txt
                         --ncboost FILE.txt
                         --type type
                         --out filename",
                        option_list = option_list)
  opt <<- parse_args(parser)
  
  DRIMSeq_function(opt)
  
  
}


###########################################################################

system.time( main() )