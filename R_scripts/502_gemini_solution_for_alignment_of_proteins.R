# ==============================================================================
# 1. SETUP: Load Libraries and Install Bioconductor if necessary
# ==============================================================================
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
# BiocManager::install("Biostrings") # Uncomment and run if needed
if (!requireNamespace("ggplot2", quietly = TRUE))
  install.packages("ggplot2")
if (!requireNamespace("dplyr", quietly = TRUE))
  install.packages("dplyr")

library(Biostrings)
library(ggplot2)
library(dplyr)

# ==============================================================================
# 2. CORE FUNCTION: Generate Homology-Aware Summary Table
# ==============================================================================
#' Summarizes alignment changes, incorporating conservative substitutions (homology).
#'
#' @param alignment A Biostrings PairwiseAlignmentsSingleSubject object.
#' @param sub_matrix The substitution matrix used (e.g., BLOSUM62).
#' @return An extended data frame detailing the position, change type, and residue scores.
get_homology_summary <- function(alignment, sub_matrix = "BLOSUM62") {
  
  if (is.character(sub_matrix)) {
    sub_matrix_obj <- get(sub_matrix)
  } else {
    sub_matrix_obj <- sub_matrix
  }
  
  seq1_aligned <- as.character(pattern(alignment))
  seq2_aligned <- as.character(subject(alignment))
  chars1 <- unlist(strsplit(seq1_aligned, split = ""))
  chars2 <- unlist(strsplit(seq2_aligned, split = ""))
  
  len <- length(chars1)
  summary_df <- data.frame(
    Alignment_Position = 1:len,
    Sequence1_Residue = chars1,
    Sequence2_Residue = chars2,
    Sequence = "Sequence 1", # Helper column for plotting
    Change_Type = character(len),
    Substitution_Score = numeric(len),
    stringsAsFactors = FALSE
  )
  
  # Duplicate rows for Sequence 2 in the plot data
  summary_df_seq2 <- summary_df
  summary_df_seq2$Sequence = "Sequence 2"
  summary_df <- rbind(summary_df, summary_df_seq2)
  
  # Process only the first set of rows (1:len) to assign Change_Type and Score
  for (i in 1:(len)) {
    res1 <- chars1[i]
    res2 <- chars2[i]
    
    # Indices for both sequence rows in the final data frame
    idx1 <- i
    idx2 <- i + len
    
    if (res1 == res2 && res1 != "-") {
      # 1. Match (Identity)
      type <- "Match_Identical"
      score_val <- sub_matrix_obj[res1, res2] 
      
    } else if (res1 != "-" && res2 != "-" && res1 != res2) {
      # 2. Substitution (Non-Identical)
      score_val <- sub_matrix_obj[res1, res2]
      if (score_val > 0) {
        type <- "Substitution_Conservative" # Homology inference
      } else {
        type <- "Substitution_NonConservative"
      }
      
    } else if (res1 == "-" || res2 == "-") {
      # 3. Indels
      type <- ifelse(res1 == "-", "Insertion_in_Seq2", "Deletion_in_Seq2")
      score_val <- 0
      
    } else {
      # 4. Other (Gap/Gap)
      type <- "Other"
      score_val <- 0
    }
    
    # Assign the results to both Sequence 1 and Sequence 2 rows
    summary_df[idx1, c("Change_Type", "Substitution_Score")] <- c(type, score_val)
    summary_df[idx2, c("Change_Type", "Substitution_Score")] <- c(type, score_val)
  }
  
  return(summary_df %>% filter(Change_Type != "Other")) # Filter out Gap/Gap
}

# ==============================================================================
# 3. EXECUTION: Alignment and Summary Generation
# ==============================================================================

# Define Sequences (Include examples of all cases: Match, Cons. Sub., Non-Cons. Sub., Indel)
# K/R -> Conservative (BLOSUM62 score: 2)
# I/E -> Non-Conservative (BLOSUM62 score: -3)
protA_actual <- AAString("PKTIECYL")  # Sequence 1
protB_actual <- AAString("PRTELAD-F") # Sequence 2 (with a longer tail and internal indel)

# Define Scoring Scheme
prot_matrix <- BLOSUM62 
gap_open <- -10
gap_extend <- -4

# Perform Global Alignment
prot_alignment <- pairwiseAlignment(
  pattern = protA_actual,
  subject = protB_actual,
  type = "global",
  substitutionMatrix = prot_matrix,
  gapOpening = gap_open,
  gapExtension = gap_extend
)

