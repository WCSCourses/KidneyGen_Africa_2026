library(ggplot2)
library(plyr)
# to performed quality control
datapheno<-read.table('../3_Data_qc_admixture/afreur_pheno_qc.tsv',header=T)
# identification of weird value 

# value less than 10 and more than 150 can be considered as outlier
## data look follow normality
mu <- ddply(datapheno, "Superpopulation", summarise, grp.mean=mean(egfr))
p<-ggplot(datapheno, aes(x=egfr, color=Superpopulation)) +
  geom_histogram(fill="white", position="dodge")+
  geom_vline(data=mu, aes(xintercept=grp.mean, color=Superpopulation),
             linetype="dashed")+
  theme(legend.position="top")

datapheno2<-datapheno[datapheno$egfr>= 10 & datapheno$egfr<=150,]

# high correlation between age, sex amd orgin
summary(glm(egfr~age+Superpopulation+Sex, data=datapheno2))
datapheno2$Sex2<-as.integer(as.factor(datapheno2$Sex))

write.table(datapheno2, file='../4_Data_qc_admixte_pheno/qc_pheno.tsv', row.names=F ,col.names=T, quote=F)
system("plink2 -bfile ../3_Data_qc_admixture/afreur_qc_rel_adm --make-bed -keep ../4_Data_qc_admixte_pheno/qc_pheno.tsv -out ../4_Data_qc_admixte_pheno/genotyped_qc")

