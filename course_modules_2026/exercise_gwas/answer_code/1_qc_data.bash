# first step ccan be a clean with 
## frequency 
## missingness
## clean on maf, error genotyping less than 10 % for individual and positiosn, 
mkdir -p genotyped_qc
# HWE ?
../../bin/plink -bfile ../Data/afreur --make-bed -maf 0.01  --mind 0.05 --geno 0.05   -out genotyped_qc/afreur_qc

# second steps we used individual of plink to deleted relatdness
../../bin/plink2 --bfile genotyped_qc/afreur_qc --king-cutoff 0.17 -make-bed --out genotyped_qc/afreur_pihat



 