# Generate the Homology-focused Summary Table
homology_table <- get_homology_summary(
  alignment = prot_alignment,
  sub_matrix = prot_matrix
)

# --- Prepare data for plotting ---
plot_data <- homology_table %>%
  # Simplify the Change_Type for a clear legend
  mutate(
    Simple_Change = case_when(
      grepl("Match", Change_Type) ~ "Match (Identical)",
      grepl("Conservative", Change_Type) ~ "Substitution (Conservative)",
      grepl("NonConservative", Change_Type) ~ "Substitution (Non-Conservative)",
      grepl("Insertion", Change_Type) ~ "Insertion (Seq2)",
      grepl("Deletion", Change_Type) ~ "Deletion (Seq2)",
      TRUE ~ "Other Indel"
    ),
    # Create a factor for consistent ordering in the legend and plot
    Simple_Change = factor(Simple_Change, levels = c(
      "Match (Identical)",
      "Substitution (Conservative)",
      "Substitution (Non-Conservative)",
      "Deletion (Seq2)",
      "Insertion (Seq2)"
    ))
  )

# Define Annotation Data (Aligned Coordinates)
domain_annotations <- data.frame(
  PfamID = c("Domain_A", "Domain_B"),
  Start_Aligned = c(2, 6), # Example: Domain A from position 2 to 5, Domain B from 6 to 9
  End_Aligned = c(5, 9),
  Sequence = "Sequence 1" # Annotating only Sequence 1 for this example
)

# ==============================================================================
# 4. VISUALIZATION: Annotated ggplot2 Tile Plot
# ==============================================================================

# Custom color palette for alignment changes
change_colors <- c(
  "Match (Identical)" = "#2E8B57",               # Green for Identity
  "Substitution (Conservative)" = "#FFA500",     # Orange for Homology
  "Substitution (Non-Conservative)" = "#DC143C", # Red for Non-Conservative
  "Deletion (Seq2)" = "#1E90FF",                 # Blue for Deletion
  "Insertion (Seq2)" = "#8A2BE2"                 # Purple for Insertion
)

# Define vertical positions for domain rectangles
domain_y_pos <- data.frame(
  Sequence = factor(c("Sequence 1", "Sequence 2"), levels = c("Sequence 2", "Sequence 1")),
  y_min = c(0.5, 1.5), 
  y_max = c(1.5, 2.5)  
)

domain_plot_data <- domain_annotations %>%
  left_join(domain_y_pos, by = "Sequence")

# --- Final Plot Generation ---
p <- ggplot(plot_data, aes(x = Alignment_Position, y = Sequence)) +
  
  # 1. ADD DOMAIN ANNOTATIONS
  geom_rect(
    data = domain_plot_data,
    aes(xmin = Start_Aligned - 0.5, 
        xmax = End_Aligned + 0.5,   
        ymin = y_min + 0.05,        
        ymax = y_max - 0.05,
        fill = PfamID),
    alpha = 0.5,
    inherit.aes = FALSE 
  ) +
  
  # 2. Add the Main Alignment Tiles (Colored by Change Type)
  geom_tile(aes(fill = Simple_Change), color = "black", size = 0.2) +
  
  # 3. Add Residue Labels on top of the tiles
  geom_text(aes(label = Sequence1_Residue), size = 3, 
            data = filter(plot_data, Sequence == "Sequence 1"), inherit.aes = FALSE, 
            aes(x = Alignment_Position, y = "Sequence 1")) +
  geom_text(aes(label = Sequence2_Residue), size = 3, 
            data = filter(plot_data, Sequence == "Sequence 2"), inherit.aes = FALSE,
            aes(x = Alignment_Position, y = "Sequence 2")) +
  
  # 4. Use Custom Scales
  scale_fill_manual(
    values = c(change_colors, "Domain_A" = "#66c2a5", "Domain_B" = "#fc8d62"), # Combined colors
    name = "Feature"
  ) +
  
  # 5. Customize Appearance
  scale_y_discrete(limits = c("Sequence 2", "Sequence 1")) +
  theme_minimal() +
  labs(
    title = "Pairwise Protein Alignment with Functional Domains (BLOSUM62)",
    subtitle = paste0("Total Aligned Positions: ", max(plot_data$Alignment_Position)),
    x = "Alignment Position",
    y = ""
  ) +
  theme(
    axis.text.y = element_text(face = "bold"),
    legend.position = "bottom",
    panel.grid.major.y = element_blank(),
    panel.grid.minor.x = element_blank()
  )

# Display the plot
print(p)