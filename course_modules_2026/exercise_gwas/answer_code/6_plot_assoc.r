# to plot library as qqman?
library(qqman)
library(dplyr)
library(data.table)
library('locusplotr')

Data<-fread('egfr_raw.egfr.glm.linear')
alpha<-median(qchisq(1-Data$P,1),na.rm=T)/qchisq(0.5,1)
qq(Data$P)

Data<-fread('egfr_covar1.egfr.glm.linear')
alpha<-median(qchisq(1-Data$P,1),na.rm=T)/qchisq(0.5,1)
qq(Data$P)

Data<-fread('egfr_qc_covar1.egfr.glm.linear');names(Data)[1]<-'CHR'
alpha<-median(qchisq(1-Data$P,1),na.rm=T)/qchisq(0.5,1)
qq(Data$P)

pdf('save_manahantanplot.pdf')
manhattan(Data, chr='CHR',bp='POS', p='P',snp='ID')
dev.off()


gg_locusplot (df = Data,
  lead_snp = "rs1719245",
  rsid = 'ID',
  chrom = 'CHR',
  pos = 'POS',
  ref = 'REF',
  alt = 'ALT',
  p_value =P,
  plot_genes = TRUE,genome_build='GRCh38',plink='../../bin/plink', bfile='../Data_qc/genotyped_qc',compute_ld=T)
ggsave('rs1719245.pdf')
