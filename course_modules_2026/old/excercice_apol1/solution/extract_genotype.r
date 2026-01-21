###############################################################################
# Exercise: Extract positions and genotypes for risk alleles (APOL1, p.N264K)
# Author: [Your Name]
# Date: [Date]
# -----------------------------------------------------------------------------
# Objective:
#   From a collaborator’s VCF file, extract genotypes for APOL1 variants
#   associated with kidney disease risk, including the p.N264K variant.
#   Output should list sample IDs and allelic genotypes for each SNP.
###############################################################################

# Load required package -------------------------------------------------------
library(data.table)

# Define input file path (update if necessary)
vcf_file <- "../Data/chr22.apol1.vcf.gz"

# Step 1. Read the VCF file ---------------------------------------------------
# Skip the first 112 metadata lines (non-essential)
# Use multiple threads for efficiency
vcf <- fread(vcf_file, verbose = FALSE, skip = 112, nThread = 5)

# Step 2. Inspect the VCF structure ------------------------------------------
# First 10 column names should look like:
# "#CHROM" "POS" "ID" "REF" "ALT" "QUAL" "FILTER" "INFO" "FORMAT" "HG00096"
names(vcf)[1:10]

# Step 3. Define APOL1 risk variants ------------------------------------------
# Known APOL1 kidney risk alleles include:
#   rs73885319 (p.S342G)
#   rs60910145 (p.I384M)
#   rs71785313 (frameshift, part of G2 haplotype)
#   rs73885316 (often included as linked site)
#   p.N264K (rs73885319, key variant on APOL1)
listpos <- c('36265860', '36265988', '36265995', '36265628')
listrs  <- c('rs73885319', 'rs60910145', 'rs71785313', 'rs73885316')

# Step 4. Filter VCF for these variants ---------------------------------------
vcf_sub <- vcf[vcf$POS %in% listpos, ]
dim(vcf_sub)  # Should equal number of SNPs found

# Step 5. Extract and convert genotypes ---------------------------------------
# Each sample genotype is phased (e.g., "0|1")
# We split them and replace 0→REF and 1→ALT

# --- rs73885319 (p.N264K) ----------------------------------------------------
bp <- 36265860
rs73885319_g1 <- sapply(strsplit(unlist(vcf_sub[vcf_sub$POS == bp, 10:ncol(vcf_sub)]), split="|", fixed=TRUE), function(x) as.integer(x[1]))
rs73885319_g1 <- ifelse(rs73885319_g1 == 0, vcf_sub$REF[vcf_sub$POS == bp], vcf_sub$ALT[vcf_sub$POS == bp])

rs73885319_g2 <- sapply(strsplit(unlist(vcf_sub[vcf_sub$POS == bp, 10:ncol(vcf_sub)]), split="|", fixed=TRUE), function(x) as.integer(x[2]))
rs73885319_g2 <- ifelse(rs73885319_g2 == 0, vcf_sub$REF[vcf_sub$POS == bp], vcf_sub$ALT[vcf_sub$POS == bp])

# --- rs60910145 --------------------------------------------------------------
bp <- 36265988
rs60910145_g1 <- sapply(strsplit(unlist(vcf_sub[vcf_sub$POS == bp, 10:ncol(vcf_sub)]), split="|", fixed=TRUE), function(x) as.integer(x[1]))
rs60910145_g1 <- ifelse(rs60910145_g1 == 0, vcf_sub$REF[vcf_sub$POS == bp], vcf_sub$ALT[vcf_sub$POS == bp])

rs60910145_g2 <- sapply(strsplit(unlist(vcf_sub[vcf_sub$POS == bp, 10:ncol(vcf_sub)]), split="|", fixed=TRUE), function(x) as.integer(x[2]))
rs60910145_g2 <- ifelse(rs60910145_g2 == 0, vcf_sub$REF[vcf_sub$POS == bp], vcf_sub$ALT[vcf_sub$POS == bp])

# --- rs71785313 --------------------------------------------------------------
bp <- 36265995
rs71785313_g1 <- sapply(strsplit(unlist(vcf_sub[vcf_sub$POS == bp, 10:ncol(vcf_sub)]), split="|", fixed=TRUE), function(x) as.integer(x[1]))
rs71785313_g1 <- ifelse(rs71785313_g1 == 0, vcf_sub$REF[vcf_sub$POS == bp], vcf_sub$ALT[vcf_sub$POS == bp])

rs71785313_g2 <- sapply(strsplit(unlist(vcf_sub[vcf_sub$POS == bp, 10:ncol(vcf_sub)]), split="|", fixed=TRUE), function(x) as.integer(x[2]))
rs71785313_g2 <- ifelse(rs71785313_g2 == 0, vcf_sub$REF[vcf_sub$POS == bp], vcf_sub$ALT[vcf_sub$POS == bp])

# --- rs73885316 --------------------------------------------------------------
bp <- 36265628
rs73885316_g1 <- sapply(strsplit(unlist(vcf_sub[vcf_sub$POS == bp, 10:ncol(vcf_sub)]), split="|", fixed=TRUE), function(x) as.integer(x[1]))
rs73885316_g1 <- ifelse(rs73885316_g1 == 0, vcf_sub$REF[vcf_sub$POS == bp], vcf_sub$ALT[vcf_sub$POS == bp])

rs73885316_g2 <- sapply(strsplit(unlist(vcf_sub[vcf_sub$POS == bp, 10:ncol(vcf_sub)]), split="|", fixed=TRUE), function(x) as.integer(x[2]))
rs73885316_g2 <- ifelse(rs73885316_g2 == 0, vcf_sub$REF[vcf_sub$POS == bp], vcf_sub$ALT[vcf_sub$POS == bp])

# Step 6. Build genotype summary table ----------------------------------------
# Extract sample IDs (from column names starting at column 10)
sample_ids <- names(vcf_sub)[10:ncol(vcf_sub)]

# Build the final dataset with all risk variants
genotype_table <- data.frame(
  ID = sample_ids,
  rs73885319_g1 = rs73885319_g1, rs73885319_g2 = rs73885319_g2,
  rs60910145_g1 = rs60910145_g1, rs60910145_g2 = rs60910145_g2,
  rs71785313_g1 = rs71785313_g1, rs71785313_g2 = rs71785313_g2,
  rs73885316_g1 = rs73885316_g1, rs73885316_g2 = rs73885316_g2
)

# Step 7. Export the results --------------------------------------------------
# Output genotypes for risk alleles (including p.N264K)
write.csv(genotype_table, row.names = FALSE, file = "APOL1_risk_genotypes.csv", quote = FALSE)

# Step 8. Optional: Check p.N264K variant -------------------------------------
# (Specifically corresponds to rs73885319)
table(paste0(genotype_table$rs73885319_g1, "/", genotype_table$rs73885319_g2))
# This shows counts of REF/ALT combinations for p.N264K

###############################################################################
# End of script
###############################################################################

