M=10000000

rm -r `ls -d */ 2>/dev/null` 2>/dev/null

function newf {
  test=0  
  while [ $test -eq 0 ]
  do
    newfile=$f/f_${RANDOM}.pkl
    if [ ! -e $newfile ]
    then 
      test=1
    fi
  done
  echo $newfile 
}

function split_database {
  #SPLIT DATABASE IF NEEDED
  length=`JKQC $f/database.pkl -b | wc -l`
  splits=`echo "($length-$length%10000)/10000+1" | bc`
  if [ $splits -gt 1 ]
  then
    JKQC $f/database.pkl -noex -split $splits -out $f/database.pkl
    rm $f/database.pkl
  fi
}

f="G16-wB97X-D_6-31++Gxx"
mkdir $f
for pkl in ../Articles/myllys19_sa_multibase_chrg/DLPNO_vtw16/database.pkl ../Articles/acdb_private/kubecka_1/database.pkl ../Articles/acdb_private/myllys_1/database.pkl ../Articles/acdb_old/DLPNO_vtw16/database.pkl ../Articles/acdb_monomers/G16-wB97X-D_6-31++Gxx/database.pkl ../Articles/knattrup23b_multiacid_multibase/MSA_SA_FA_NA_base/DFT/database.pkl ../Articles/knattrup23b_multiacid_multibase/SA_FA_NA_base/DFT/database.pkl ../Articles/knattrup23b_multiacid_multibase/Recalculated_Rasmussen_Clusteromics/DFT/database.pkl ../Articles/xie21_sa_multibase/G16/database.pkl ../Articles/kubecka23_sa_multibase/Xie-SI/database.pkl ../Articles/kubecka23_sa_multibase/DLPNO_DFT/database.pkl ../Articles/fomete23_sa_dma_malonic/database.pkl ../Articles/temelso18_sa_multibase/database.pkl ../Articles/li20_sa_am_dma/database.pkl ../Articles/myllys19_sa_am_dma/database.pkl ../Articles/besel19_sa_am_chrg/database.pkl ../Articles/kubecka19_sa_gd/database.pkl ../Articles/zanca20_sa_b_homJ/database.pkl ../Articles/ortega12_sa_am_dma/database.pkl ../Articles/leverentz13_sa_am_dma/database.pkl ../Articles/wang18_sa_am_ma/database.pkl ../Articles/paasonen12_sa_dma_tma/database.pkl ../Articles/kubecka23_sa_multibase/DFT/database_s1.pkl ../Articles/kubecka23_sa_multibase/DFT/database_s2.pkl ../Articles/kubecka23_sa_multibase/DFT/database_s3.pkl ../Articles/engsvang23_sa_pa_ca_multibase/DFT/database.pkl ../Articles/kupiainen12_sa_am_dma/database.pkl ../Articles/chen23_aminions/QC_data/database.pkl
do
  JKQC -drop out -cut el $M -noex -out `newf` $pkl
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl

f="G09-wB97X-D_6-31++Gxx"
mkdir $f
for pkl in ../Articles/myllys19_sa_multibase_chrg/DLPNO_vtw09/database.pkl ../Articles/acdb_private/kubecka_2/database.pkl ../Articles/acdb_private/elm_1/database.pkl ../Articles/acdb_old/DLPNO_vnw09/database.pkl ../Articles/shen19_msa/database.pkl ../Articles/acdb_monomers/G09-wB97X-D_6-31++Gxx/database.pkl ../Articles/xie21_sa_multibase/G09/database.pkl ../Articles/clusteromics_V_sa_msa_nta_fa_multibase/database_s3.pkl ../Articles/clusteromics_V_sa_msa_nta_fa_multibase/database_s2.pkl ../Articles/clusteromics_V_sa_msa_nta_fa_multibase/database_s1.pkl ../Articles/clusteromics_IV_sa_msa_nta_multibase/database_s1.pkl ../Articles/clusteromics_IV_sa_msa_nta_multibase/database_s2.pkl ../Articles/clusteromics_IV_sa_msa_nta_multibase/database_s3.pkl ../Articles/clusteromics_III_sa_msa_multibase/database.pkl ../Articles/clusteromics_I_sa_multibase/DLPNO/database.pkl ../Articles/clusteromics_I_sa_multibase/DFT/database.pkl ../Articles/kubecka23_sa_multibase/Xie-SI-G09/database.pkl ../Articles/rosati21_sa_msa/database.pkl ../Articles/rasmussen20_sa_w/database.pkl ../Articles/rasmussen22_sa_msa_dma/NormalPNO/database.pkl ../Articles/rasmussen22_sa_msa_dma/TightPNO/database.pkl ../Articles/clusteromics_II_msa_multibase/database.pkl ../Articles/elm19_sa_pz/database.pkl ../Articles/chen20_msa/database.pkl
do
  JKQC -drop out -cut el $M -noex -out `newf` $pkl
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl

