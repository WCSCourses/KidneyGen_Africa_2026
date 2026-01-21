# Part.1 Extraction of APOL1 risk variants from a vcf file

## 📄 Description of the VCF File

see [description here](info/vcf_description.nd)

## Part.1 Extract APOL1 Variants 

### Variants

[**APOL1**](https://www.ensembl.org/Homo_sapiens/Gene/Summary?g=ENSG00000100342;r=22:36253071-36267530)   is a gene located on **chromosome 22: 36,253,071–36,267,530 (GRCh38/hg38)**.  
It encodes Apolipoprotein L1, involved in innate immunity and parasitic resistance.  
Certain variants in this gene—known as **G1** and **G2**—are associated with increased kidney disease risk in individuals of recent African ancestry.

| rsID         | Chr | Position (hg38) | REF → ALT        | Amino Acid Change            | Functional Role         | Description |
|--------------|-----|----------------|------------------|------------------------------|--------------------------|-------------|
| **rs73885319** | 22  | 36,265,860     | A → G            | p.S342G (Ser → Gly)          | **G1** variant           | One of two missense mutations defining the G1 haplotype. |
| **rs60910145** | 22  | 36,265,988     | T → G            | p.I384M (Ile → Met)          | **G1** variant           | Occurs in strong LD with rs73885319; together define G1. |
| **rs71785313** | 22  | 36,265,995     | AATAATT→ A (6 bp del) | p.N388_Y389del            | **G2** variant           | In-frame 6 bp deletion removing two amino acids; defines G2. |
| **rs73885316** | 22  | 36,265,628     | C → A            | p.N264K (Asn → Lys)          | **Modifier / Protective**| Rare variant; may attenuate APOL1 risk when co-inherited. |
| —             | —   | —              | —                | —                            | **G0 (Reference)**       | Reference haplotype: neither G1 nor G2 present; low-risk. |

#### 🧠 Notes
- **G1** is defined by the *combined presence* of rs73885319 (A→G) and rs60910145 (T→G) on the same haplotype.
- **G2** is an *in-frame deletion* (rs71785313: AATAATT→ A) removing residues N388 and Y389. 
- Individuals carrying **two risk alleles** (G1/G1, G2/G2, or G1/G2) are classified as **high-risk** under a recessive model.  
- The **p.N264K (rs73885316)** variant is a *potential protective modifier*, observed in low frequency in African ancestry populations.  
- Coordinates correspond to the **GRCh38 (hg38)** reference genome.

---

## 🧬 Application : Extract APOL1 Risk Alleles (Including p.N264K) from a VCF File

### 🧠 Objective

From a collaborator’s VCF file, extract the **genomic positions** and **individual genotypes** for the **APOL1 risk variants**, including **p.N264K (rs73885319)**.

---

### 📂 Files

The file `Data/chr22.apol1.vcf` contains approximately **3,000 samples** with variants located around the **APOL1 gene**.  
All genotypes in this file are **phased**, meaning that alleles are represented as `0|1`, `1|0`, or `1|1`.

---

### 🧪 Steps

Using **R** (or any equivalent tool), extract from the provided VCF file:

1. The **positions** and **IDs** of the APOL1 variants of interest.  
2. The **individual phased genotypes** (e.g., `0|1`, `1|1`, or `0|0`).  
3. Replace genotype encodings:  
   - `0` → Reference allele (**REF**)  
   - `1` → Alternate allele (**ALT**)  
4. Create a summary table containing **REF/ALT alleles per sample** for each variant.  
5. Save the final table as `APOL1_risk_genotypes.csv`.

💬 *Note:*  
R is not mandatory. You can use other tools (e.g., `bcftools`, `awk`, or `plink`, `python`) to achieve the same result.

---


### 📘 Reading Data

- For large files (including compressed `.gz` files), use the `fread()` function from the **data.table** package.  
  Install the required libraries:

  ```r
  install.packages(c("data.table", "R.utils"))
  library(data.table)
  ```

- Functions like `fread()` or `read.table()` require a **consistent separator** and a **header**.  
  In some datasets, the header line starts after several commented lines (e.g., lines beginning with `#`).  
  You can skip these lines using `skip` or search for the line containing `"CHR"`.

  ```r
  # Skip lines until the header line containing "CHR"
  header_line <- system('zcat Data/chr22.apol1.vcf,gz|grep "#"',intern=T) 
  data <- fread("Data/chr22.apol1.vcf,gz", skip = length(header_line) - 1)
  ```

---

### 🧩 Splitting Genotype Strings

- The `strsplit()` function splits genotype strings such as `"0|1"` or `"1|1"` into alleles.  
  It returns a **list**, so use `sapply()` or `do.call()` to convert it to a list with geno 1.

  ```r
  genotypes <- c("0|1", "1|1", "0|0")
  split_geno <- strsplit(genotypes, "|", fixed)
  geno1 <- sapply(split_geno, function(x)x[1]))
  print(geno1)
  ```

- For a short tutorial on lists and string manipulation, see:  
  👉 [Software Carpentry: Supplementary Data Structures](https://swcarpentry.github.io/r-novice-inflammation/13-supp-data-structures.html)

---



---


#### 🧾 Expected Output

| ID       | rs73885319_g1 | rs73885319_g2 | rs60910145_g1 | rs60910145_g2 | rs71785313_g1 | rs71785313_g2 | rs73885316_g1 | rs73885316_g2 |
|-----------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|
| HG00096   | G             | A             | G             | G             | C             | -             | C             | C             |
| HG00097   | A             | A             | G             | A             | -             | -             | C             | A             |
| HG00099   | G             | G             | G             | G             | C             | C             | C             | C             |

