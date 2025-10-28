# ==============================================================================
# 1. SETUP: Load Libraries and Install Bioconductor if necessary
# ==============================================================================
# If packages aren't installed, uncomment the lines below:
# if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
# BiocManager::install("Biostrings")
# install.packages(c("ggplot2", "dplyr"))

library(Biostrings)
library(ggplot2)
library(dplyr)

# ==============================================================================
# 2. CORE FUNCTION: Generate DNA Alignment Summary Table
# ==============================================================================
#' Summarizes the differences and similarities in a DNA PairwiseAlignment object.
#'
#' @param alignment A Biostrings PairwiseAlignmentsSingleSubject object (DNA).
#' @return A data frame detailing the position, change type, and residues.
get_dna_alignment_summary <- function(alignment) {
  
  seq1_aligned <- as.character(pattern(alignment))
  seq2_aligned <- as.character(subject(alignment))
  chars1 <- unlist(strsplit(seq1_aligned, split = ""))
  chars2 <- unlist(strsplit(seq2_aligned, split = ""))
  
  len <- length(chars1)
  summary_df <- data.frame(
    Alignment_Position = 1:len,
    Sequence1_Residue = chars1,
    Sequence2_Residue = chars2,
    Sequence = "DNA 1", # Helper column for plotting
    Change_Type = character(len),
    stringsAsFactors = FALSE
  )
  
  # Duplicate rows for DNA 2 in the plot data
  summary_df_seq2 <- summary_df
  summary_df_seq2$Sequence = "DNA 2"
  summary_df <- rbind(summary_df, summary_df_seq2)
  
  # Process only the first set of rows (1:len) to assign Change_Type
  for (i in 1:(len)) {
    res1 <- chars1[i]
    res2 <- chars2[i]
    
    # Indices for both sequence rows in the final data frame
    idx1 <- i
    idx2 <- i + len
    
    if (res1 == res2 && res1 != "-") {
      type <- "Match (Identical)"
    } else if (res1 != "-" && res2 != "-" && res1 != res2) {
      type <- "Substitution (Mismatch)"
    } else if (res1 == "-" && res2 != "-") {
      type <- "Insertion (DNA 2)" # Insertion relative to DNA 1
    } else if (res1 != "-" && res2 == "-") {
      type <- "Deletion (DNA 2)" # Deletion relative to DNA 1
    } else {
      type <- "Other" # Gap/Gap (will be filtered out)
    }
    
    # Assign the results to both DNA 1 and DNA 2 rows
    summary_df[idx1, "Change_Type"] <- type
    summary_df[idx2, "Change_Type"] <- type
  }
  
  return(summary_df %>% filter(Change_Type != "Other"))
}

# ==============================================================================
# 3. EXECUTION: Alignment and Summary Generation
# ==============================================================================

# Define DNA Sequences (using DNAString objects)
# Includes: Match (A/A), Mismatch (C/T), Insertion/Deletion
dnaA_actual <- DNAString("ATGCAGGTACGT")  # DNA 1
dnaB_actual <- DNAString("AT-CACTTACGT")  # DNA 2

# Define DNA Scoring Scheme
# Standard: Match=2, Mismatch=-3 is common
dna_matrix <- nucleotideSubstitutionMatrix(match = 2, mismatch = -3, baseOnly = TRUE) 
gap_open <- -8
gap_extend <- -2

# Perform Global Alignment
dna_alignment <- pairwiseAlignment(
  pattern = dnaA_actual,
  subject = dnaB_actual,
  type = "global",
  substitutionMatrix = dna_matrix,
  gapOpening = gap_open,
  gapExtension = gap_extend
)

# Generate the Summary Table
homology_table <- get_dna_alignment_summary(dna_alignment)

# --- Prepare data for plotting ---
plot_data <- homology_table %>%
  # Ensure consistent ordering for the legend
  mutate(
    Simple_Change = factor(Change_Type, levels = c(
      "Match (Identical)",
      "Substitution (Mismatch)",
      "Deletion (DNA 2)",
      "Insertion (DNA 2)"
    ))
  )

# Define Annotation Data (Assuming Aligned Coordinates for miRNA)
mirna_annotations <- data.frame(
  miRNA_ID = c("miRNA-A", "miRNA-B"),
  Start_Aligned = c(1, 7), # Example: miRNA-A from 1 to 3, miRNA-B from 7 to 10
  End_Aligned = c(3, 10),
  Sequence = "DNA 1" # Annotating only DNA 1
)

# ==============================================================================
# 4. VISUALIZATION: Annotated ggplot2 Tile Plot
# ==============================================================================

# Custom color palette for alignment changes
change_colors <- c(
  "Match (Identical)" = "#2E8B57",               # Green
  "Substitution (Mismatch)" = "#FFA500",         # Orange
  "Deletion (DNA 2)" = "#1E90FF",                # Blue
  "Insertion (DNA 2)" = "#8A2BE2"                # Purple
)

# Define vertical positions for annotation rectangles
domain_y_pos <- data.frame(
  Sequence = factor(c("DNA 1", "DNA 2"), levels = c("DNA 2", "DNA 1")),
  y_min = c(0.5, 1.5), 
  y_max = c(1.5, 2.5)  
)

mirna_plot_data <- mirna_annotations %>%
  left_join(domain_y_pos, by = c("Sequence" = "Sequence"))

# --- Final Plot Generation ---
p <- ggplot(plot_data, aes(x = Alignment_Position, y = Sequence)) +
  
  # 1. ADD miRNA ANNOTATIONS
  geom_rect(
    data = mirna_plot_data,
    aes(xmin = Start_Aligned - 0.5, 
        xmax = End_Aligned + 0.5,   
        ymin = y_min + 0.05,        
        ymax = y_max - 0.05,
        fill = miRNA_ID), # Fill by miRNA ID
    alpha = 0.5,
    inherit.aes = FALSE 
  ) +
  
  # 2. Add the Main Alignment Tiles (Colored by Change Type)
  geom_tile(aes(fill = Simple_Change), color = "black", size = 0.2) +
  
  # 3. Add Residue Labels (Sequence 1)
  geom_text(aes(label = Sequence1_Residue), size = 3, 
            data = filter(plot_data, Sequence == "DNA 1"), inherit.aes = FALSE, 
            aes(x = Alignment_Position, y = "DNA 1")) +
  # 3. Add Residue Labels (Sequence 2)
  geom_text(aes(label = Sequence2_Residue), size = 3, 
            data = filter(plot_data, Sequence == "DNA 2"), inherit.aes = FALSE,
            aes(x = Alignment_Position, y = "DNA 2")) +
  
  # 4. Use Custom Scales
  scale_fill_manual(
    values = c(change_colors, "miRNA-A" = "#e7298a", "miRNA-B" = "#1b9e77"), # Combined colors
    name = "Feature"
  ) +
  
  # 5. Customize Appearance
  scale_y_discrete(limits = c("DNA 2", "DNA 1")) +
  theme_minimal() +
  labs(
    title = "Pairwise DNA Alignment with miRNA Annotations",
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