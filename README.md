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
