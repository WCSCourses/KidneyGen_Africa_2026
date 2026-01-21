# Training exercise for APOL1

## 🌍 General Context


The **APOL1 (Apolipoprotein L1)** gene, located on **chromosome 22 (22q12.3)**, encodes a protein involved in **innate immunity** and **protection against Trypanosoma parasites** that cause *African sleeping sickness*.  

However, two common coding variants — known as the **G1** and **G2** **risk alleles** — have been **strongly associated with increased susceptibility to kidney diseases**, particularly in individuals of **African ancestry**.  

- **G1 variant** → consists of two missense mutations:  
  - `rs73885319 (S342G)`  
  - `rs60910145 (I384M)`  

- **G2 variant** → involves a **6–base pair deletion** (`rs71785313`) that removes two amino acids (**N388** and **Y389**).  

🧬 **High-risk genotypes** — individuals carrying **two risk alleles** (`G1/G1`, `G2/G2`, or `G1/G2`) — have a **significantly increased risk** of developing:  
- **Focal segmental glomerulosclerosis (FSGS)**  
- **Hypertension-attributed end-stage kidney disease (ESKD)**  
- **HIV-associated nephropathy (HIVAN)** 

These variants illustrate a striking example of an **evolutionary trade-off**, where **protection against infection** came at the **cost of kidney disease risk**.

---

### 🌐 Population Frequency and Selection

The frequency of **APOL1 high-risk alleles** varies markedly across populations, reflecting their **evolutionary history** and **selective pressures**:

- Found **almost exclusively in individuals of recent African ancestry**.  
- Combined **risk allele frequency** ranges from **10% to >40%** in **West African** populations, where exposure to *Trypanosoma brucei* was historically common.  
- **Rare or absent** in **non-African populations** (Europeans, Asians, Indigenous Americans).  
- Within Africa, distribution is **heterogeneous**:  
  - **Higher** in **West and Central Africa** (e.g., *Yoruba, Igbo*).  
  - **Lower** in non bantu **East Africa** and **G2** is higher in **Bantu East African** and Southern Africa, mirroring the geographic spread of *T. brucei gambiense* and *T. b. rhodesiense*.  

🧩 This variability highlights **balancing selection** — risk alleles were **maintained** in populations where they **conferred resistance to trypanosome infection**, despite their **negative effect on kidney function**.

---

### 🧪 The p.N264K Protective Variant
```text 
rs73885316 (chr22:36265628 C > A, p.N264K, gnomAD AFR allele frequency = 0.03)
```

A third **APOL1 variant of emerging interest**, **p.N264K (`rs73885316`)**, is located in the **SRA-interacting domain** of the protein.

- Unlike **G1** and **G2**, which **increase kidney disease risk**,  
  **p.N264K** appears to be a **protective variant** that may **mitigate APOL1 cytotoxic effects**.  
- The **asparagine-to-lysine substitution (N→K at position 264)** changes the **charge and conformation** of the protein, affecting its interaction with the *Trypanosoma brucei* **SRA protein**.  
- Functional studies suggest that **p.N264K** can **reduce APOL1-induced cell toxicity** by modulating **ion channel activity** or **intracellular localization**, without fully compromising **trypanolytic function**.  

📊 **Population studies** show:
- **p.N264K** occurs at **low frequencies** in individuals of **African ancestry**.  
- It often coexists on the **same haplotype background** as **G1 or G2**.  
- Its presence has been associated with **reduced kidney disease risk** among **APOL1 high-risk carriers**, making it a **promising target** for understanding **genetic modifiers** and for **therapeutic development**.

---


## Exercise : general description

Your collaborator, Prof. Nephro Log, has sequenced a dataset including individuals from different continents and ethnic backgrounds using whole-genome sequencing. The goal is to estimate the prevalence of APOL1 high-risk variants and the p.N264K variant. However, your collaborator does not have the necessary skills to analyze the dataset.

You have received the following files:

* A VCF file containing the genotyped data in the APOL1 region
* A population information file describing the population or ethnic background of each individual
* Files can be found on [Github](https://github.com/jeantristanb/kidneygenafrica_course_january_2026/tree/main/day2_apol1/Data)

The aim of this work is to:

- **Understand the VCF format** and explore the main tools available to manipulate and process Variant Call Format (VCF) files.

- **Extract individual SNP genotypes** from the VCF corresponding to the **APOL1 risk variants**:
  - `rs73885319`
  - `rs60910145`
  - `rs71785313`

- **Compute APOL1 genotypes (G0, G1, G2)** for each individual and classify them according to the **recessive risk model**, where:
  - Individuals carrying **two risk alleles** (`G1/G1`, `G2/G2`, or `G1/G2`) are considered **high-risk**.
  - Individuals with other genotypes (`G0/G0`, `G0/G1`, or `G0/G2`) are considered **low-risk**.

- **Estimate allele and genotype frequencies by population** to evaluate the distribution and variability of **APOL1 risk alleles** across groups.

## Part 1. APOL1 Variants extraction

*See the exercise: [Part 1 – Extract APOL1 variants from a VCF file](apol1_part1.md)*

### Objectives
- Understand the **VCF file format** and how to manipulate it  
- Learn to **process VCF files** using tools such as **R**  
- Practice **data and string manipulation in R**

## Part 2. Build APOL1 High-Risk Variants

*See the exercise: [Part 2 – Build APOL1 risk alleles](apol1_part2.md)*

### Objectives
- Understand how to **construct haplotypes** and identify **high-risk alleles**


## Part 3. Compute Frequencies of APOL1 Haplotypes and Risk Alleles

*See the exercise: [Part 3 – Compute frequencies of APOL1 risk alleles](apol1_part3.md)*

### Objectives
- **Compute allele and haplotype frequencies**  
- **Compare frequency distributions** between populations

## Supplementary Exercise: Understand the Frequency of p.N264K and Its Relationship with High-Risk APOL1 Haplotypes

*See the exercise: [Supplementary – p.N264K and APOL1 high-risk haplotypes](apol1_part_supplementary.md)*

### Objectives
- **Understand the relationship** between **p.N264K** and **APOL1 high-risk haplotypes**  
- **Explore the frequency** and potential **protective role** of the p.N264K variant
