# Phenotype cleaning 

## phenotype file and eGFR 
* `afreur_pheno.csv`: Phenotype file containing demographic and clinical information.
  * **FID**: Family ID
  * **IID**: Individual ID
  * **Sex**: Biological sex (Men/Women)
  * **Superpopulation**: Broad ancestry group (e.g., EUR, AFR, etc.)
  * **age**: Age of the individual at the time of measurement
  * **Sc**: Serum creatinine level (milligrams per deciliter (mg/dL))
  * **egfr**: Estimated glomerular filtration rate using equation of 2009 (eGFR (mL/min/1.73 m²))

egfr had been computed using serum creatinine, value common accepted of egfr are between 10 and 150 
value of egfr usually are different in function of origins, sex.

we are using dataset in file `3_Data_qc_admixture/afreur_pheno.csv`, objective is to research outlier, and analyse how ancestry, and sex change egfr to see what to include 

## Excercice
Using R, open phenotype file, extract value more than 150 and 10, excluded them. 
exclude indivdiaul had been excluded from previous qc using fam file `3_Data_qc_admixture/genotyped_qc.fam`
check if sex and ancestry using glm function are a putative confounder?
clean plink file and phenotype file and five a final qc file 
