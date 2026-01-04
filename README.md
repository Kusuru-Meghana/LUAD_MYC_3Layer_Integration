# Integrated MYC Regulatory Network in LUAD (A549)
### ChIP-seq + siMYC RNA-seq + ATAC-seq

⭐ **This repository is the main entry point for the MYC multi-omics project.**

It integrates MYC ChIP-seq, siMYC RNA-seq, and ATAC-seq data to identify
**high-confidence, direct MYC target genes** in A549 lung adenocarcinoma cells.
By requiring agreement across DNA binding, expression change, and chromatin accessibility,
this analysis filters non-functional binding events and indirect transcriptional effects.

---

## Quick Overview

- **Cell line:** A549 lung adenocarcinoma  
- **Data:** MYC ChIP-seq, siMYC RNA-seq, ATAC-seq  
- **Goal:** Identify direct MYC targets by intersecting binding, expression response, and chromatin accessibility  
- **Key result:** ~268 MYC-bound genes with MYC-dependent expression, prioritized within accessible chromatin  
- **Approach:** Modular NGS pipelines (separate repos) + R-based multi-layer integration  

---

## Biological Question

**Which MYC binding events are functionally relevant in lung cancer cells, and how does chromatin
accessibility shape MYC-dependent gene regulation?**

Specifically:
- Where does MYC bind the genome?
- Which genes change expression when MYC is knocked down?
- Which MYC binding sites occur in open, accessible chromatin?

---

## Dataset Overview

**Cell line:** A549 (human lung adenocarcinoma)

### Layer 1 — MYC ChIP-seq
- Genome-wide MYC binding sites
- Output: MYC peaks annotated to nearby genes

### Layer 2 — RNA-seq (siMYC knockdown)
- Conditions: Control (MYC-high) vs siMYC (MYC-low)
- Replicates: 2 control + 2 knockdown
- Output: Differentially expressed genes after MYC suppression

### Layer 3 — ATAC-seq
- Genome-wide chromatin accessibility landscape
- Output: Open chromatin peak set

---

## Repository Design

Each data modality is implemented as a **standalone, reusable pipeline** in a separate repository.
This repository performs the **final multi-layer integration and biological interpretation**.

This modular design mirrors real-world bioinformatics workflows and improves reproducibility,
clarity, and reuse.

---

## Multi-Layer Integration Logic

A gene is classified as a **high-confidence direct MYC target** if it satisfies **all three criteria**:

1. **MYC binding**  
   A MYC ChIP-seq peak is annotated to the gene (Layer 1)

2. **Expression response**  
   The gene is significantly differentially expressed after MYC knockdown (Layer 2)

3. **Chromatin accessibility**  
   The MYC binding site overlaps an ATAC-seq peak (Layer 3)

This strategy removes:
- Non-functional MYC binding
- Context-dependent or inaccessible sites
- Indirect transcriptional effects

---

## Key Results

- **~5,100 MYC-bound genes** identified from ChIP-seq  
  (see `results/chipseq/annotated_peaks.tsv`)

- **~268 genes** both MYC-bound and differentially expressed after MYC knockdown  
  (see `results/integration/direct_myc_targets.tsv`)

- **~62,000 ATAC-seq peaks** defining open chromatin in A549  
  (see `results/atacseq/atac_merged_peaks.bed`)

- **~45% of MYC binding sites** occur in accessible chromatin  
  (see `results/integration/myc_atac_overlap_stats.tsv`)

- Direct MYC targets are enriched for:
  - Cell cycle and proliferation
  - RNA processing and ribosome biogenesis
  - Chromatin organization and transcriptional regulation

---

## Biological Interpretation

- MYC primarily acts as a **direct transcriptional amplifier** in A549 cells by binding
  promoter-proximal, accessible chromatin of genes involved in growth and biosynthesis.

- MYC knockdown leads to:
  - Collapse of proliferative and transcriptional programs
  - Activation of senescence, stress, and immune-related pathways

- Integrating binding (ChIP-seq), expression (RNA-seq), and accessibility (ATAC-seq)
  separates **functional MYC regulation** from non-productive binding events.

---

## How to Use This Repository

This repository performs **integration and interpretation**.
Raw data processing is handled in the standalone pipeline repositories linked below.

1. Run each standalone pipeline following instructions in their respective repos:
   - MYC ChIP-seq
   - siMYC RNA-seq
   - ATAC-seq

2. Place summarized result tables into the `data/` directory here:
   - ChIP-seq peak annotations  
   - DESeq2 differential expression results  
   - ATAC-seq merged peak set  

3. Run the integration scripts, for example:
   ```bash
   Rscript scripts/01_build_myc_target_sets.R
   Rscript scripts/02_enrichment_and_visualization.R
   ```

4. Inspect outputs:
   - Final MYC target gene lists and summary statistics in `results/`
   - Pathway enrichment tables and figures in `results/figures/`

---

## Linked Standalone Pipelines

MYC ChIP-seq pipeline:
https://github.com/Kusuru-Meghana/LUAD_MYC_ChIPSeq

siMYC RNA-seq pipeline:
https://github.com/Kusuru-Meghana/LUAD_MYC_RNASeq

ATAC-seq pipeline:
https://github.com/Kusuru-Meghana/LUAD_MYC_ATACSeq

ChIP-seq + RNA-seq integration:
https://github.com/Kusuru-Meghana/LUAD_MYC_ChIPSeq_RNASeq_Integration

---

## Reproducibility Notes

- Modular scripts used for all analyses

- Environments documented in individual pipeline repositories

- Raw human sequencing data not included; pipelines assume local data paths

- Integration logic implemented in reusable R scripts

---

## Technologies Used

- NGS assays: ChIP-seq, RNA-seq, ATAC-seq

- Tools: Bowtie2, HISAT2, MACS2/MACS3, featureCounts, DESeq2, ChIPseeker

- Languages: R, Bash

- Analysis: Differential expression, peak annotation, pathway enrichment

---

## Author & Contribution

Meghana Kusuru
M.S. Bioinformatics & Computational Biology

Designed and implemented the multi-omics integration strategy, performed all analyses,
and interpreted biological results linking MYC binding, expression, and chromatin accessibility.

---

## Why This Project Matters

This project demonstrates:

End-to-end NGS data integration

Multi-omics regulatory reasoning

Reproducible, modular bioinformatics workflows

Strong biological interpretation of oncogenic transcriptional control

This skill set directly aligns with entry-level bioinformatics and computational biology roles
in academic, clinical, and industry settings.



































