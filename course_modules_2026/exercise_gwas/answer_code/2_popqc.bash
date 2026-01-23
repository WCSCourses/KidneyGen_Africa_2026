# we performed admixture
mkdir -p admixture 
../../bin/plink --bfile ../2_Data_qc_genotype/afreur_qc_rel --indep-pairwise 50 10 0.1 -out admixture/afreur_pihat
../../bin/plink --bfile ../2_Data_qc_genotype/afreur_qc_rel --extract admixture/afreur_pihat.prune.in --make-bed --out admixture//afreur_pihat_indep

for K in 1 2 3 4 5; \
do 
../../bin/admixture --cv admixture/afreur_pihat_indep.bed $K | tee admixture/log${K}.out &
done
wait

plink -bfile admixture//afreur_pihat_indep --pca 10 --out admixture/afreur_pihat_indep 
