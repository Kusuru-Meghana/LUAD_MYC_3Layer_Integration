###############################################
### 0. SET WORKING DIRECTORY
###############################################

# Go to the folder that actually contains the "results" folder
setwd("C:/Users/megha/projects/MYC_Project/LAYER3_ATACseq")

# Confirm you are in the correct working directory
print(getwd())


###############################################
### 1. CHECK FILES
###############################################

# Check if the 3-layer results file exists
print(list.files("results"))


###############################################
### 2. LOAD 3-layer MYC gene table
###############################################

three <- read.csv("results/MYC_3layer_genes.csv",
                  stringsAsFactors = FALSE)

# Show first few rows to confirm successful load
head(three)



###############################################
### Volcano Plot for MYC Direct Targets
###############################################

library(ggplot2)
library(dplyr)

volcano_data <- three %>%
  mutate(
    negLog10Padj = -log10(padj),
    Regulation = case_when(
      padj < 0.05 & log2FoldChange > 0 ~ "Upregulated",
      padj < 0.05 & log2FoldChange < 0 ~ "Downregulated",
      TRUE ~ "Not significant"
    )
  )



png("C:/Users/megha/projects/MYC_Project/LAYER3_ATACseq/results/GO_volcano_plot.png",
    width = 1400, height = 1200, res = 150)

ggplot(volcano_data, aes(x = log2FoldChange, y = negLog10Padj, color = Regulation)) +
  geom_point(alpha = 0.7, size = 1.8) +
  scale_color_manual(values = c(
    "Upregulated" = "red",
    "Downregulated" = "blue",
    "Not significant" = "grey"
  )) +
  theme_bw() +
  labs(
    title = "Volcano Plot of MYC Direct Targets",
    x = "log2 Fold Change",
    y = "-log10 adjusted p-value"
  ) +
  theme(plot.title = element_text(size = 16, face = "bold"),
        legend.title = element_blank())

dev.off()




###############################################
### Load final 3-layer MYC target gene table ###
###############################################

three <- read.csv("results/MYC_3layer_genes.csv", stringsAsFactors = FALSE)

# Use SYMBOL column for enrichment
gene_symbols <- three$SYMBOL
gene_symbols <- unique(na.omit(gene_symbols))


###############################################
### GO ENRICHMENT (Biological Process)      ###
###############################################

ego <- enrichGO(
  gene          = gene_symbols,
  OrgDb         = org.Hs.eg.db,
  keyType       = "SYMBOL",
  ont           = "BP",
  pAdjustMethod = "BH",
  pvalueCutoff  = 0.05,
  qvalueCutoff  = 0.05
)

# Save results
ego_df <- as.data.frame(ego)
write.csv(ego_df, "results/GO_enrichment.csv", row.names = FALSE)

# Plot
png("results/GO_plot.png", width = 1400, height = 1200, res = 150)
barplot(ego, showCategory = 15, title = "GO Enrichment (Biological Process)")
dev.off()



###############################################
### KEGG ENRICHMENT                         ###
###############################################

# Convert SYMBOL → ENTREZ (KEGG uses Entrez IDs)
entrez_ids <- bitr(gene_symbols, fromType="SYMBOL",
                   toType="ENTREZID", OrgDb=org.Hs.eg.db)

ekegg <- enrichKEGG(
  gene          = entrez_ids$ENTREZID,
  organism      = "hsa",
  pvalueCutoff  = 0.05
)

# Save results
ekegg_df <- as.data.frame(ekegg)
write.csv(ekegg_df, "results/KEGG_enrichment.csv", row.names = FALSE)

# Plot
png("results/KEGG_plot.png", width = 1400, height = 1200, res = 150)
barplot(ekegg, showCategory = 15, title = "KEGG Pathway Enrichment")
dev.off()


###############################################
### DONE!                                    ###
###############################################

cat("\n✔ GO enrichment saved to results/GO_enrichment.csv")
cat("\n✔ GO plot saved to results/GO_plot.png")
cat("\n✔ KEGG enrichment saved to results/KEGG_enrichment.csv")
cat("\n✔ KEGG plot saved to results/KEGG_plot.png\n")







