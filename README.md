# Integrated MYC Regulatory Network in LUAD (A549)
### ChIP-seq + siMYC RNA-seq + ATAC-seq

⭐ **This repository is the main entry point for the MYC multi-omics project.**

This project integrates **MYC ChIP-seq**, **siMYC RNA-seq**, and **ATAC-seq** data to identify
**high-confidence, direct MYC target genes** in **A549 lung adenocarcinoma cells**.
By requiring agreement across DNA binding, expression change, and chromatin accessibility,
the analysis filters out non-functional binding events and indirect transcriptional effects.

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
- Output: Differentially expressed genes upon MYC suppression

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

- ~5,100 genes bound by MYC (ChIP-seq)
- ~268 genes both MYC-bound **and** differentially expressed after MYC knockdown
- ~62,000 ATAC-seq peaks defining open chromatin in A549
- ~45% of MYC binding sites occur in accessible chromatin
- Direct MYC targets are enriched for:
  - Cell cycle and proliferation
  - RNA processing and ribosome biogenesis
  - Chromatin organization and transcriptional regulation

---

## Biological Interpretation

This analysis demonstrates that MYC functions as a **direct transcriptional amplifier**
in A549 lung cancer cells by binding promoter-proximal, accessible chromatin regions
of genes involved in growth and biosynthetic programs.

Upon MYC knockdown:
- Proliferative and transcriptional machinery collapses
- Senescence, stress, and immune-related pathways become activated

Integrating binding, expression, and chromatin accessibility distinguishes
**functional MYC regulatory events** from non-productive binding,
providing a mechanistic view of MYC-driven oncogenic regulation.

---

## Linked Standalone Pipelines

- **MYC ChIP-seq pipeline:**  
  https://github.com/Kusuru-Meghana/LUAD_MYC_ChIPSeq

- **siMYC RNA-seq pipeline:**  
  https://github.com/Kusuru-Meghana/LUAD_MYC_RNASeq

- **ATAC-seq pipeline:**  
  https://github.com/Kusuru-Meghana/LUAD_MYC_ATACSeq

- **ChIP-seq + RNA-seq integration:**  
  https://github.com/Kusuru-Meghana/LUAD_MYC_ChIPSeq_RNASeq_Integration

---

## Reproducibility

- Modular scripts used for all analyses
- Conda / R environments documented in individual pipeline repositories
- Raw human sequencing data not included; pipelines assume local data paths
- Integration logic implemented in reusable R scripts

---

## Author & Contribution

**Meghana Kusuru**  
M.S. Bioinformatics & Computational Biology  

Designed and implemented the full multi-omics integration strategy, performed all analyses,
and interpreted biological results linking MYC binding, expression, and chromatin accessibility.

---

## Why This Project Matters

This repository demonstrates:
- End-to-end NGS data integration
- Multi-omics regulatory reasoning
- Reproducible, modular bioinformatics workflows
- Strong biological interpretation of oncogenic transcriptional control

This skill set directly aligns with **entry-level bioinformatics and computational biology roles**
in academic, clinical, and industry settings.
