# Part 4 — Association

## Objective
The objective is to understand how to run an **association analysis**, what the **inputs and outputs** are, and how to specify **variables and covariates**.  
We will compare different models — before and after quality control (QC) — using **PLINK2** for simplicity.  

Note that other software packages such as **GEMMA** or **BOLT-LMM**, which account for relatedness, may provide more accurate results for certain datasets.  
Each software tool makes different assumptions and approximations, which may or may not be suitable depending on your data.

---

## Data

We will use two datasets and corresponding models:
- Before QC: `1_Data_beforeqc/afreur`
- After QC: `4_Data_qc_admixture_pheno/genotyped_qc`

---

## Models and Running Association Tests

### Key PLINK2 Options

* `--bfile` : Input binary PLINK fileset.  
* `--pheno` : Path to the phenotype file (e.g., `../Data_beforeqc/afreur_pheno.tsv`).  
* `--pheno-name` : Name of the phenotype to test (e.g., `egfr`).  
* `--covar` : Covariate file (e.g., `covariates.tsv`).  
* `--covar-name` : Names of the covariates to include.  
* `--glm` : Run a linear or logistic regression.  
  - Use `allow-no-covars` if no covariates are included.  
  - Use `hide-covar` to suppress covariate output in results.  
* `--out` : Output prefix for result files.

### Example Without Covariates

```bash
../bin/plink2 --bfile headerplk --pheno pheno_file --pheno-name egfr --out egfr_raw --glm allow-no-covars
```

### Models to Run

1. **Before QC:**  
   - Data: `1_Data_beforeqc/afreur`  
   - Phenotype: `1_Data_beforeqc/afreur_pheno.tsv`  
   - Covariates: `Sex`, `Age`

2. **After QC:**  
   - Data: `4_Data_qc_admixture_pheno/genotyped_qc`  
   - Phenotype: `4_Data_qc_admixture_pheno/qc_pheno.tsv`  
   - Covariates: `sex`, `age`, and `Superpopulation`

---

## Understanding the Output

Each software package produces its own output format.  
In PLINK2, the main results are stored in a file such as:

`egfr_raw.egfr.glm.linear`

You can view the header with:
```bash
head egfr_raw.egfr.glm.linear
```

Example output columns:

| Column | Description |
|---------|-------------|
| `#CHROM` | Chromosome number |
| `POS` | Base-pair position |
| `ID` | Variant ID (rsID) |
| `REF` | Reference allele |
| `ALT` | Alternative allele |
| `A1` | Tested allele |
| `BETA` | Estimated effect size |
| `SE` | Standard error of the effect |
| `T_STAT` | Test statistic |
| `P` | P-value (significance of effect) |

---

