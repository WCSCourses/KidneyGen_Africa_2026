FROM quay.io/cybozu/ubuntu:24.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV dirbin=/bin/

# =========================
# System dependencies
# =========================
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gfortran \
    python3 \
    python3-dev \
    python3-pip \
    wget \
    unzip \
    ca-certificates \
    apt-transport-https \
    git \
    libpng-dev \
    libopenblas-dev \
    cmake \
    libfontconfig1-dev \
    libcurl4-openssl-dev \
    libgl1-mesa-dev \
    xorg-dev \
    libcairo2-dev \
    libjpeg-dev \
    libtiff-dev \
    r-base \
    r-base-dev \
    vcftools \
    bcftools \
    tabix \
    bedtools \
    python3-numpy \
    python3-scipy \
    python3-pandas \
    python3-matplotlib \
    python3-openpyxl \
    python3-biopython \
    libxml2-dev \
 && rm -rf /var/lib/apt/lists/*

RUN  apt-get update && apt-get install -y libxml2-dev libfribidi-dev libssl-dev libharfbuzz-dev libgomp1 default-libmysqlclient-dev
# =========================
# R packages (CRAN + Bioconductor + GitHub)
# =========================
RUN R -e "for (l in  c('devtools', 'R.utils', 'data.table', 'ggplot2', 'qqman', 'dplyr', 'plyr', 'BiocManager','httr')){ \
    install.packages(l, dependencies=TRUE, repos='https://cran.rstudio.com/');\
    if ( ! library(l, character.only=TRUE, logical.return=TRUE) ) {\
        quit(status=1, save='no')\
    }}\
  "
RUN R -e "devtools::install_github('jeantristanb/locusplotr', ref = 'test')"

# =========================
# Install PLINK 1.9
# =========================
RUN mkdir -p plink && cd plink \
 && wget -c https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20250819.zip \
 && unzip plink_linux_x86_64_20250819.zip \
 && mv plink $dirbin \
 && cd ../ && rm -rf plink

# =========================
# Install PLINK 2
# =========================
RUN mkdir -p plink2 && cd plink2 \
 && wget -c https://s3.amazonaws.com/plink2-assets/alpha6/plink2_linux_avx2_20251026.zip \
 && unzip plink2_linux_avx2_20251026.zip \
 && mv plink2 $dirbin \
 && cd ../ && rm -rf plink2

# =========================
# Install ADMIXTURE
# =========================
RUN mkdir -p admixture && cd admixture \
 && wget -c https://dalexander.github.io/admixture/binaries/admixture_linux-1.3.0.tar.gz \
 && tar -xzf admixture_linux-1.3.0.tar.gz \
 && mv dist/admixture_linux-1.3.0/admixture $dirbin \
 && cd ../ && rm -rf admixture

RUN wget  https://github.com/rgcgithub/regenie/releases/download/v4.1/regenie_v4.1.gz_x86_64_Linux.zip && \
    unzip regenie_v4.1.gz_x86_64_Linux.zip && \
    chmod +x regenie_v4.1.gz_x86_64_Linux && \
    mv regenie_v4.1.gz_x86_64_Linux /usr/local/bin/regenie

RUN R -e "options(repos = BiocManager::repositories());BiocManager::install(version = '3.18'); options(timeout = 10000);BiocManager::install( c('MungeSumstats'))"
RUN R -e "options(repos = BiocManager::repositories());BiocManager::install(version = '3.18'); options(timeout = 10000);BiocManager::install(c('SNPlocs.Hsapiens.dbSNP155.GRCh38'))" 
RUN R -e "options(repos = BiocManager::repositories());BiocManager::install(version = '3.18'); options(timeout = 10000);BiocManager::install( 'BSgenome.Hsapiens.NCBI.GRCh38')"
RUN R -e "options(repos = BiocManager::repositories());BiocManager::install(version = '3.18'); options(timeout = 10000);BiocManager::install( 'BSgenome.Hsapiens.NCBI.GRCh38')"
RUN R -e "options(repos = BiocManager::repositories());BiocManager::install(version = '3.18'); options(timeout = 10000);BiocManager::install( 'SNPlocs.Hsapiens.dbSNP155.GRCh37')" 
RUN R -e "options(repos = BiocManager::repositories());BiocManager::install(version = '3.18'); options(timeout = 10000);BiocManager::install( 'BSgenome.Hsapiens.1000genomes.hs37d5')"

# =========================
# Default shell
# =========================
CMD ["/bin/bash"]