f="DLPNO-CCSD-T_aug-cc-pVTZ_TightPNO"
mkdir $f
for pkl in ../Articles/myllys19_sa_multibase_chrg/DLPNO_vtw16/database.pkl ../Articles/myllys19_sa_multibase_chrg/DLPNO_vtw09/database.pkl ../Articles/acdb_private/kubecka_1/database.pkl ../Articles/acdb_private/kubecka_1/database.pkl ../Articles/acdb_private/myllys_1/database.pkl ../Articles/acdb_private/kubecka_2/database.pkl ../Articles/acdb_monomers/DLPNO-CCSD-T_aug-cc-pVTZ_TightPNO__G16-wB97X-D_6-31++Gxx/database.pkl ../Articles/acdb_monomers/DLPNO-CCSD-T_aug-cc-pVTZ_TightPNO__G09-wB97X-D_6-31++Gxx/database.pkl ../Articles/kubecka23_sa_multibase/Xie-SI-G09/database.pkl ../Articles/besel19_sa_am_chrg/database.pkl ../Articles/kubecka19_sa_gd/database.pkl ../Articles/elm19_sa_pz/database.pkl ../Articles/rasmussen22_sa_msa_dma/TightPNO/database.pkl
do
  JKQC -drop log -out2log -cut el $M -noex -out `newf` $pkl
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
rm $f/f_*.pkl

f="DLPNO-CCSD-T_aug-cc-pVTZ_NormalPNO"
mkdir $f
for pkl in ../Articles/clusteromics_III_sa_msa_multibase/database.pkl ../Articles/acdb_private/elm_1/database.pkl ../Articles/acdb_old/DLPNO_vnw09/database.pkl ../Articles/shen19_msa/database.pkl ../Articles/acdb_monomers/DLPNO-CCSD-T_aug-cc-pVTZ_NormalPNO__G09-wB97X-D_6-31++Gxx/database.pkl ../Articles/acdb_monomers/DLPNO-CCSD-T_aug-cc-pVTZ_NormalPNO__G16-wB97X-D_6-31++Gxx/database.pkl ../Articles/clusteromics_V_sa_msa_nta_fa_multibase/database_s3.pkl ../Articles/clusteromics_V_sa_msa_nta_fa_multibase/database_s2.pkl ../Articles/clusteromics_V_sa_msa_nta_fa_multibase/database_s1.pkl ../Articles/clusteromics_IV_sa_msa_nta_multibase/database_s1.pkl ../Articles/clusteromics_IV_sa_msa_nta_multibase/database_s2.pkl ../Articles/clusteromics_IV_sa_msa_nta_multibase/database_s3.pkl ../Articles/clusteromics_I_sa_multibase/DLPNO/database.pkl ../Articles/kubecka23_sa_multibase/Xie-SI/database.pkl ../Articles/kubecka23_sa_multibase/DLPNO_DFT/database.pkl ../Articles/fomete23_sa_dma_malonic/database.pkl ../Articles/rosati21_sa_msa/database.pkl ../Articles/rasmussen20_sa_w/database.pkl ../Articles/rasmussen22_sa_msa_dma/NormalPNO/database.pkl ../Articles/chen20_msa/database.pkl ../Articles/clusteromics_II_msa_multibase/database.pkl ../Articles/chen23_aminions/QC_data/database.pkl
do
  JKQC -drop log -out2log -cut el $M -noex -out `newf` $pkl
