
# we tested different models using plink2 
## no covariable
plink2  --bfile ../1_Data_beforeqc/afreur --pheno  ../1_Data_beforeqc/afreur_pheno.tsv  --pheno-name egfr -out ../5_association/egfr_beforeqc --glm 'allow-no-covars'
#  covariables
plink2  --bfile ../1_Data_beforeqc/afreur --pheno  ../1_Data_beforeqc/afreur_pheno.tsv  --pheno-name egfr -out ../5_association/egfr_covar_beforeqc --glm 'hide-covar'  --covar-name age,Sex --covar ../1_Data_beforeqc/afreur_pheno.tsv
plink2  --bfile ../4_Data_qc_admixte_pheno/genotyped_qc --pheno  ../4_Data_qc_admixte_pheno/qc_pheno.tsv  --pheno-name egfr -out ../5_association/egfr_covar_afterqc --glm 'hide-covar'  --covar-name age,Sex,Superpopulation --covar ../4_Data_qc_admixte_pheno/qc_pheno.tsv


# clump data to extract independant SNPs 
plink2 -bfile ../1_Data_beforeqc/afreur  --clump ../5_association/egfr_covar_afterqc.egfr.glm.linear --clump-p1 5e-8 --clump-p2 0.1 --clump-r2 0.1 --clump-kb 100000


