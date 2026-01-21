# Data to performed GWAS
* **Genotype file in PLINK format:** `afreur.[bed, bim, fam]`  
  PLINK uses three main files to store genotype data efficiently:

  * **`.bed`** – **Binary genotype file**  
    Contains the actual genotype information in a compact binary format.  
    Each variant (SNP) is represented as a pair of alleles per individual.  
    This file is not human-readable and is designed for fast computation.

  * **`.bim`** – **Variant information file**  
    A text file with six columns describing each genetic variant:
    1. Chromosome number  
    2. SNP identifier (e.g., `rsID`)  
    3. Genetic distance (centimorgans; often set to 0)  
    4. Physical position (base-pair coordinate)  
    5. Allele 1 (usually the minor allele)  
    6. Allele 2 (usually the major allele)

  * **`.fam`** – **Sample information file**  
    A text file with six columns describing each individual:
    1. Family ID (`FID`)  
    2. Individual ID (`IID`)  
    3. Paternal ID (0 if missing)  
    4. Maternal ID (0 if missing)  
    5. Sex (1 = male, 2 = female, 0 = unknown)  
    6. Phenotype (1 = control, 2 = case, or quantitative value; -9 or 0 = missing)

  Together, these three files describe the full genotype dataset used for Genome-Wide Association Studies (GWAS).

* `afreur_pheno.csv`: Phenotype file containing demographic and clinical information.
  * **FID**: Family ID  
  * **IID**: Individual ID  
  * **Sex**: Biological sex (Men/Women)  
  * **Superpopulation**: Broad ancestry group (e.g., EUR, AFR, etc.)  
  * **age**: Age of the individual at the time of measurement  
  * **Sc**: Serum creatinine level (milligrams per deciliter (mg/dL)) 
  * **egfr**: Estimated glomerular filtration rate using equation of 2009 (eGFR (mL/min/1.73 m²))


