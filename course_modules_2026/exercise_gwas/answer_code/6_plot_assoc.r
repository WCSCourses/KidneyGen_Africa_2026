# to plot library as qqman?
library(ggplot2)
library(qqman)
library(dplyr)
library(data.table)
library('locusplotr')
#egfr_beforeqc.egfr.glm.linear  egfr_beforeqc.log  egfr_covar_afterqc.egfr.glm.linear  egfr_covar_afterqc.log  egfr_covar_beforeqc.egfr.glm.linear  egfr_covar_beforeqc.log


Data<-fread('../5_association/egfr_beforeqc.egfr.glm.linear')
alpha<-median(qchisq(1-Data$P,1),na.rm=T)/qchisq(0.5,1)
qq(Data$P)

Data<-fread('../5_association/egfr_covar_beforeqc.egfr.glm.linear')
alpha<-median(qchisq(1-Data$P,1),na.rm=T)/qchisq(0.5,1)
qq(Data$P)

Data<-fread('../5_association/egfr_covar_afterqc.egfr.glm.linear');names(Data)[1]<-'CHR'
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
  plot_genes = TRUE,genome_build='GRCh38',plink='../bin/plink', bfile='../2_Data_qc_genotype/afreur_qc_rel',compute_ld=T)

ggsave('rs1719245.pdf')

