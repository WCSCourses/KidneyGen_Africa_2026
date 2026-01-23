library(data.table)
library(ggplot2)

# we are checking 
datacv<-fread(text=system('grep CV admixture/*.out', intern=T))
# K = 2 
plot(1:5, datacv$V4, type='b')
# 
datafam<-read.table('admixture/afreur_pihat_indep.fam') 
dataadm<-read.table('admixture/afreur_pihat_indep.2.Q')

# phenotype
#../1_Data_beforeqc/afreur_pheno.tsv
datapheno<-read.table('../2_Data_qc_genotype/afreur_pheno.tsv',header=T)

dataadm<-cbind(datafam[,c(1,2)], dataadm);names(dataadm)<-c('FID','IID','Adm.1','Adm.2')

## we merge data admixture and phenotype
allpheno<-merge(datapheno,dataadm, by=c(1,2),all=F)

head(allpheno)
# Adm.1 is relative to european and Adm.2 to african
#  FID     IID   Sex Superpopulation age         Sc      egfr    Adm.1    Adm.2
#1   0 HG00096   Men             EUR  49 0.08248998 215.46020 0.981889 0.018111
#2   0 HG00097 Women             EUR  50 1.23685619  53.18058 0.987229 0.012771

allpheno$with_admixture<-F
# individual with admixture adn less than 70 and eiropean
allpheno[allpheno$Adm.1<0.7 & allpheno$Superpopulation=='EUR',]
allpheno$with_admixture[allpheno$Adm.1<0.7 & allpheno$Superpopulation=='EUR']<-T
# individual with admixture adn less than 70 and eiropean
allpheno[allpheno$Adm.2<0.7 & allpheno$Superpopulation=='AFR',]
allpheno$with_admixture[allpheno$Adm.2<0.7 & allpheno$Superpopulation=='AFR']<-T

pdf('barplot_admixture.pdf', width = 7*2,  height = 7)
barplot(t(as.matrix(allpheno[order(allpheno$Superpopulation, allpheno$Adm.1),c('Adm.1','Adm.2')])), col=rainbow(2),xlab="Individual #", ylab="Ancestry", border=NA)
dev.off()


# pcs plot 
datapcs<-read.table('admixture/afreur_pihat_indep.eigenvec',header=F)
names(datapcs)<-c('FID','IID',paste('Pcs_',1:(ncol(datapcs)-2),sep=''))
allpheno_pcs<-merge(datapcs,allpheno, by=c(1,2),all=F)

dataeigenval<-read.table('admixture/afreur_pihat_indep.eigenval',header=F)
plot(dataeigenval$V1, type='h', xlab='pc number', ylab='eigenval')
ggsave('eigenval_plot.pdf')

ggplot(allpheno_pcs,aes(x=Pcs_1,y=Pcs_2, col=Superpopulation))+geom_point()
ggsave('pcs12_plot.pdf')

write.table(allpheno_pcs[!(allpheno_pcs$with_admixture),!(names(allpheno_pcs) %in% 'with_admixture')], file='../3_Data_qc_admixture/afreur_pheno_qc.tsv' ,row.names=F,col.name=T, sep='\t',quote=F)
system('plink2 -bfile ../2_Data_qc_genotype/afreur_qc_rel --keep ../3_Data_qc_admixture/afreur_pheno_qc.tsv --make-bed -out ../3_Data_qc_admixture/afreur_qc_rel_adm')




