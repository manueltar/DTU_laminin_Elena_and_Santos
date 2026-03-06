
suppressMessages(library("plyr", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("data.table", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("crayon", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
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
suppressMessages(library("cli", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("tzdb", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("svglite", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("ggeasy", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("sandwich", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("digest", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("tidyverse", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("RColorBrewer", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("svglite", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("cowplot", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("org.Mm.eg.db", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("ActivePathways", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("splitstackshape", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("dorothea", lib="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("decoupleR", lib="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("rWikiPathways", lib="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))



opt = NULL

options(warn = 1)

Dorothea_and_gmt = function(option_list)
{

  opt_in = option_list
  opt <<- option_list
  
  cat("All options:\n")
  printList(opt)
  
  
  #### READ and transform type ----
  
  type = opt$type
  
  cat("TYPE_\n")
  cat(sprintf(as.character(type)))
  cat("\n")
  
  #### READ and transform out ----
  
  out = opt$out
  
  cat("OUT_\n")
  cat(sprintf(as.character(out)))
  cat("\n")
  
  #### READ and transform Dorothea_confidence ----
  
  Dorothea_confidence = unlist(strsplit(opt$Dorothea_confidence, split="_"))
  
  cat("Dorothea_confidence_\n")
  cat(sprintf(as.character(Dorothea_confidence)))
  cat("\n")
  
 
  
  #### Extract Dorothea genes ----
  
  net <- decoupleR::get_dorothea(organism = 'mouse', levels = c(Dorothea_confidence))
  
  
  cat("net_0\n")
  cat(str(net))
  cat("\n")
  
  net.df<-as.data.frame(net)
  
  cat("net.df_0\n")
  cat(str(net.df))
  cat("\n")
  
  
  ### Retrieve the ENTREZID and ensembl_gene_id ----
  
  
  # net.df$ENTREZID<-mapIds(org.Mm.eg.db, keys=net.df$target, keytype="SYMBOL",column="ENTREZID")
  net.df$ensembl_gene_id<-mapIds(org.Mm.eg.db, keys=net.df$target, keytype="SYMBOL",column="ENSEMBL")
  
  cat("net.df_1\n")
  cat(str(net.df))
  cat("\n")
 
  # net.df<-net.df[!is.na(net.df$ENTREZID),]
  # 
  # cat("net.df_0\n")
  # cat(str(net.df))
  # cat("\n")
  
  net.df$id<-paste('Dorothea',paste(Dorothea_confidence, collapse=""),net.df$source,'targets', sep='_')
  # net.df$name<-paste('Dorothea',paste(Dorothea_confidence, collapse=""),net.df$source,'targets', sep='_')
  
  cat("net.df_1\n")
  cat(str(net.df))
  cat("\n")
  
  #### collapse by id ------------------
  
  net.df.dt<-data.table(net.df, key="id")
  
  
  net.df_collapsed<-as.data.frame(net.df.dt[,.(targets=paste(target, collapse=",")), by=key(net.df.dt)], stringsAsFactors=F)
  
  
  cat("net.df_collapsed_0\n")
  cat(str(net.df_collapsed))
  cat("\n")
  
  
  #### save ----
  
  
  setwd(out)
  
  write.table(net.df_collapsed, file=paste("Dorothea_",paste(Dorothea_confidence, collapse=""),'_','targets.tsv',sep=''), sep="\t", quote=F, row.names=F)
  
 #  #### Prepare the file for gmt export ----
 #  
 #  for_gmt_net.df<-unique(net.df[,c(which(colnames(net.df) == 'id'),
 #                                               which(colnames(net.df) == 'name'),
 #                                               which(colnames(net.df) == 'ENTREZID'))])
 #  
 #  colnames(for_gmt_net.df)[which(colnames(for_gmt_net.df) == 'ENTREZID')]<-'gene'
 #  
 #  cat("for_gmt_net.df_0\n")
 #  cat(str(for_gmt_net.df))
 #  cat("\n")
 #  
 # 
 #  #### Reorder
 #  
 #  indx.reorder<-c(which(colnames(for_gmt_net.df) == 'id'),which(colnames(for_gmt_net.df) == 'name'),which(colnames(for_gmt_net.df) == 'gene'))
 #  
 #  
 #  for_gmt_net.df_reordered<-for_gmt_net.df[,indx.reorder]
 #  
 #  cat("for_gmt_net.df_reordered_0\n")
 #  cat(str(for_gmt_net.df_reordered))
 #  cat("\n")
 # 
 # ### save as gmt ----
 #  
 #  setwd(out)
 #  
 #  writeGMT(for_gmt_net.df_reordered,paste("Dorothea_",paste(Dorothea_confidence, collapse=""),'_','Hs.entrez.gmt',sep=''))
  
  
  
}




printList = function(l, prefix = "    ") {
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
    make_option(c("--Dorothea_confidence"), type="character", default=NULL, 
                metavar="filename", 
                help="Path to tab-separated input file listing regions to analyze. Required."),
    make_option(c("--type"), type="character", default=NULL, 
                metavar="type", 
                help="Path to tab-separated input file listing regions to analyze. Required."),
    make_option(c("--out"), type="character", default=NULL, 
                metavar="filename", 
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
  
  Dorothea_and_gmt(opt)

  
}


###########################################################################

system.time( main() )