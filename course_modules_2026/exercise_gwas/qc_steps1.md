# Quality control Genotype 


## 🧬 GWAS Quality Control (QC) — Context and Objectives

The objective of this exercise is to understand the **basics of genotype quality control (QC)** and how QC affects **bias in GWAS** results.  
Most genotype QC steps are performed **before imputation** to ensure that only high-quality data are carried forward for analysis.  

In this session, we will perform a subset of key QC procedures, focusing on:

- **Missingness**
- **Allele frequency**
- **Hardy–Weinberg equilibrium (HWE)**
- **Relatedness**

---

### 🔹 Missingness

Missingness can reflect **genotyping problems**.  
Variants or individuals with a high proportion of missing genotype calls often indicate:

- Poor DNA quality or contamination  
- Technical issues during array hybridization or scanning  
- Systematic batch effects  

By filtering out SNPs and individuals with high missingness rates (e.g., >5%), we reduce technical noise and improve the overall reliability of downstream analyses.

---

### 🔹 Frequency (Minor Allele Frequency, MAF)

**Purpose:** To remove unreliable or non-informative variants.  

Variants with very low frequency (<1%) are harder to genotype accurately. They tend to:

- Have **higher genotyping error rates**  
- **Fail imputation** or have **low INFO/R² scores**  
- Be **poorly represented** in imputation reference panels, especially if the study population differs from the reference  

By filtering out variants with MAF < 0.01, we:

- **Reduce genotyping noise**, and  
- **Improve imputation accuracy**, since common variants (MAF ≥ 1%) have more stable linkage disequilibrium (LD) structures that help build accurate haplotypes.

---

### 🔹 Hardy–Weinberg Equilibrium (HWE)

Deviation from Hardy–Weinberg expectations can indicate potential **technical or biological problems**.  
Such deviations often arise from:

- **Allele miscalls** (e.g., strand flips A/T ↔ T/A)  
- **Cluster calling errors** on the array  
- **Batch effects** or poor probe performance  
- **Population stratification** (e.g., mixed ancestry groups)  
- **Sample contamination** or **sex mislabeling**  

Filtering out SNPs that strongly deviate from HWE  helps ensure that only accurately genotyped variants are used for imputation and downstream GWAS.

---

### 🔹 Relatedness

Relatedness refers to the **genetic similarity between individuals** in the dataset.  
In GWAS, the assumption is that samples are **independent** — each individual contributes unique information.  
However, if some participants are **closely related** (e.g., siblings, twins, parent–child pairs), this can introduce **bias** and **inflate association signals**, because alleles are correlated due to shared ancestry rather than a true association with the trait.

**Why check relatedness:**
- To **identify duplicates or sample mix-ups**  
- To **avoid overrepresentation** of family members or specific lineages  
- To ensure **independent samples** for association testing  

We can estimate relatedness using the **pi-hat** statistic (identity-by-descent, IBD), computed by tools such as **PLINK** or **PLINK 2**.  
PLINK 2 integrates a fast and accurate algorithm based on **KING** (Kinship-based INference for GWAS), which efficiently detects related individuals and helps **minimize the loss of samples** by selectively removing one individual per related pair.  
For more information, see the [KING documentation](https://www.kingrelatedness.com/).

**Typical thresholds:**

| Relationship | pi-hat range | Action |
|---------------|---------------|--------|
| Duplicate / Same individual | > 0.9 | Remove one |
| First-degree (parent–child, siblings) | 0.35 – 0.9 | Remove one per pair |
| Second-degree (uncle–niece, grandparent–grandchild) | 0.125 – 0.35 | Often acceptable depending on design |

Filtering based on relatedness ensures that the dataset includes mostly **unrelated individuals**, minimizing confounding due to family structure.

### 🔹 Other Possible Steps

To go deeper into genotype quality control, you can explore additional automated or comprehensive QC pipelines such as:

- **[H3A GWAS QC Pipeline](https://github.com/h3abionet/h3agwas/tree/master/qc)** — a robust, reproducible workflow developed by H3ABioNet for large-scale GWAS datasets. It covers all major QC steps, including missingness, MAF, HWE, relatedness, population structure, and sex checks.

- **[QCGWAS (R package)](https://cran.r-project.org/web/packages/QCGWAS/)** — an R-based framework for performing detailed QC and visualization of GWAS data, including automated flagging of problematic variants and individuals.

These tools can help standardize and automate QC across different datasets, ensuring **reproducibility** and **data consistency** before downstream analyses such as imputation or association testing.

### Steps

## Genotype Cleaning: MAF, GENO, HWE

The objective is to exclude any SNPs and individuals that do not meet basic quality control criteria. Specifically:

- Exclude SNPs with a **minor allele frequency (MAF)** less than **0.01**.  
- Exclude SNPs with a **Hardy–Weinberg equilibrium (HWE)** p-value less than **1 × 10⁻⁶**.  
- Exclude SNPs with a **missingness rate** greater than **0.05** (5%).  
- Exclude individuals with a **missingness rate** greater than **0.005** (0.5%).

We propose using **PLINK** to perform all these steps in one command.

### Common PLINK Arguments (Tips)

* `--bfile` : Specifies the prefix for input files (`prefix.bim`, `.fam`, `.bed`).
* `--maf` : Filters out variants with minor allele frequency below a threshold.
* `--hwe` : Excludes variants with Hardy–Weinberg equilibrium p-values below a threshold.
* `--geno` : Excludes variants with missing call rates greater than a threshold.
* `--mind` : Excludes samples with missing call rates greater than a threshold (default = 0.1).
* `--make-bed` : Creates a new binary fileset.
* `--out` : Specifies the prefix for output files.

To obtain help for a specific argument:
```bash
plink --help bfile
```

### Questions
* How many SNPs and individuals are excluded by each filter?  
* Which filter had the greatest impact on the dataset?

---

## Relatedness Filtering

The objective is to remove individuals with **high relatedness**.  
PLINK2 includes the **KING algorithm**, which efficiently identifies related individuals.

### Key PLINK2 Arguments
* `--bfile` : Input binary PLINK fileset.  
* `--king-cutoff` : Threshold for relatedness; values above this indicate related pairs.  
* `--make-bed` : Create a new binary fileset.  
* `--out` : Specify output prefix.


### Questions
* After filtering, how many individuals were removed due to relatedness?

