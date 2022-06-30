# here, we clean and organize the genes in ATR for NLR, RLP, RLK, and TFs. later, we need to clean the specfici genes.
library(dplyr)
library(tidyverse)

NLR_drago2<-read.csv("Benchmarking_AA_DRAGO2.csv")
ATR_ids<-read.csv("ATR_id_peptides.csv")
ATR_NLR<-read_tsv("GCF_000001735.4_TAIR10.1_protein_NLRtracker.tsv")


drago2_IDs<-inner_join(NLR_drago2, ATR_ids, by=c("peptide" ="RefSeq.peptide.ID" ))%>%
  select(-1)%>%
  unique()

dim(drago2_IDs)

NLR_id<-inner_join(ATR_NLR, ATR_ids, by =c("seqname"="RefSeq.peptide.ID"))

#output the files

write.csv(NLR_id, "NLR_tracker.csv")
write.csv(drago2_IDs, "result_dargo2.csv")

# loading the collected genes

calcium <- read_table2("ATR_genes/calcium.csv")

library(plyr)
library(readr )
raw_files <- list.files( pattern = "*.csv")
raw_files

read_csv_filename <- function(raw_files){
  ret <- read_table2(raw_files)
  ret$Source <- raw_files #EDIT
  ret
}

import.list <- ldply(raw_files, read_csv_filename)

write.csv(import.list, "output/combined.csv")
