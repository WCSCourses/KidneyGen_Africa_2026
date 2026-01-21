normalize_to_egfr_range <- function(x, new_min = 5, new_max = 150) {
  old_min <- min(x, na.rm = TRUE)
  old_max <- max(x, na.rm = TRUE)
  scaled <- new_min + (x - old_min) * (new_max - new_min) / (old_max - old_min)
  return(scaled)
}


adjust_egfr_by_ancestry <- function(eGFR, ancestry,
                                   mean_shift = c(
                                     AFR = 108,
                                     AMR = 104,
                                     EAS = 106,
                                     EUR = 102,
                                     SAS = 101),
                                   target_global_mean = 102,
                                   clip = TRUE, clip_min = 5, clip_max = 150) {
  
  ancestry <- toupper(as.character(ancestry))
  
  # Compute ancestry effect: shift relative to target global mean
  shift_effect <- mean_shift[ancestry] - target_global_mean
  
  # Apply additive adjustment
  adjusted <- eGFR + shift_effect
  
  # Optional clipping to physiological range
  if (clip) adjusted <- pmax(pmin(adjusted, clip_max), clip_min)
  
  return(adjusted)
}
scale_to_targets <- function(egfr, sex, mu_f = 110.3, mu_m = 103.8,
                             clip = TRUE, clip_min = 5, clip_max = 150) {
  sex <- tolower(as.character(sex))
  m_f <- mean(egfr[sex == "female"], na.rm = TRUE)
  m_m <- mean(egfr[sex == "male"],   na.rm = TRUE)
  k_f <- mu_f / m_f
  k_m <- mu_m / m_m
  adj <- ifelse(sex == "female", egfr * k_f,
                ifelse(sex == "male", egfr * k_m, NA_real_))
  if (clip) adj <- pmax(pmin(adj, clip_max), clip_min)
  adj
}

egfr_to_creatinine <- function(eGFR, age, sex) {
  # Constants based on sex
    kappa <- rep(0.7, length(eGFR))
    alpha <- rep(-0.241, length(eGFR))
    sex_factor <- rep(1.012,length(eGFR))

    kappa[sex==1] <- 0.9
    alpha[sex==1] <- -0.302
    sex_factor[sex==1] <- 1.0
  
  # Common part of the formula
  A <- 142 * (0.9938 ^ age) * sex_factor
  ratio <- eGFR / A
  
  # Case 1: Scr/kappa <= 1  →  use exponent 1/alpha
  Scr_case1 <- kappa * (ratio)^(1 / alpha)
  
  # Case 2: Scr/kappa > 1  →  use exponent -1/1.200
  Scr_case2 <- kappa * (ratio)^(-1 / 1.200)
  
  # Choose which applies (continuity around Scr/kappa = 1)
  # If result from case1 <= kappa, use it, otherwise use case2
  Scr <- ifelse(Scr_case1 <= kappa, Scr_case1, Scr_case2)
  
  return(Scr)
}
#wget -c https://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/GCST90103001-GCST90104000/GCST90103633/GCST90103633_buildGRCh37.tsv 
library(data.table)
library(MungeSumstats)
options(timeout=2000)

if(!file.exists('GCST90103633_buildGRCh38.tsv')){
DataGC37<-fread('GCST90103633_buildGRCh37.tsv',nThread=20)
cleandata<-MungeSumstats::format_sumstats(DataGC37,ref_genome="GRCh37",return_data=TRUE,bi_allelic_filter =TRUE,  on_ref_genome=T, nThread=20)
sumstats_dt_hg38 <- MungeSumstats::liftover(cleandata,ref_genome = "GRCh37", convert_ref_genome = "GRCh38",chain_source="ensembl",style='UCSC',as_granges=T)
write.table(sumstats_dt_hg38, file='GCST90103633_buildGRCh38.tsv', row.names=F,col.names=T)
}

sumstats_dt_hg38<-fread('GCST90103633_buildGRCh38.tsv')
# [1] "seqnames"             "start"                "end"                 
# [4] "width"                "strand"               "SNP"                 
# [7] "A1"                   "A2"                   "ID"                  
#[10] "N"                    "FRQ"                  "BETA"                
#[13] "SE"                   "P"                    "MAC"                 
#[16] "VARIANT_ID"           "IMPUTATION_gen_build"

