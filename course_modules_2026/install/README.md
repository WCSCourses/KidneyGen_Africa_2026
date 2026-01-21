#  Docker Environment

This repository provides a **reproducible Docker environment** for the *Genomics, GWAS, and Population Genetics* course. The container bundles all required **system libraries, Python tools, R packages, and bioinformatics software** used throughout the practical sessions.

The goal is to ensure that **all students and collaborators work in the same controlled software environment**, independent of their local operating system.

---

## 🚀 What This Docker Image Provides

This Docker image includes:

* A Linux operating system
* **Python scientific stack**
* **R + Bioconductor environment**
* **basic GWAS and population genetics tools**
* Core **variant and genomic interval manipulation tools**

---

## 🐧 Base Operating System

* Ubuntu 24.04 (LTS)
* Non-interactive installation mode for full automation

---

## 🧰 System & Build Dependencies

These libraries support compilation, visualization, encryption, and numerical performance:

* build-essential
* gfortran
* cmake
* git, wget, unzip
* ca-certificates, apt-transport-https
* libopenblas-dev
* libcurl4-openssl-dev
* libssl-dev
* libxml2-dev
* libgl1-mesa-dev, xorg-dev
* libcairo2-dev
* libpng-dev, libjpeg-dev, libtiff-dev
* libfontconfig1-dev
* libfribidi-dev, libharfbuzz-dev

---

## 🐍 Python Environment

### Python Version

* Python 3 (system installation)

### Installed Python Libraries

These libraries are used for numerical computing, data wrangling, visualization, and bioinformatics:

* numpy
* scipy
* pandas
* matplotlib
* openpyxl
* biopython

---

## 📦 R Environment

### Base R

* r-base
* r-base-dev

### CRAN Packages

These packages support GWAS visualization, data manipulation, and web-based queries:

* devtools
* R.utils
* data.table
* ggplot2
* qqman
* dplyr
* plyr
* BiocManager
* httr
* AnnotationDbi

### Bioconductor Packages

These packages provide genome references, SNP databases, and summary statistics processing:

* MungeSumstats
* SNPlocs.Hsapiens.dbSNP155.GRCh38
* BSgenome.Hsapiens.NCBI.GRCh38
* SNPlocs.Hsapiens.dbSNP155.GRCh37
* BSgenome.Hsapiens.1000genomes.hs37d5
* biomaRt

### GitHub Package

* locusplotr hat had been modify : https://github.com/jeantristanb/locusplotr

---

## 🧬 Bioinformatics & Genomics Software

### Variant File Manipulation

* vcftools – filtering and processing VCF files
* bcftools – advanced VCF/BCF processing
* tabix – indexing and querying compressed genomic files

### Genomic Interval Operations

* bedtools – intersection, overlap, and region-based operations

### GWAS & Population Genetics

* plink 1.9 – classical GWAS and QC pipeline
* plink 2 – next-generation GWAS framework
* admixture – ancestry estimation and population structure inference
* regenie – ancestry estimation and population structure inference

---

## ▶️ How to Build the Docker Image

From the root of this repository:

```bash
docker build -t gwas-course .
```

---

## ▶️ How to Run the Container

```bash
docker run -it --rm \
  -v $(pwd):/workspace \
  gwas-course
```

This mounts your current directory into `/workspace` inside the container.