done
for pkl in ../Articles/engsvang23_sa_pa_ca_multibase/DLPNO/database.pkl  ../Articles/knattrup23b_multiacid_multibase/MSA_SA_FA_NA_base/DLPNO/database.pkl ../Articles/knattrup23b_multiacid_multibase/SA_FA_NA_base/DLPNO/database.pkl ../Articles/knattrup23b_multiacid_multibase/Recalculated_Rasmussen_Clusteromics/DLPNO/database.pkl
do
  JKQC -cut el $M -noex -out `newf` $pkl
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl

f="B97-3c"
mkdir $f
for pkl in ../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/extended/B97-3c/database.pkl ../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/equilibrium/B97-3c/database_s1.pkl ../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/equilibrium/B97-3c/database_s2.pkl ../Articles/acdb_monomers/B97-3c/database.pkl ../Articles/wu23_sa_am_dma/sa_dma/database.pkl ../Articles/wu23_sa_am_dma/sa_am/database.pkl
do
  JKQC -cut el $M -noex -out `newf` $pkl
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl

f="GFN1-xTB"
mkdir $f
for pkl in ../Articles/knattrup23_multiacid_multibase/Additional_files/extra_monomers_and_dimers/GFN1-xTB/database.pkl ../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/extended/GFN1-xTB/database.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_III/GFN1-xTB/database_s2.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_III/GFN1-xTB/database_s1.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_I/GFN1-xTB/database_s1.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_I/GFN1-xTB/database_s2.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_IV/GFN1-xTB/database_s1.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_IV/GFN1-xTB/database_s2.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_V/GFN1-xTB/database_s1.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_V/GFN1-xTB/database_s2.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_II/GFN1-xTB/database_s2.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_II/GFN1-xTB/database_s1.pkl ../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/equilibrium/GFN1-xTB/database_s1.pkl ../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/equilibrium/GFN1-xTB/database_s2.pkl ../Articles/engsvang23_sa_am/r2SCAN-3c_GFN1-xTB/GFN1-xTB/database_s2.pkl ../Articles/engsvang23_sa_am/r2SCAN-3c_GFN1-xTB/GFN1-xTB/database_s1.pkl ../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/GFN1-xTB/database_s2.pkl ../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/GFN1-xTB/database_s1.pkl
do
  JKQC -cut el $M -noex -out `newf` $pkl
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl

f="r2SCAN-3c"
mkdir $f
for pkl in ../Articles/knattrup23_multiacid_multibase/clusteromics_III/r2SCAN-3c/database_s2.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_III/r2SCAN-3c/database_s1.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_I/r2SCAN-3c/database_s2.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_I/r2SCAN-3c/database_s1.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_IV/r2SCAN-3c/database_s2.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_IV/r2SCAN-3c/database_s1.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_V/r2SCAN-3c/database_s1.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_V/r2SCAN-3c/database_s2.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_II/r2SCAN-3c/database_s2.pkl ../Articles/knattrup23_multiacid_multibase/clusteromics_II/r2SCAN-3c/database_s1.pkl ../Articles/engsvang23_sa_am/r2SCAN-3c_GFN1-xTB/r2SCAN-3c/database_s2.pkl ../Articles/engsvang23_sa_am/r2SCAN-3c_GFN1-xTB/r2SCAN-3c/database_s1.pkl ../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/r2SCAN-3c/database.pkl ../Articles/knattrup23_multiacid_multibase/Additional_files/extra_monomers_and_dimers/r2SCAN-3c/database.pkl
do
  JKQC -cut el $M -noex -out `newf` $pkl
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl

f="ORCA-wB97X-D_6-311++Gxx"
mkdir $f
for pkl in ../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/wB97X-D/database_s1.pkl ../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/wB97X-D/database_s2.pkl
do
  JKQC -cut el $M -noex -out `newf` $pkl
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl

for i in `ls -d */`; do cd $i; sbatch JKsend "JKQC -levels -noex data*.pkl > levels.txt; rm mydatabase.pkl output"; cd ..; done
#for i in `ls -d */`; do echo ""; echo $i; cat $i/levels.txt; done
