# LUAD_MYC_3Layer_Integration
Multi-omics integration of MYC ChIP-seq, RNA-seq, and ATAC-seq in LUAD (A549) to identify high-confidence direct MYC target genes.

## Overview

This project performs a three-layer multi-omics integration of MYC ChIP-seq, RNA-seq, and ATAC-seq data in lung adenocarcinoma (LUAD, A549 cells) to identify high-confidence, functionally active MYC target genes.

MYC is a master oncogenic transcription factor that binds thousands of genomic sites. However, binding alone does not guarantee functional regulation. This project was designed to systematically distinguish true direct MYC targets from indirect or non-functional binding events.

## Scientific Motivation

A major challenge in transcription factor biology is that:

- ChIP-seq identifies where MYC binds, but not whether that binding is functional.

- RNA-seq identifies expression changes, but many are indirect downstream effects.

- ATAC-seq identifies accessible chromatin, but not which transcription factor is responsible.

To confidently define direct MYC targets, all three layers must agree.

## Core Question

Which genes are directly regulated by MYC in LUAD, supported by binding, expression change, and chromatin accessibility?

## Data Layers Integrated
1. MYC ChIP-seq (Layer 1)

- Identifies genomic regions bound by MYC

- Peaks annotated to nearby genes

- Captures MYC’s physical DNA binding landscape

2. RNA-seq (Layer 2)

- Differential expression analysis following MYC perturbation (siMYC vs control)

- Identifies genes transcriptionally responsive to MYC

3. ATAC-seq (Layer 3)

- Identifies open chromatin regions

- Filters out MYC binding events occurring in inaccessible chromatin


## Integration Strategy

A gene is considered a high-confidence direct MYC target only if:

- MYC binds near the gene (ChIP-seq)

- The gene is differentially expressed upon MYC perturbation (RNA-seq)

- The regulatory region is located in accessible chromatin (ATAC-seq)

This intersection removes:

- non-functional MYC binding

- indirect transcriptional effects

- inaccessible regulatory regions


## Repository Structure
```
LUAD_MYC_3Layer_Integration/
│
├── data/
│   ├── MYC_A549_peak_annotations.csv        # MYC ChIP-seq annotated peaks
│   ├── DESeq2_siMYC_vs_CTRL_results.csv     # RNA-seq differential expression
│   └── ATAC_peak_annotations.csv            # ATAC-seq annotated accessible regions
│
├── scripts/
│   └── 01_three_layer_integration.R         # Core integration logic
│
├── results/
│   ├── MYC_3layer_genes.csv                  # Final high-confidence MYC targets
│   ├── Top20_Direct_MYC_Targets.csv
│   ├── Top10_Upregulated_MYC_Targets.csv
│   ├── Top10_Downregulated_MYC_Targets.csv
│   ├── GO_enrichment.csv
│   ├── KEGG_enrichment.csv
│   ├── GO_plot.png
│   ├── KEGG_plot.png
│   └── GO_volcano_plot.png
│
├── LICENSE
└── README.md
```

## Key Results

Thousands of MYC binding events were reduced to a refined set of direct MYC targets

High-confidence targets are strongly enriched for:

- Ribosome biogenesis

- RNA processing

- Cell cycle regulation

- Cancer-associated metabolic pathways

Demonstrates that chromatin accessibility is a critical constraint on MYC function


## Biological Interpretation

This analysis confirms that MYC acts as a global regulator of growth and proliferation, but only a subset of its binding events are transcriptionally active. Functional MYC regulation requires both chromatin accessibility and measurable transcriptional impact.

Related Repositories

This integration builds upon the following layer-specific analyses:

- MYC ChIP-seq:
https://github.com/Kusuru-Meghana/LUAD_MYC_ChIPseq

- MYC RNA-seq:
https://github.com/Kusuru-Meghana/LUAD_MYC_RNAseq

- ChIP–RNA Integration:
https://github.com/Kusuru-Meghana/LUAD_MYC_ChIPseq_RNAseq_Integration

- MYC ATAC-seq:
https://github.com/Kusuru-Meghana/LUAD_MYC_ATACseq

## Summary

This project demonstrates how multi-omics integration can be used to identify biologically meaningful transcription factor targets, moving beyond single-layer analyses to define true regulatory networks in cancer.
