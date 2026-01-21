# 📊 Part. 3 Frequency Computation

## 🧠 Context


Genetic variant frequencies evolve over time under the influence of **demographic processes** (e.g., admixture, bottlenecks, migration) and **natural selection**.  
In the case of the **APOL1 gene**, the high-risk variants **G1** and **G2** arose in **West Africa** and were maintained by **positive selection** due to their roles in protection against *Trypanosoma brucei* parasites, which cause African sleeping sickness.

- **G1**: Confers **resistance to *Trypanosoma brucei gambiense*** infection, the agent of chronic sleeping sickness in West and Central Africa, although it may not be protective in other contexts.  
- **G2**: Is associated with **increased susceptibility to severe *T.b. gambiense*** disease but also with **reduced susceptibility to *T.b. rhodesiense***, which predominates in East Africa.  

As human populations migrated, mixed, and adapted to different selective pressures, the **distribution of G1 and G2 alleles** diverged geographically:
- **G1** is most frequent in **West Africa** (where *T.b. gambiense* is endemic).  
- **G2** occurs more commonly in **Southern Africa**, reflecting exposure to *T.b. rhodesiense*.  
- Outside Sub Saharan descent, both variants are **rare or absent**, consistent with the absence of trypanosome-driven selection.

Understanding how **APOL1 allele frequencies** vary between populations provides insights into:
- The **evolutionary history** of human adaptation to pathogens,  
- **Population structure** and migration events, and  
- The **distribution of kidney disease risk** across ancestries.

---

## 🧬 Applications

### 📂 Files

The file `Data/APOL1_haplotypes_highrisk.csv` contains approximately **3,000 samples** with individual genotypes, haplotype assignments, and high-risk classifications — generated as the result of [Part 2](apol1_part2.md).  
It is a comma-separated file with the following headers:

* `ID`: ID of individuals  
* `rs73885319_g1`: genotype 1 (phased) of rs73885319 (p.S342G), values are **A/G**  
* `rs73885319_g2`: genotype 2 (phased) of rs73885319 (p.S342G), values are **A/G**  
* `rs60910145_g1`: genotype 1 (phased) of rs60910145 (p.I384M), values are **T/G**  
* `rs60910145_g2`: genotype 2 (phased) of rs60910145 (p.I384M), values are **T/G**  
* `rs71785313_g1`: genotype 1 (phased) of rs71785313 (p.N388_Y389del), values are **AATAATT/A**  
* `rs71785313_g2`: genotype 2 (phased) of rs71785313 (p.N388_Y389del), values are **AATAATT/A**  
* `rs73885316_g1`: genotype 1 (phased) of rs73885316 (p.N264K), values are **C/A**  
* `rs73885316_g2`: genotype 2 (phased) of rs73885316 (p.N264K), values are **C/A**  
* `riskallele_h1`: inferred APOL1 haplotype of allele 1 (**G0**, **G1**, or **G2**)  
* `riskallele_h2`: inferred APOL1 haplotype of allele 2 (**G0**, **G1**, or **G2**)  
* `haplo_apol1`: combined APOL1 genotype showing both haplotypes (e.g., **G0/G0**, **G1/G0**, **G1/G1**, **G1/G2**)  
* `high_risk`: binary indicator (0 = low risk, 1 = high risk) according to the **recessive model**  
  - **High-risk** = individuals carrying two risk haplotypes (**G1/G1**, **G2/G2**, or **G1/G2**)


### 🧪 Steps



Using your dataset containing **individual IDs**, **ethnicity or population origin**, and **APOL1 genotype data** (`G0`, `G1`, `G2`):

1. **Group individuals by population or ancestry**  
   (e.g., African American, West African, East African, European, etc.).

2. **Compute allele frequencies** for each variant:
   - Frequency of **G1 alleles** (from `rs73885319` and `rs60910145`),  
   - Frequency of **G2 alleles** (from `rs71785313`),  
   - Optionally, compute **genotype frequencies** (e.g., `G0/G0`, `G0/G1`, `G1/G1`, `G0/G2`, `G1/G2`, `G2/G2`),  
   - Compare frequencies by **superpopulation** (e.g., AFR, EUR, EAS, AMR, SAS) and, when relevant, by **subpopulation**.

3. **Compare frequency differences** between populations to evaluate **allelic diversity**, **population differentiation**, and potential **selection signatures**.

---

### 🧾 Example of Output

| SuperPopulation | G0_freq | G1_freq | G2_freq | HighRisk_freq |
| --------------- | ------- | ------- | ------- | ------------- |
| **EUR**         | 1.00    | 0.00    | 0.00    | 0.00          |
| **AMR**         | 0.50    | 0.10    | 0.05    | 0.01          |
| **AFR**         | 0.40    | 0.30    | 0.20    | 0.15          |

---

### 🧠 Notes

- **G1_freq** and **G2_freq** represent the proportion of alleles observed in each superpopulation.  
- You may extend this to compute **high-risk genotype frequencies** (`G1/G1`, `G1/G2`, `G2/G2`) within or across populations.  
- Results should reflect known **geographic and selective patterns**:

---
