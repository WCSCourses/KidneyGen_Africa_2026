###############################################################################
# 🧬 Exercise: Build APOL1 Haplotypes (G0, G1, G2) and Identify High-Risk Genotypes
# Author: [Your Name]
# Date: [Date]
# -----------------------------------------------------------------------------
# Objective:
#   From collaborator’s VCF-derived genotype table, classify each individual’s
#   APOL1 haplotypes (G0, G1, G2) based on key risk variants:
#     - rs73885319 (p.S342G)
#     - rs60910145 (p.I384M)
#     - rs71785313 (6 bp deletion)
#
#   Combine the haplotypes into genotype pairs (e.g., G0/G1, G1/G2, G2/G2)
#   and flag individuals carrying two risk alleles (G1 or G2) as “high risk”.
#
# Input:
#   - A CSV file ("APOL1_risk_genotypes.csv") with per-individual genotypes:
#       ID, rs73885319_g1, rs73885319_g2,
#           rs60910145_g1, rs60910145_g2,
#           rs71785313_g1, rs71785313_g2
#
# Output:
#   - Columns appended to the input:
#       * riskallele_h1, riskallele_h2: APOL1 haplotype for each chromosome
#       * haplo_apol1: combined haplotype pair (e.g., "G1/G0")
#       * high_risk: indicator (1 = high risk, 0 = low risk)
#
# Skills practiced:
#   - Conditional indexing in R
#   - Logical operators and vectorized assignments
#   - String concatenation and classification
#   - Basic quality control and summary outputs
###############################################################################

# Load genotype data
datageno <- read.csv('APOL1_risk_genotypes.csv')

## ------------------------------------------------------------
## Step 1. Initialize variables
## ------------------------------------------------------------

# Create two new columns to store haplotype labels (one per chromosome)
datageno$riskallele_h1 <- NA
datageno$riskallele_h2 <- NA

## ------------------------------------------------------------
## Step 2. Define haplotypes (G0, G1, G2) for each haplotype copy
## ------------------------------------------------------------

# 🧬 Note: make sure the genotype column names match your CSV (here 'datageno', not 'data_geno')
# G0 = reference haplotype (no risk variants)
datageno$riskallele_h1[
  datageno$rs73885319_g1 == 'A' & 
  datageno$rs60910145_g1 == 'T' & 
  datageno$rs71785313_g1 == 'AATAATT'
] <- 'G0'

datageno$riskallele_h2[
  datageno$rs73885319_g2 == 'A' & 
  datageno$rs60910145_g2 == 'T' & 
  datageno$rs71785313_g2 == 'AATAATT'
] <- 'G0'


# G1 = carries G alleles at rs73885319 and rs60910145 (but not the G2 deletion)
datageno$riskallele_h1[
  datageno$rs73885319_g1 == 'G' & 
  datageno$rs60910145_g1 == 'G' & 
  datageno$rs71785313_g1 == 'AATAATT'
] <- 'G1'

datageno$riskallele_h2[
  datageno$rs73885319_g2 == 'G' & 
  datageno$rs60910145_g2 == 'G' & 
  datageno$rs71785313_g2 == 'AATAATT'
] <- 'G1'


# G2 = 6 bp deletion at rs71785313 (A instead of AATAATT)
datageno$riskallele_h1[
  datageno$rs73885319_g1 == 'A' & 
  datageno$rs60910145_g1 == 'T' & 
  datageno$rs71785313_g1 == 'A'
] <- 'G2'

datageno$riskallele_h2[
  datageno$rs73885319_g2 == 'A' & 
  datageno$rs60910145_g2 == 'T' & 
  datageno$rs71785313_g2 == 'A'
] <- 'G2'

## ------------------------------------------------------------
## Step 3. Build combined genotype (haplotype pair)
## ------------------------------------------------------------

# Concatenate the two haplotypes into a single column (e.g., "G0/G1", "G1/G2")
datageno$haplo_apol1 <- paste(datageno$riskallele_h1, datageno$riskallele_h2, sep = '/')

## ------------------------------------------------------------
## Step 4. Define high-risk individuals
## ------------------------------------------------------------

# "High risk" if both alleles are risk variants (G1 or G2)
# That is, both not equal to G0
datageno$high_risk <- as.integer(datageno$riskallele_h1 != 'G0' & datageno$riskallele_h2 != 'G0')

## ------------------------------------------------------------
## Step 5. Output or view result
## ------------------------------------------------------------
#head(datageno[, c("ID", "haplo_apol1", "high_risk")])
write.csv(datageno, file='APOL1_risk_genotypes_and_haplotype.csv', row.names=F)
