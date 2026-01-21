# 📄 Description of the VCF File

The **Variant Call Format (VCF)** is a standard text file format used in bioinformatics to represent genetic variation data such as **single nucleotide polymorphisms (SNPs)**, **insertions**, and **deletions** identified in one or more samples.

A VCF file is divided into two main sections:

1. **Header section**  
   Begins with lines starting with `##` that describe metadata (e.g., reference genome, annotation sources, file format version).  
   The final header line starts with `#CHROM` and defines the column names, including sample identifiers.

2. **Data section**  
   Each subsequent line represents a genomic variant with the following standard columns:
   - `CHROM`: Chromosome name  
   - `POS`: Genomic position  
   - `ID`: Variant identifier (e.g., rsID)  
   - `REF`: Reference allele  
   - `ALT`: Alternate allele(s)  
   - `QUAL`: Quality score for the variant call  
   - `FILTER`: Filter status of the variant  
   - `INFO`: Additional information and annotations  
   - `FORMAT`: Describes the structure of genotype fields  
   - **Sample columns**: Genotype data and related information for each individual (e.g., `0/0`, `0/1`, `1/1`)

## 🧬 Genotype Representation and Phasing

Each genotype is represented using allele codes:
- `0` = reference allele  
- `1` = alternate allele  

For example:
- `0/0` → homozygous reference  
- `0/1` → heterozygous  
- `1/1` → homozygous alternate  

The **separator symbol** between alleles conveys information about **phasing**:
- `0/1` → **unphased** genotype (the origin of each allele—maternal or paternal—is unknown).  
- `0|1` → **phased** genotype, indicating the alleles are assigned to specific haplotypes (e.g., `0` on the maternal chromosome and `1` on the paternal).  

Phasing is particularly important in **haplotype-based analyses**, such as imputation, recombination rate estimation, or studies of compound heterozygosity.  
Phased VCFs are usually the output of tools such as **SHAPEIT**, **BEAGLE**, or **Eagle**.

## ⚙️ File Handling

VCF files are often compressed (`.vcf.gz`) and indexed (`.tbi`) for efficient storage and querying.  
They can be manipulated using tools such as:
- **bcftools** — for querying, filtering, merging, and annotation  
- **vcftools** — for quality control and summary statistics  
- **plink** — for genotype conversion, association testing, and frequency computation
- **R** — for conversion, association testing, and frequency computation and small dataset
- **python** — for conversion, association testing, and frequency computation and small dataset

## 🧩 Example of a VCF File

Below is a simplified example of a VCF file showing both **unphased** (`/`) and **phased** (`|`) genotypes.

```text
##fileformat=VCFv4.2
##reference=GRCh38
##INFO=<ID=DP,Number=1,Type=Integer,Description="Total Depth">
##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
#CHROM  POS       ID           REF  ALT  QUAL  FILTER  INFO     FORMAT  Sample1  Sample2  Sample3
22      36661906  rs73885319   G    A    99    PASS    DP=42    GT      0/1      1/1      0|1
22      36662063  rs60910145   T    G    99    PASS    DP=38    GT      0/0      0/1      1|1
```

