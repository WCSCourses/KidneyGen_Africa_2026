# <img src="https://coursesandconferences.wellcomeconnectingscience.org/wp-content/themes/wcc_courses_and_conferences/dist/assets/svg/logo.svg" width="300" height="50"> 

# Genetic Epidemiology of Kidney Disease in African Populations Informatics Guide

**Software used during the course**      

| Software | Version (if not latest) | Module | Notes |
|--------|-------------------------|--------|-------|
| [Docker](https://www.docker.com/) | Latest stable | All modules | Reproducible analysis environment |
| [Python](https://www.python.org/) | 3.x (system) | Data handling, QC, plotting | System Python |
| [NumPy](https://numpy.org/) | Latest | Python analysis | Numerical computing |
| [SciPy](https://scipy.org/) | Latest | Python analysis | Scientific computing |
| [pandas](https://pandas.pydata.org/) | Latest | Data wrangling | Tabular data manipulation |
| [matplotlib](https://matplotlib.org/) | Latest | Visualisation | Plotting and figures |
| [openpyxl](https://openpyxl.readthedocs.io/) | Latest | Data input | Excel file handling |
| [Biopython](https://biopython.org/) | Latest | Bioinformatics | Sequence and genomic utilities |
| [R](https://www.r-project.org/) | Latest (Ubuntu repo) | Statistical analysis | Base R environment |
| [ggplot2](https://ggplot2.tidyverse.org/) | Latest | Visualisation | GWAS and QC plots |
| [qqman](https://cran.r-project.org/package=qqman) | Latest | GWAS | Manhattan and QQ plots |
| [data.table](https://cran.r-project.org/package=data.table) | Latest | Data handling | High-performance tables |
| [dplyr](https://dplyr.tidyverse.org/) | Latest | Data manipulation | Data transformation |
| [plyr](https://cran.r-project.org/package=plyr) | Latest | Data manipulation | Legacy workflows |
| [devtools](https://cran.r-project.org/package=devtools) | Latest | R development | GitHub installs |
| [httr](https://cran.r-project.org/package=httr) | Latest | Web queries | API access |
| [BiocManager](https://cran.r-project.org/package=BiocManager) | Latest | Bioconductor | Package management |
| [AnnotationDbi](https://bioconductor.org/packages/AnnotationDbi/) | Latest | Annotation | Gene and SNP annotation |
| [MungeSumstats](https://bioconductor.org/packages/MungeSumstats/) | Latest | GWAS | Summary statistics QC |
| [SNPlocs.Hsapiens.dbSNP155.GRCh38](https://bioconductor.org/) | dbSNP155 | Reference data | SNP locations GRCh38 |
| [BSgenome.Hsapiens.NCBI.GRCh38](https://bioconductor.org/) | GRCh38 | Reference genome | Human genome |
| [SNPlocs.Hsapiens.dbSNP155.GRCh37](https://bioconductor.org/) | dbSNP155 | Reference data | SNP locations GRCh37 |
| [BSgenome.Hsapiens.1000genomes.hs37d5](https://bioconductor.org/) | hs37d5 | Reference genome | 1000 Genomes build |
| [biomaRt](https://bioconductor.org/packages/biomaRt/) | Latest | Annotation | Ensembl queries |
| [locusplotr](https://github.com/jeantristanb/locusplotr) | Modified | GWAS visualisation | Course-specific fork |
| [PLINK](https://www.cog-genomics.org/plink/) | 1.9 | GWAS, QC | Classical GWAS |
| [PLINK2](https://www.cog-genomics.org/plink/2.0/) | Latest | GWAS | Next-generation GWAS |
| [bcftools](https://samtools.github.io/bcftools/) | Latest | Variant processing | VCF and BCF tools |
| [vcftools](https://vcftools.github.io/) | Latest | Variant processing | VCF filtering |
| [tabix](http://www.htslib.org/) | Latest | Indexing | Compressed genomic files |
| [bedtools](https://bedtools.readthedocs.io/) | Latest | Genomic intervals | Interval operations |
| [ADMIXTURE](https://dalexander.github.io/admixture/) | Latest | Population genetics | Ancestry inference |
| [REGENIE](https://rgcgithub.github.io/regenie/) | Latest | GWAS | Whole-genome regression |

## Conda environments used in the course

### What is a Conda environment
A Conda environment is an isolated workspace that contains a specific set of software and library versions. It allows different tools to run without interfering with each other. This is useful when software requires particular versions of Python or system libraries. Only one Conda environment can be active at a time, and switching environments changes which software is available in the command line.

### Conda environments table

| Conda environment name | Software installed | How to activate | How to exit |
|-----------------------|-------------------|-----------------|-------------|
| `regenie_env` | regenie | `conda activate regenie_env` | `conda deactivate` |
| `saige` | SAIGE | `conda activate saige` | `conda deactivate` |
| `vep112` | Ensembl VEP v112 | `conda activate vep112` | `conda deactivate` |
| `qc_env` | MultiQC, FastQC | `conda activate qc_env` | `conda deactivate` |

### Useful Conda commands

List all available Conda environments:
```bash
conda info --envs
```

### Important notes 
- Always activate the correct Conda environment before running the associated software.
- Running Conda-managed tools outside their environment can cause errors due to version conflicts.
- The active Conda environment name appears in the terminal prompt.

---

## Informatics Set-Up
For installation and setup, please refer to the following guides:

- **[Oracle VM VirtualBox Installation Guide](https://github.com/WCSCourses/WCS_Informatics_Guides/blob/main/Installation_Guides/VM_Guide.md)** – Detailed instructions for installing and configuring VirtualBox on different operating systems. *(Note: Separate installations are needed for Intel-based and ARM-based Macs, and the VDI files will differ.)*
- **[Docker Installation Guide](https://github.com/WCSCourses/WCS_Informatics_Guides/blob/main/Installation_Guides/Docker_guide.md)** – Step-by-step guide for installing Docker on Windows, macOS, and Linux.

The Host Operating System Requirements are: <br />
- RAM requirement: 8GB (preferably 12GB) <br />
- Processor requirement: 4 processors (preferably 8) <br />
- Hard disk space: 200GB <br />
- Admin rights to the computer <br />

## Citing and Re-using Course Material

The course data are free to reuse and adapt with appropriate attribution. All course data in these repositories are licensed under the <a rel="license" href="https://creativecommons.org/licenses/by-nc-sa/4.0/">Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)</a>. <a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons Licence" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br /> 

Each course landing page is assigned a DOI via Zenodo, providing a stable and citable reference. These DOIs can be found on the respective course landing pages and can be included in CVs or research publications, offering a professional record of the course contributions.

## Interested in attending a course?

Take a look at what courses are coming up at [Wellcome Connecting Science Courses & Conference Website](https://coursesandconferences.wellcomeconnectingscience.org/our-events/).

---

[Wellcome Connecting Science GitHub Home Page](https://github.com/WCSCourses) 

For more information or queries, feel free to contact us via the [Wellcome Connecting Science website](https://coursesandconferences.wellcomeconnectingscience.org).<br /> 
Please find us on socials [Wellcome Connecting Science Linktr](https://linktr.ee/eventswcs)

---
