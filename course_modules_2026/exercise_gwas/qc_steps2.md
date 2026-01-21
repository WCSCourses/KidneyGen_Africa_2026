# Part 2 — Population Quality Control

Population structure and and admixture can bias association results and create spurious signals.  
The aim here is to detect outliers or sample swaps that may affect downstream analyses.

---

## Objectives

1. **Visualize population structure** using Principal Component Analysis (PCA).  
2. **Estimate ancestry proportions** with ADMIXTURE.  
3. **Identify and remove population outliers** to ensure homogeneous study groups.

---

## Data 

we are using  data from [previous excercice](qc_steps1.md), but you can use a file `Data_qc_genotype/afreur_qc_rel`, contained filter for HWE, maf and missingness, for phenotype file we are using `Data_qc_genotype/qc_pheno.tsv` contained infromation relative to ancestrality of individuals


---
## Step 0 — Prepared data

for the excercice we will first select independant SNPs, 
```bash
mkdir -p admixture
../bin/plink --bfile 2_Data_qc_genotype/afreur_qc_rel --indep-pairwise 50 10 0.1 -out admixture/afreur_pihat
../bin/plink --bfile 2_Data_qc_genotype/afreur_qc_rel --extract admixture/afreur_pihat.prune.in --make-bed --out admixture//afreur_pihat_indep
```

## Step 1 — Principal Component Analysis (PCA)

PCA helps visualize genetic similarity between individuals and detect potential population stratification or mislabeled samples.

### Key Arguments
* `--bfile` : Input binary PLINK fileset.  
* `--pca` : Compute the top principal components (default = 20).  
* `--out` : Output prefix for PCA results.

### Questions
* How many principal components should be retained for population structure correction?  
* What might explain clusters or outliers in the PCA plot?  
* How could you identify and exclude individuals that deviate strongly from the main cluster?
* How could pc be integrated as covariates in GWAS?

---

## Step 2 — ADMIXTURE Analysis

ADMIXTURE estimates the proportion of ancestry components (K) in each individual.  
It helps detect admixture, population substructure, or sample contamination.

### Example Command
```bash
admixture admixture//afreur_pihat_indep.bed --cv  3
```
_(where `3` is the number of ancestral populations to estimate)_

### Key Arguments
* `--cv` : Performs cross-validation to estimate model accuracy.  
* Input file must be in PLINK `.bed` format.  
* Output includes `.Q` (ancestry proportions per individual) and `.P` (ancestral allele frequencies).

### Questions
* How do you determine the best number of clusters (K) to use in ADMIXTURE?  
* What patterns of admixture do you observe across individuals?  
* How could ancestry proportions be integrated as covariates in GWAS?

---

## Step 3 — Detecting and Handling Outliers Using ADMIXTURE

Population outliers can be identified by combining **PCA** and **ADMIXTURE** results to detect individuals whose ancestry or genetic profiles differ from the expected study populations.

---

### Typical Approach
1. Visualize PCA results, coloring individuals by their ADMIXTURE ancestry proportions.  
2. Using ADMIXTURE output, identify individuals whose ancestry proportions do not match their reported population group (e.g., individuals labeled as African but showing high European ancestry).

---

### Step-by-Step Using PCA
* Plot **PC1** and **PC2** in **R**, coloring points by population or ancestry.  
* Examine which principal components discriminate between European and African datasets.  
* Determine a threshold along the discriminating PCs to exclude individuals who do not cluster within their expected population (e.g., non-European in the European cluster or vice versa).

---

### Step-by-Step Using ADMIXTURE in R
* Load the **ADMIXTURE** results for **K = 2** (two ancestral components).  
* Combine the ADMIXTURE `.Q` file with the corresponding `.fam` file.  
* Merge this dataset with the **phenotype file**.  
* Identify which ancestry component corresponds to European and which to African ancestry.  
* Detect individuals whose ancestry proportions are inconsistent with their assigned population and flag or exclude them.

---

### Clean Dataset

Using the ADMIXTURE results, exclude individuals with an ancestry proportion **less than 0.7** for the target population.  
This means retaining only individuals whose **main ancestry component is at least 0.7**, and removing those who show substantial admixture (i.e., ancestry proportion < 0.7).

---

### Questions
* How can the removal of outliers influence the results of association tests?  
* Could sample swaps or mislabeled data explain the presence of outlier individuals?

