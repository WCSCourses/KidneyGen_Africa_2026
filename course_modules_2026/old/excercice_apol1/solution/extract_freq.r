##############################################################################
# 🧬 APOL1 Allele Frequency Analysis by Population and Superpopulation
# -----------------------------------------------------------------------------
# Description:
#   This script reads individual genotype and metadata files to explore the
#   distribution of APOL1 risk alleles (G0, G1, G2) across populations and
#   superpopulations. It computes allele frequencies per group and visualizes
#   patterns of genetic diversity related to APOL1 variants.
#
# Author: [Your Name]
# Date: [Date]
# Dataset:
#   - APOL1_risk_genotypes_and_haplotype.csv : contains per-individual APOL1
#     genotypes and inferred haplotypes (riskallele_h1, riskallele_h2)
#   - info_ind.txt : contains individual metadata (Population, Superpopulation)
###############################################################################

# --- 1. Read input data ------------------------------------------------------

# Read genotype and haplotype data
DataGeno <- read.csv("APOL1_risk_genotypes_and_haplotype.csv", header = TRUE)

# Read individual metadata
Info_ind <- read.table("../Data/info_ind.txt", header = TRUE)

# Merge genotype data with population information
allgeno <- merge(DataGeno, Info_ind, by.x = "ID", by.y = "SampleID", all.x = TRUE)

# --- 2. Explore dataset composition ------------------------------------------

# Check sample size by Superpopulation
table(allgeno$Superpopulation)

# Check sample size by Population (within Superpopulation)
table(allgeno$Population)

# --- 3. Compute allele frequencies -------------------------------------------
# Combine alleles from haplotype 1 and haplotype 2 to compute frequencies
# across Superpopulations.

allele_counts <- table(
  c(allgeno$riskallele_h1, allgeno$riskallele_h2),
  c(allgeno$Superpopulation, allgeno$Superpopulation)
)

# Display allele counts
allele_counts

# --- 4. Focus on African and Admixed American samples ------------------------
# Select individuals from African (AFR) and Admixed American (AMR) groups
# to explore potential African ancestry contributions in AMR individuals.

allgeno_aframr <- allgeno[allgeno$Superpopulation %in% c("AFR", "AMR"), ]

# Compute allele frequencies by population within AFR and AMR groups
allele_pop_counts <- table(
  c(allgeno_aframr$riskallele_h1, allgeno_aframr$riskallele_h2),
  c(allgeno_aframr$Population, allgeno_aframr$Population)
)

# Compute allele frequencies (%) per population
frequency_compute <- apply(allele_pop_counts, 2, function(x) x / sum(x) * 100)

# Display results
frequency_compute

# --- 5. Interpretation -------------------------------------------------------
# Questions for interpretation:
# - What is your conclusion about APOL1 distribution between Superpopulations?
# - Where do the AMR alleles likely originate from?
# - Do the allele frequency patterns suggest African ancestry contributions

