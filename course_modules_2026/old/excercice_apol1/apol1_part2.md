# Part.2 Excercice : Built APOL1 risk allele 

## 🧬 APOL1 Haplotype Definitions

This table summarizes the **allelic composition** of the main APOL1 haplotypes  
(**G0**, **G1**, and **G2**) across the key variants defining kidney disease risk.

| Haplotype | rs73885319 (p.S342G) | rs60910145 (p.I384M) | rs71785313 (p.N388_Y389del) | Description |
|------------|----------------------|----------------------|-----------------------------|--------------|
| **G0 (Reference)** | A (REF) | T (REF) | AATAATT (REF) | Reference haplotype — no risk variants; low-risk. |
| **G1** | G (ALT) | G (ALT) | AATAATT (REF) | Contains two missense mutations (S342G and I384M) on the same haplotype; high-risk. |
| **G2** | A (REF) | T (REF) | A (6 bp deletion) | In-frame deletion removing N388 and Y389; high-risk. |

### 🧠 Notes

- **G1** and **G2** are **mutually exclusive** haplotypes (do not occur together on the same chromosome).  
- **G1** is defined by rs73885319 (A→G) and rs60910145 (T→G).  
- **G2** is defined by the 6 bp deletion at rs71785313 (AATAATT→A).  
- Individuals carrying **two risk haplotypes** (G1/G1, G2/G2, or G1/G2) are considered **high-risk** under a recessive model.  
- Coordinates correspond to the **GRCh38 (hg38)** reference genome.


## 🧬 Application : build G0 / G1 / G2

### 📂 Files

The file `Data/APOL1_risk_genotypes.csv` contains approximately **3,000 samples** with variants located around the **APOL1 gene** and is the result of [Part 1](apol1_part1.md).  
It is a comma-separated file with the following headers:

* `ID`: ID of individuals  
* `rs73885319_g1`: genotype 1 (phased) of rs73885319 (p.S342G), values are **A/G**  
* `rs73885319_g2`: genotype 2 (phased) of rs73885319 (p.S342G), values are **A/G**  
* `rs60910145_g1`: genotype 1 (phased) of rs60910145 (p.I384M), values are **T/G**  
* `rs60910145_g2`: genotype 2 (phased) of rs60910145 (p.I384M), values are **T/G**  
* `rs71785313_g1`: genotype 1 (phased) of rs71785313 (p.N388_Y389del), values are **AATAATT/A**  
* `rs71785313_g2`: genotype 2 (phased) of rs71785313 (p.N388_Y389del), values are **AATAATT/A**  
* `rs73885316_g1`: genotype 1 (phased) of rs73885316 (p.N264K), values are **C/A**  
* `rs73885316_g2`: genotype 2 (phased) of rs73885316 (p.N264K), values are **C/A**` 


### 🧪 Steps

Using the table describing the **G0**, **G1**, and **G2** haplotypes and the corresponding **rsIDs**,  
and based on the results from the previous exercise,  
build for each individual their **APOL1 genotype** (combination of two haplotypes, e.g., G0/G1, G1/G1, G2/G0, etc.).

Then, classify individuals according to the **recessive risk model**,  
where those carrying **two risk haplotypes** (`G1/G1`, `G2/G2`, or `G1/G2`) are considered **high-risk**,  
and all others (`G0/G0`, `G0/G1`, `G0/G2`) are considered **low-risk**.

### 🧾 Example of Expected Output

After computing the APOL1 genotypes for each individual using the variants  
`rs73885319`, `rs60910145`, and `rs71785313`,  
the resulting summary table could look like this:

| ID      | riskallele_h1 | riskallele_h2 | haplo_apol1 | high_risk |
| ------- | ------------- | ------------- | ----------- | --------- |
| HG00096 | G1            | G0            | G1/G0       | 0         |
| HG00097 | G0            | G2            | G0/G2       | 0         |
| HG00099 | G1            | G1            | G1/G1       | 1         |


### 🧠 Notes

- **APOL1_G1** = 1 if the individual carries a G1 haplotype (based on rs73885319 + rs60910145), otherwise 0.  
- **APOL1_G2** = 1 if the individual carries a G2 haplotype (rs71785313 deletion), otherwise 0.  
- **Genotype** represents the combination of two haplotypes (e.g., `G0/G1`, `G1/G2`, `G2/G2`, etc.).  
- **HighRisk** = 1 (high-risk) if the individual carries **two risk haplotypes** (`G1/G1`, `G2/G2`, or `G1/G2`); otherwise 0 (low-risk).  
- This classification follows the **recessive risk model** commonly used in APOL1 studies.

---