sumstats_dt_hg382<-sumstats_dt_hg38[,c('seqnames','SNP','start','A1','A2','N','FRQ','BETA','SE','P')];names(sumstats_dt_hg382)<-c('CHR','SNP','BP','A1','A2','N','FRQ','BETA','SE','P')
sumstats_dt_hg382$CHR<-as.integer(gsub('chr','',sumstats_dt_hg382$CHR))
write.table(sumstats_dt_hg382,file='GCST90103633_buildGRCh38.assoc',row.names=F, col.names=T, sep='\t',quote=F)

bimfile<-fread('/spaces/jeantristan/Data/1000Geno/hg38/20220422_3202_phased_SNV_INDEL_SV/plink2/all_1000g_maf0.001.save.bim')
bimfile$V1<-as.character(bimfile$V1)
bimfile$order<-1:nrow(bimfile)
sumstats_dt_hg382$CHR<-as.character(sumstats_dt_hg382$CHR)
allbim<-merge(bimfile,sumstats_dt_hg382,by.x=c('V1','V4'),by.y=c('CHR','BP'),all.x=T)
allbim$V2[!is.na(allbim$SNP)]<-allbim$SNP[!is.na(allbim$SNP)]
tbsnp<-duplicated(allbim$V2)
allbim$V2[tbsnp]<-paste(allbim$V1[tbsnp],allbim$V4[tbsnp],allbim$V6[tbsnp],allbim$V5[tbsnp],sep=':')
write.table(allbim[order(allbim$order),c('V1','V2','V3','V4','V5','V6')], file='/spaces/jeantristan/Data/1000Geno/hg38/20220422_3202_phased_SNV_INDEL_SV/plink2/all_1000g_maf0.001.bim', row.names=F, col.names=F, sep='\t',quote=F)

if(!file.exists('GCST90103633_buildGRCh38.clumped'))system('~/bin/plink -bfile /spaces/jeantristan/Data/1000Geno/hg38/20220422_3202_phased_SNV_INDEL_SV/plink2/all_1000g_maf0.001 --clump GCST90103633_buildGRCh38.assoc --clump-p1 0.00000005  --clump-p2 0.01 --clump-r2  0.01 --clump-kb 5000 -out GCST90103633_buildGRCh38 --allow-extra-chr')

checka1a2<-!is.na(allbim$A1) & (allbim$A1==allbim$V5 | allbim$A1==allbim$V6) &  (allbim$A2==allbim$V5 | allbim$A2==allbim$V6)
allbimgooda1a2<-allbim[checka1a2,]

#write.table(allbimgooda1a2[,c('V1','V4','V4')],file='allgoodpositions.bed',row.names=F,col.names=F, quote=F)
#system('~/bin/plink2 -bfile /spaces/jeantristan/Data/1000Geno/hg38/20220422_3202_phased_SNV_INDEL_SV/plink2/all_1000g_maf0.001 --freq cols=chrom,pos,ref,alt,maybeprovref,altfreq,nobs --extract bed1 allgoodpositions.bed')

clump_assoc<-read.table('GCST90103633_buildGRCh38.clumped',header=T)


######sapply(1:3, clump_assoc)
around<-500000
nbsignifican_locus=5
listsnp=c()
for(cmt in 1:5){
chr<-clump_assoc[cmt,'CHR']
bp<-clump_assoc[cmt,'BP']
listsnp<-c(listsnp,allbimgooda1a2$SNP[allbimgooda1a2$V1==chr & allbimgooda1a2$V4>=bp-around & allbimgooda1a2$V4<=bp+around])
}
randomsnp<-50000-length(listsnp)
listsnp<-c(listsnp,sample(allbimgooda1a2$V2, randomsnp))
writeLines(listsnp, con='allsnp.snp')

balise_allele<-allbimgooda1a2$A2==allbimgooda1a2$V5
allbimgooda1a2$BETA[balise_allele]<-  - allbimgooda1a2$BETA[balise_allele] 
#we limited results in african and european 
headout<-'afreur'
info_ind<-read.table('../../day2_apol1/Data/info_ind.txt',header=T);info_ind[,1]<-0
info_ind<-info_ind[info_ind$Superpopulation %in% c('AFR','EUR'),]
write.table(info_ind[,c(1,2)],file=paste(headout,'.ind',sep=''),row.names=F,col.names=F, quote=F, sep='\t')

