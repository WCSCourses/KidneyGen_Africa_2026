datageno<-read.csv('APOL1_risk_genotypes.csv')

## we build each relation

# initialisatio of vairables
datageno$riskallele_h1<-'NA'
datageno$riskallele_h2<-'NA'
# building G0
datageno$riskallele_h1[data_geno$rs73885319_g1=='A' & data_geno$rs60910145_g1=='T' & data_geno$rs71785313_g1=='AATAATT']<-'G0'
datageno$riskallele_h2[data_geno$rs73885319_g2=='A' & data_geno$rs60910145_g2=='T' & data_geno$rs71785313_g2=='AATAATT']<-'G0'

# building G1
datageno$riskallele_h1[data_geno$rs73885319_g1=='G' & data_geno$rs60910145_g1=='G' & data_geno$rs71785313_g1=='AATAATT']<-'G1'
datageno$riskallele_h2[data_geno$rs73885319_g2=='G' & data_geno$rs60910145_g2=='G' & data_geno$rs71785313_g2=='AATAATT']<-'G1'

# building G2
datageno$riskallele_h1[data_geno$rs73885319_g1=='A' & data_geno$rs60910145_g1=='T' & data_geno$rs71785313_g1=='A']<-'G2'
datageno$riskallele_h2[data_geno$rs73885319_g2=='A' & data_geno$rs60910145_g2=='T' & data_geno$rs71785313_g2=='A']<-'G2'


datageno$haplo_apol1 <- paste(datageno$riskallele_h1,datageno$riskallele_h2,sep='/')
#high risk : 2 alleles not G0
datageno$high_risk = 0
datageno$high_risk = as.integer(datageno$riskallele_h1!='G0' & datageno$riskallele_h2!='G0')
