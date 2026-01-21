# 🧬 `chr22.apol1.vcf.gz` — APOL1 Region from the 1000 Genomes Project

The file **`chr22.apol1.vcf.gz`** is a **compressed VCF (Variant Call Format)** file derived from the **1000 Genomes Project** dataset.  
It contains **genetic variants located on chromosome 22**, focusing on the **APOL1 gene region**, which is known to harbor kidney disease–associated alleles (notably the G1 and G2 variants).

---

## 📁 File Description

| **Attribute** | **Description** |
|----------------|-----------------|
| **Filename** | `chr22.apol1.vcf.gz` |
| **Format** | VCF (bgzip-compressed) |
| **Source** | 1000 Genomes Project (Phase 3) |
| **Chromosome** | 22 |
| **Region** | Surrounding the *APOL1* gene |
| **Reference genome** | GRCh38 / hg38 |
| **Content** | SNPs and small indels in the *APOL1* locus, with genotype information for all individuals in the 1000 Genomes cohort |
| **Related metadata** | The corresponding sample information is provided in [`info_ind.txt`](./info_ind.txt) |

---

## 🧬 Gene Context

| **Gene** | **Chromosome** | **Approx. Genomic Coordinates (hg38)** | **Known Variants of Interest** |
|-----------|----------------|---------------------------------------|--------------------------------|
| **APOL1** (*Apolipoprotein L1*) | 22 | chr22:36,625,000–36,655,000 | G1 (rs73885319, rs60910145), G2 (6 bp deletion, rs71785313) |

---

## ⚙️ Notes

- The **VCF** file follows standard conventions with columns:  
  `CHROM`, `POS`, `ID`, `REF`, `ALT`, `QUAL`, `FILTER`, `INFO`, `FORMAT`, and one column per individual (sample ID).
- Genotypes are represented as phased alleles (e.g., `0|1`, `1|1`, `0|0`).
- The file can be indexed using **tabix** for efficient querying:
  ```bash
  tabix -p vcf chr22.apol1.vcf.gz
  ```
- To extract variants for *APOL1*, for example:
  ```bash
  bcftools view chr22.apol1.vcf.gz -r 22:36625000-36655000 -Oz -o apol1_region.vcf.gz
  ```

---

# 🧬 `info_ind.txt` — 1000 Genomes Individual Metadata

The file **`info_ind.txt`** contains metadata for each individual represented in the **VCF file** from the **1000 Genomes Project**.  
It provides essential information about **family structure**, **sex**, and **population ancestry**.

---

## 📄 File Structure Overview

| **Column Name** | **Description** |
|-----------------|-----------------|
| `FamilyID` | Family identifier (used for trio or pedigree analyses). |
| `SampleID` | Unique individual/sample identifier in the VCF file. |
| `FatherID` | Identifier of the father (`0` if unknown). |
| `MotherID` | Identifier of the mother (`0` if unknown). |
| `Sex` | Biological sex (`1` = Female, `2` = Male). |
| `Population` | Specific population code (e.g., YRI, CEU, CHB). |
| `Superpopulation` | Broad continental grouping (`AFR`, `AMR`, `EAS`, `EUR`, `SAS`). |

---

## 💾 Example Content

```text
FamilyID  SampleID  FatherID  MotherID  Sex  Population  Superpopulation
HG00096   HG00096   0         0         1    GBR         EUR
HG00097   HG00097   0         0         2    GBR         EUR
HG00099   HG00099   0         0         2    GBR         EUR
```

---

## 🌍 Superpopulations

| **Code** | **Region** | **Description** |
|-----------|-------------|-----------------|
| **AFR** | Africa | Individuals of African ancestry |
| **AMR** | Americas | Admixed American ancestry |
| **EAS** | East Asia | Individuals of East Asian ancestry |
| **EUR** | Europe | Individuals of European ancestry |
| **SAS** | South Asia | Individuals of South Asian ancestry |

---

## 👥 Populations and Corresponding Superpopulations

| **Superpopulation** | **Population Code** | **Population Description** |
|----------------------|---------------------|-----------------------------|
| **AFR** | ACB | African Caribbeans in Barbados |
|  | ASW | Americans of African Ancestry in SW USA |
|  | ESN | Esan in Nigeria |
|  | GWD | Gambian in Western Division, The Gambia |
|  | LWK | Luhya in Webuye, Kenya |
|  | MSL | Mende in Sierra Leone |
|  | YRI | Yoruba in Ibadan, Nigeria |
| **AMR** | CLM | Colombians in Medellín, Colombia |
|  | MXL | Mexican Ancestry in Los Angeles, USA |
|  | PEL | Peruvians in Lima, Peru |
|  | PUR | Puerto Ricans in Puerto Rico |
| **EAS** | CDX | Chinese Dai in Xishuangbanna, China |
|  | CHB | Han Chinese in Beijing, China |
|  | CHS | Southern Han Chinese |
|  | JPT | Japanese in Tokyo, Japan |
|  | KHV | Kinh in Ho Chi Minh City, Vietnam |
| **EUR** | CEU | Utah Residents (CEPH) with Northern and Western European ancestry |
|  | FIN | Finnish in Finland |
|  | GBR | British in England and Scotland |
|  | IBS | Iberian Population in Spain |
|  | TSI | Toscani in Italy |
| **SAS** | BEB | Bengali in Bangladesh |
|  | GIH | Gujarati Indian in Houston, Texas |
|  | ITU | Indian Telugu in the UK |
|  | PJL | Punjabi in Lahore, Pakistan |
|  | STU | Sri Lankan Tamil in the UK |

---

## ⚧ Sex Coding

| **Code** | **Sex** | **Chromosomes** |
|-----------|----------|-----------------|
| `1` | Female | XX |
| `2` | Male | XY |

---