system(paste('~/bin/plink -bfile /spaces/jeantristan/Data/1000Geno/hg38/20220422_3202_phased_SNV_INDEL_SV/plink2/all_1000g_maf0.001   --extract allsnp.snp --make-bed -out ../Data/',headout,'',' --keep ',headout,'.ind',sep=''))
write.table(allbimgooda1a2[allbimgooda1a2$V2 %in% clump_assoc$SNP[1:nbsignifican_locus],c('V2','BETA')], row.names=F, col.names=F, quote=F, file='causal.snplist')

# computed phenotype using gcta we used 0.3 
system(paste('~/bin/gcta64  --bfile ../Data/',headout,'  --simu-qt  --simu-causal-loci causal.snplist  --simu-hsq 0.3 --simu-rep 3  --out ',headout,'egfr.init',sep=''))

egfr_pheno<-read.table(paste(headout,'egfr.init.phen',sep=''))[,1:3];names(egfr_pheno)[1:3]<-c('FID','IID','egfr_i')

allegfr<-merge(egfr_pheno,info_ind,by=c(1,2))

allegfr$age<-as.integer(rnorm(nrow(allegfr),45,4))
allegfr$egfr <- normalize_to_egfr_range(allegfr$egfr_i)
allegfr$egfr<-allegfr$egfr- (allegfr$age - min(allegfr$age))*0.82
#Sex 1: Denotes a male individual, who typically carries one X and one Y chromosome (XY).
#Sex 2: Denotes a female individual, who typically carries two X chromosomes (XX)
#| Ancestry                         | Approximate mean eGFR | Comment                            |
#| -------------------------------- | --------------------- | ---------------------------------- |
#| AFR (African / African ancestry) | 108                   | slightly higher due to muscle mass |
#| AMR (Admixed American / Latino)  | 104                   | intermediate                       |
#| EAS (East Asian)                 | 106                   | slightly higher                    |
#| EUR (European)                   | 102                   | reference baseline                 |
#| SAS (South Asian)                | 101                   | slightly lower                     |

allegfr$egfr<-adjust_egfr_by_ancestry(allegfr$egfr,allegfr$Superpopulation)
allegfr$egfr[allegfr$Sex==2]<-allegfr$egfr[allegfr$Sex==2] * 1.03
summary(glm(egfr~Superpopulation+Sex+age,data=allegfr))
# add some weird value 
# add value of egfr not good
n_weird<-20
weird_ids <- sample(1:nrow(allegfr), 20)
allegfr$egfr_i <- allegfr$egfr
allegfr$weird_ids<-F
allegfr$weird_ids[weird_ids]<-T
allegfr$egfr[weird_ids] <- sample(c(runif(n_weird/2, 0,5), runif(n_weird/2, 180, 250)))

allegfr$Sc<-egfr_to_creatinine(allegfr$egfr, allegfr$age,allegfr$Sex)

## exchange african with european

african_1<-sample(allegfr$IID[allegfr$Superpopulation=='AFR'],2)
european_1<-sample(allegfr$IID[allegfr$Superpopulation=='EUR'],2)
allegfr$IID_original<-allegfr$IID
allegfr$IID[allegfr$IID_original %in% african_1] <- european_1
allegfr$IID[allegfr$IID_original %in% european_1] <- african_1

SexTmp<-allegfr$Sex
allegfr$Sex<-'Men'
allegfr$Sex[SexTmp==2]<-'Women'

write.csv(allegfr[,c('FID','IID','Sex','Superpopulation','age','Sc','egfr')], file=paste('../Data/',headout,'_pheno.csv',sep=''),row.names=F, quote=F)
write.csv(allegfr, file=paste(headout,'_pheno.csv',sep=''),row.names=F, quote=F)
write.table(allegfr[,c('FID','IID','Sex','Superpopulation','age','Sc','egfr')], file=paste('../Data/',headout,'_pheno.tsv',sep=''),row.names=F,quote=F)


