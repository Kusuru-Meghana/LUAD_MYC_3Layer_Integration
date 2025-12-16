setwd("C:/Users/megha/projects/MYC_Project/LAYER3_ATACseq")
getwd()



library(dplyr)
library(AnnotationDbi)
library(org.Hs.eg.db)



atac_annot <- read.csv(
  "./peaks/ATAC_peak_annotations.csv",
  stringsAsFactors = FALSE
)

# Column names in your ATAC annotation:
colnames(atac_annot)



atac_peak_col <- "peak_id"
atac_gene_col <- "SYMBOL"




atac_genes <- atac_annot[[atac_gene_col]] %>% 
  na.omit() %>% 
  unique()

cat("Number of genes with ATAC peaks:", length(atac_genes), "\n")





chip_annot <- read.csv(
  "../LAYER1_ChIPseq/Annotation/MYC_A549_peak_annotations.csv",
  stringsAsFactors = FALSE
)

chip_peak_col <- "PeakID"
chip_gene_col <- "SYMBOL"

# Show columns
colnames(chip_annot)







chip_genes <- chip_annot[[chip_gene_col]] %>% 
  na.omit() %>% 
  unique()

cat("Number of MYC-bound genes:", length(chip_genes), "\n")





myc_atac_genes <- intersect(chip_genes, atac_genes)

cat("Number of MYC-bound + ATAC-open genes:", 
    length(myc_atac_genes), "\n")






rna <- read.csv(
  "../LAYER2_RNAseq/DE_results/DESeq2_siMYC_vs_CTRL_results.csv",
  stringsAsFactors = FALSE
)

# Preview
head(rna)
colnames(rna)







rna_gene_col <- "X"     # ENSG IDs
lfc_col      <- "log2FoldChange"
padj_col     <- "padj"







rna$ENSG_clean <- sub("\\..*", "", rna[[rna_gene_col]])
head(rna$ENSG_clean)










rna$SYMBOL <- AnnotationDbi::mapIds(
  org.Hs.eg.db,
  keys = rna$ENSG_clean,
  column = "SYMBOL",
  keytype = "ENSEMBL",
  multiVals = "first"
)
rna_sub <- rna[rna$SYMBOL %in% myc_atac_genes, ]
cat("RNA rows after filtering:", nrow(rna_sub), "\n")




output_file <- "./results/MYC_3layer_genes.csv"

write.csv(rna_sub, output_file, row.names = FALSE)

cat("✔ File saved at:", output_file, "\n")


