# Post-association

## Objective
Plot QQ and Manhattan plots, compute the genomic inflation factor, extract independent SNPs using **PLINK2**, and create regional plots.

---

## Data / Files
* `5_association/egfr_covar_afterqc.egfr.glm.linear` — association results **after QC** (before ancestry adjustment).  
* `5_association/egfr_covar_beforeqc.egfr.glm.linear` — association results **before QC** (with ancestry adjustment).  
* `4_Data_qc_admixture_pheno/genotyped_qc` — PLINK binary fileset used to define independent SNPs and linkage disequilibrium (LD).

---

## QQ Plot & Manhattan Plot

### Exercise 1 — QQ Plot / Genomic Inflation Factor

Compute the **genomic inflation factor (λ)** for each summary statistics file and compare them.  
Use the `qqman` package (or base R) to draw QQ plots and calculate λ.

**What is λ?**  
The **genomic inflation factor (λ)** evaluates whether the test statistics from a GWAS are inflated — i.e., whether they show more significant results than expected under the null hypothesis of no association.

\[
\lambda = \frac{\text{median of observed } \chi^2}{\text{expected median under the null (0.456)}}
\]

**Interpretation:**
- **λ ≈ 1.0** → No inflation; test statistics follow the expected null distribution.  
- **λ > 1.1** → Inflation detected. Possible causes include:
  - Population stratification (unadjusted ancestry),
  - Cryptic relatedness,
  - Genotyping or imputation errors.

---

**R Example (QQ plot and λ using `qqman`):**
```r
# install.packages("qqman")  # if needed
library(qqman)

# Load summary statistics (expects a P-value column)
sumstats <- read.table("5_association/egfr_covar_afterqc.egfr.glm.linear", header=TRUE)

# Compute lambda (median chi-square / 0.456)
chisq <- qchisq(1 - sumstats$P, 1)
lambda <- median(chisq, na.rm=TRUE) / qchisq(0.5, 1)
print(paste("Lambda:", round(lambda, 3)))

# QQ plot
qq(sumstats$P, main="QQ plot — After QC")
```

**Questions:**
- Compare λ between the two models.  
- Which model shows less inflation?  
- What could explain the difference?

---

### Exercise 2 — Manhattan Plot

Create Manhattan plots for your best model(s) using `qqman`.  
Ensure the columns `CHR`, `BP`, `SNP`, and `P` exist and are numeric.

**R Example (Manhattan Plot):**
```r
library(qqman)
sumstats <- read.table("5_association/egfr_covar_afterqc.egfr.glm.linear", header=TRUE)

# Ensure column names match expected qqman format
manhattan(sumstats,
          chr="CHR", bp="BP", snp="ID", p="P",
          genomewideline=-log10(5e-8),
          main="Manhattan Plot — After QC")
```

---

### Exercise 3 — Identify Independent SNPs (Clumping)

Use **PLINK2** `--clump` to identify independent lead SNPs from the summary statistics.

**Example PLINK2 Command (Typical Window = 1000 kb):**
```bash
../bin/plink2   --bfile 4_Data_qc_admixture_pheno/genotyped_qc   --clump 5_association/egfr_covar_afterqc.egfr.glm.linear   --clump-p1 5e-8   --clump-p2 0.1   --clump-r2 0.1   --clump-kb 1000   --out 5_association/egfr_afterqc_clumped
```

**Notes:**
* `--clump` uses the association file to select index SNPs (based on P-value).  
* `--clump-p1` defines the primary significance threshold (commonly 5e-8).  
* `--clump-p2` sets the secondary threshold for nearby SNPs to be considered.  
* `--clump-r2` defines the LD threshold (e.g., 0.1).  
* `--clump-kb` specifies the physical distance window in kilobases (1000 kb = 1 Mb).  
  > `100000` would correspond to 100 Mb — likely too large.

**Question:**
- How many independent SNPs were identified?  
- Have these SNPs (or regions) been reported before in the **GWAS Catalog**?

---

### Exercise 4 — Regional (Locus) Plots

Create regional plots around lead SNPs to visualize association signals and local LD.  
You can use **LocusZoom**, **ggplot2** + LD matrices from PLINK, or the R package **locusplotr**.

We will use an adapted version of `locusplotr` that computes LD directly around the lead SNP.

**R Example (using `gg_locusplot`):**
```r
library(locusplotr)
gg_locusplot(
  df = Data,
  lead_snp = "rs1719245",
  rsid = "ID",
  chrom = "CHR",
  pos = "POS",
  ref = "REF",
  alt = "ALT",
  p_value = P,
  plot_genes = TRUE,
  genome_build = "GRCh38",
  plink = "../../bin/plink",
  bfile = "../Data_qc/genotyped_qc",
  compute_ld = TRUE
)
```

---

## Summary Questions

* How does λ (genomic inflation) change before vs. after QC and ancestry adjustment?  
* How many independent signals remain after clumping?  
