M=10000000

if [ -z "$1" ]
then
  rm -r `ls -d */ 2>/dev/null` 2>/dev/null
  for i in `seq 1 10`
  do
    sbatch --job-name=EQ_TMD_$i --mem=40gb --time=1-00:00:00 JKsend sh script2.sh $i
  done
  exit
fi
step=$1

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

if [ $step -eq 1 ];
then
f="DLPNO-CCSD-T_aug-cc-pVTZ_TightPNO__G16-wB97X-D_6-31++Gxx"
mkdir $f
for pkl in ../Articles/myllys19_sa_multibase_chrg/DLPNO_vtw16/database.pkl ../Articles/acdb_private/kubecka_1/database.pkl ../Articles/acdb_private/myllys_1/database.pkl ../Articles/acdb_monomers/DLPNO-CCSD-T_aug-cc-pVTZ_TightPNO__G16-wB97X-D_6-31++Gxx/database.pkl ../Articles/besel19_sa_am_chrg/database.pkl ../Articles/kubecka19_sa_gd/database.pkl
do
  JKQC $pkl -cut elout $M -pass lf 0 -out `newf` -noex
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl
JKQC `ls $f/database.pkl $f/database_s*.pkl 2>/dev/null` -noex -fc 100 -v 0.996 -sort gout -select 1 -out $f/database1LOWEST_G.pkl
cd $f
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -gout -hout -s -fc 100 -v 0.996 | grep -v "nan" | sort -nrk 2 >> properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -movie; mv movie.xyz structures1LOWEST_G.xyzs
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > binding_properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -gout -hout -s -fc 100 -v 0.996 -formation -unit -noex | grep -v "nan" | sort -nrk 2 >> binding_properties1LOWEST_G.txt
rm mydatabase.pkl output
cd ..
fi
################################################################################

if [ $step -eq 2 ];
then
f="DLPNO-CCSD-T_aug-cc-pVTZ_NormalPNO__G16-wB97X-D_6-31++Gxx"
mkdir $f
for pkl in ../Articles/clusteromics_III_sa_msa_multibase/database.pkl ../Articles/kubecka23_sa_multibase/Xie-SI/database.pkl ../Articles/kubecka23_sa_multibase/DLPNO_DFT/database.pkl ../Articles/fomete23_sa_dma_malonic/database.pkl ../Articles/engsvang23_sa_pa_ca_multibase/DLPNO-DFT/database.pkl ../Articles/acdb_monomers/DLPNO-CCSD-T_aug-cc-pVTZ_NormalPNO__G16-wB97X-D_6-31++Gxx/database.pkl ../Articles/knattrup23b_multiacid_multibase/MSA_SA_FA_NA_base/DLPNO_DFT/database.pkl ../Articles/knattrup23b_multiacid_multibase/SA_FA_NA_base/DLPNO_DFT/database.pkl ../Articles/knattrup23b_multiacid_multibase/Recalculated_Rasmussen_Clusteromics/DLPNO_DFT/database.pkl ../Articles/clusteromics_V_sa_msa_nta_fa_multibase/database_s2.pkl ../Articles/clusteromics_V_sa_msa_nta_fa_multibase/database_s3.pkl ../Articles/chen23_aminions/database.pkl
do
  JKQC $pkl -cut elout $M -pass lf 0 -out `newf` -noex
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl
JKQC `ls $f/database.pkl $f/database_s*.pkl 2>/dev/null` -noex -fc 100 -v 0.996 -sort gout -select 1 -out $f/database1LOWEST_G.pkl
cd $f
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -gout -hout -s -fc 100 -v 0.996 | grep -v "nan" | sort -nrk 2 >> properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -movie; mv movie.xyz structures1LOWEST_G.xyzs
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > binding_properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -gout -hout -s -fc 100 -v 0.996 -formation -unit -noex | grep -v "nan" | sort -nrk 2 >> binding_properties1LOWEST_G.txt
rm mydatabase.pkl output
cd ..
fi
################################################################################

if [ $step -eq 3 ];
then
f="G16-wB97X-D_6-31++Gxx__G16-wB97X-D_6-31++Gxx"
mkdir $f
for pkl in ../Articles/myllys19_sa_multibase_chrg/DLPNO_vtw16/database.pkl ../Articles/acdb_private/kubecka_1/database.pkl ../Articles/acdb_private/myllys_1/database.pkl ../Articles/acdb_old/DLPNO_vtw16/database.pkl ../Articles/kubecka23_sa_multibase/Xie-SI/database.pkl ../Articles/kubecka23_sa_multibase/DLPNO_DFT/database.pkl ../Articles/fomete23_sa_dma_malonic/database.pkl ../Articles/temelso18_sa_multibase/database.pkl ../Articles/engsvang23_sa_pa_ca_multibase/DLPNO-DFT/database.pkl ../Articles/li20_sa_am_dma/database.pkl ../Articles/acdb_monomers/G16-wB97X-D_6-31++Gxx/database.pkl ../Articles/myllys19_sa_am_dma/database.pkl ../Articles/besel19_sa_am_chrg/database.pkl ../Articles/kubecka19_sa_gd/database.pkl ../Articles/zanca20_sa_b_homJ/database.pkl ../Articles/knattrup23b_multiacid_multibase/MSA_SA_FA_NA_base/DLPNO_DFT/database.pkl ../Articles/knattrup23b_multiacid_multibase/SA_FA_NA_base/DLPNO_DFT/database.pkl ../Articles/knattrup23b_multiacid_multibase/Recalculated_Rasmussen_Clusteromics/DLPNO_DFT/database.pkl ../Articles/xie21_sa_multibase/G16/database.pkl ../Articles/ortega12_sa_am_dma/database.pkl ../Articles/leverentz13_sa_am_dma/database.pkl ../Articles/wang18_sa_am_ma/database.pkl ../Articles/paasonen12_sa_dma_tma/database.pkl ../Articles/kupiainen12_sa_am_dma/database.pkl ../Articles/kubecka23_sa_multibase/DFT/database_s1.pkl ../Articles/kubecka23_sa_multibase/DFT/database_s2.pkl ../Articles/kubecka23_sa_multibase/DFT/database_s3.pkl ../Articles/clusteromics_V_sa_msa_nta_fa_multibase/database_s1.pkl ../Articles/clusteromics_V_sa_msa_nta_fa_multibase/database_s2.pkl ../Articles/clusteromics_V_sa_msa_nta_fa_multibase/database_s3.pkl ../Articles/chen23_aminions/database.pkl
do
  JKQC $pkl -drop out -cut el $M -pass lf 0 -out `newf` -drop out -noex
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl
JKQC `ls $f/database.pkl $f/database_s*.pkl 2>/dev/null` -noex -sort g -select 5 -out $f/database5LOWEST_G.pkl
JKQC $f/database5LOWEST_G.pkl -noex -fc 100 -v 0.996 -sort g -select 1 -out $f/database1LOWEST_G.pkl
rm $f/database5LOWEST_G.pkl
cd $f
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -g -h -s -fc 100 -v 0.996 | grep -v "nan" | sort -nrk 2 >> properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -movie; mv movie.xyz structures1LOWEST_G.xyzs
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > binding_properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -g -h -s -fc 100 -v 0.996 -formation -unit -noex | grep -v "nan" | sort -nrk 2 >> binding_properties1LOWEST_G.txt
rm mydatabase.pkl output
cd ..
fi
################################################################################

if [ $step -eq 4 ];
then
f="DLPNO-CCSD-T_aug-cc-pVTZ_TightPNO__G09-wB97X-D_6-31++Gxx"
mkdir $f
for pkl in ../Articles/myllys19_sa_multibase_chrg/DLPNO_vtw09/database.pkl ../Articles/acdb_private/kubecka_2/database.pkl ../Articles/kubecka23_sa_multibase/Xie-SI-G09/database.pkl ../Articles/acdb_monomers/DLPNO-CCSD-T_aug-cc-pVTZ_TightPNO__G09-wB97X-D_6-31++Gxx/database.pkl ../Articles/elm19_sa_pz/database.pkl ../Articles/rasmussen22_sa_msa_dma/TightPNO/database.pkl
do
  JKQC $pkl -cut elout $M -pass lf 0 -out `newf` -noex
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl
JKQC `ls $f/database.pkl $f/database_s*.pkl 2>/dev/null` -noex -fc 100 -v 0.996 -sort gout -select 1 -out $f/database1LOWEST_G.pkl
cd $f
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -gout -hout -s -fc 100 -v 0.996 | grep -v "nan" | sort -nrk 2 >> properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -movie; mv movie.xyz structures1LOWEST_G.xyzs
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > binding_properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -gout -hout -s -fc 100 -v 0.996 -formation -unit -noex | grep -v "nan" | sort -nrk 2 >> binding_properties1LOWEST_G.txt
rm mydatabase.pkl output
cd ..
fi
################################################################################

if [ $step -eq 5 ];
then
f="DLPNO-CCSD-T_aug-cc-pVTZ_NormalPNO__G09-wB97X-D_6-31++Gxx"
mkdir $f
for pkl in ../Articles/acdb_private/elm_1/database.pkl ../Articles/acdb_old/DLPNO_vnw09/database.pkl ../Articles/shen19_msa/database.pkl ../Articles/clusteromics_I_sa_multibase/DLPNO/database.pkl ../Articles/rosati21_sa_msa/database.pkl ../Articles/acdb_monomers/DLPNO-CCSD-T_aug-cc-pVTZ_NormalPNO__G09-wB97X-D_6-31++Gxx/database.pkl ../Articles/rasmussen20_sa_w/database.pkl ../Articles/rasmussen22_sa_msa_dma/NormalPNO/database.pkl ../Articles/chen20_msa/database.pkl ../Articles/clusteromics_II_msa_multibase/database.pkl ../Articles/clusteromics_IV_sa_msa_nta_multibase/database_s1.pkl ../Articles/clusteromics_IV_sa_msa_nta_multibase/database_s2.pkl ../Articles/clusteromics_IV_sa_msa_nta_multibase/database_s3.pkl
do
  JKQC $pkl -cut elout $M -pass lf 0 -out `newf` -noex
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl
JKQC `ls $f/database.pkl $f/database_s*.pkl 2>/dev/null` -noex -fc 100 -v 0.996 -sort gout -select 1 -out $f/database1LOWEST_G.pkl
cd $f
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -gout -hout -s -fc 100 -v 0.996 | grep -v "nan" | sort -nrk 2 >> properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -movie; mv movie.xyz structures1LOWEST_G.xyzs
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > binding_properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -gout -hout -s -fc 100 -v 0.996 -formation -unit -noex | grep -v "nan" | sort -nrk 2 >> binding_properties1LOWEST_G.txt
rm mydatabase.pkl output
cd ..
fi
################################################################################

if [ $step -eq 6 ];
then
f="G09-wB97X-D_6-31++Gxx__G09-wB97X-D_6-31++Gxx"
mkdir $f
for pkl in ../Articles/myllys19_sa_multibase_chrg/DLPNO_vtw09/database.pkl ../Articles/clusteromics_III_sa_msa_multibase/database.pkl ../Articles/acdb_private/kubecka_2/database.pkl ../Articles/acdb_private/elm_1/database.pkl ../Articles/acdb_old/DLPNO_vnw09/database.pkl ../Articles/shen19_msa/database.pkl ../Articles/clusteromics_I_sa_multibase/DLPNO/database.pkl ../Articles/clusteromics_I_sa_multibase/DFT/database.pkl ../Articles/kubecka23_sa_multibase/Xie-SI-G09/database.pkl ../Articles/rosati21_sa_msa/database.pkl ../Articles/acdb_monomers/G09-wB97X-D_6-31++Gxx/database.pkl ../Articles/xie21_sa_multibase/G09/database.pkl ../Articles/rasmussen20_sa_w/database.pkl ../Articles/elm19_sa_pz/database.pkl ../Articles/rasmussen22_sa_msa_dma/TightPNO/database.pkl ../Articles/rasmussen22_sa_msa_dma/NormalPNO/database.pkl ../Articles/chen20_msa/database.pkl ../Articles/clusteromics_II_msa_multibase/database.pkl ../Articles/clusteromics_IV_sa_msa_nta_multibase/database_s1.pkl ../Articles/clusteromics_IV_sa_msa_nta_multibase/database_s2.pkl ../Articles/clusteromics_IV_sa_msa_nta_multibase/database_s3.pkl
do
  JKQC $pkl -drop out -cut el $M -pass lf 0 -out `newf` -noex
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl
JKQC `ls $f/database.pkl $f/database_s*.pkl 2>/dev/null` -noex -sort g -select 5 -out $f/database5LOWEST_G.pkl
JKQC $f/database5LOWEST_G.pkl -noex -fc 100 -v 0.996 -sort g -select 1 -out $f/database1LOWEST_G.pkl
rm $f/database5LOWEST_G.pkl
cd $f
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -g -h -s -fc 100 -v 0.996 | grep -v "nan" | sort -nrk 2 >> properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -movie; mv movie.xyz structures1LOWEST_G.xyzs
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > binding_properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -g -h -s -fc 100 -v 0.996 -formation -unit -noex | grep -v "nan" | sort -nrk 2 >> binding_properties1LOWEST_G.txt
rm mydatabase.pkl output
cd ..
fi
################################################################################

if [ $step -eq 7 ];
then
f="GFN1-xTB__GFB1-xTB"
mkdir $f
for pkl in ../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/equilibrium/B97-3c_GFN1-xTB/database_s1.pkl ../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/equilibrium/B97-3c_GFN1-xTB/database_s2.pkl ../Articles/engsvang23_sa_am/r2SCAN-3c_GFN1-xTB/r2SCAN-3c_GFN1-xTB/database_s1.pkl ../Articles/engsvang23_sa_am/r2SCAN-3c_GFN1-xTB/r2SCAN-3c_GFN1-xTB/database_s2.pkl ../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/r2SCAN-3c_GFN1-XTB/database_s1.pkl ../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/r2SCAN-3c_GFN1-XTB/database_s2.pkl
do
  JKQC $pkl -drop out -cut el $M -out `newf` -noex -pass lf 0
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl
JKQC `ls $f/database.pkl $f/database_s*.pkl 2>/dev/null` -noex -sort g -select 1 -out $f/database1LOWEST_G.pkl
cd $f
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -g -h -s | grep -v "nan" | sort -nrk 2 >> properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -movie; mv movie.xyz structures1LOWEST_G.xyzs
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > binding_properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -g -h -s -formation -unit -noex | grep -v "nan" | sort -nrk 2 >> binding_properties1LOWEST_G.txt
t=`cat binding_properties1LOWEST_G.txt | wc -l`
if [ $t -le 1 ]; then rm binding_properties1LOWEST_G.txt; fi
rm mydatabase.pkl output
cd ..
fi
################################################################################

if [ $step -eq 8 ];
then
f="B97-3c__GFB1-xTB"
mkdir $f
for pkl in ../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/equilibrium/B97-3c_GFN1-xTB/database_s1.pkl ../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/equilibrium/B97-3c_GFN1-xTB/database_s2.pkl
do
  JKQC $pkl -cut elout $M -out `newf` -noex -pass lf 0
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl
JKQC `ls $f/database.pkl $f/database_s*.pkl 2>/dev/null` -noex -sort gout -select 1 -out $f/database1LOWEST_G.pkl
cd $f
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -gout -hout -s | grep -v "nan" | sort -nrk 2 >> properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -movie; mv movie.xyz structures1LOWEST_G.xyzs
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > binding_properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -gout -hout -s -formation -unit -noex | grep -v "nan" | sort -nrk 2 >> binding_properties1LOWEST_G.txt
t=`cat binding_properties1LOWEST_G.txt | wc -l`
if [ $t -le 1 ]; then rm binding_properties1LOWEST_G.txt; fi
rm mydatabase.pkl output
cd ..
fi
################################################################################

if [ $step -eq 9 ];
then
f="r2SCAN-3c__GFB1-xTB"
mkdir $f
for pkl in ../Articles/engsvang23_sa_am/r2SCAN-3c_GFN1-xTB/r2SCAN-3c_GFN1-xTB/database_s1.pkl ../Articles/engsvang23_sa_am/r2SCAN-3c_GFN1-xTB/r2SCAN-3c_GFN1-xTB/database_s2.pkl ../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/r2SCAN-3c_GFN1-XTB/database_s1.pkl ../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/r2SCAN-3c_GFN1-XTB/database_s2.pkl
do
  JKQC $pkl -cut elout $M -out `newf` -noex -pass lf 0
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl
JKQC `ls $f/database.pkl $f/database_s*.pkl 2>/dev/null` -noex -sort gout -select 1 -out $f/database1LOWEST_G.pkl
cd $f
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -gout -hout -s | grep -v "nan" | sort -nrk 2 >> properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -movie; mv movie.xyz structures1LOWEST_G.xyzs
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > binding_properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -gout -hout -s -formation -unit -noex | grep -v "nan" | sort -nrk 2 >> binding_properties1LOWEST_G.txt
t=`cat binding_properties1LOWEST_G.txt | wc -l`
if [ $t -le 1 ]; then rm binding_properties1LOWEST_G.txt; fi
rm mydatabase.pkl output
cd ..
fi
################################################################################

if [ $step -eq 10 ];
then
f="B97-3c__B97-3c"
mkdir $f
for pkl in ../Articles/acdb_monomers/B97-3c/database.pkl ../Articles/wu23_sa_am_dma/sa_dma/database.pkl ../Articles/wu23_sa_am_dma/sa_am/database.pkl
do
  JKQC $pkl -drop out -cut el $M -out `newf` -noex -pass lf 0
done
JKQC $f/f_*.pkl -noex -out $f/database.pkl
split_database
rm $f/f_*.pkl
JKQC `ls $f/database.pkl $f/database_s*.pkl 2>/dev/null` -noex -sort g -select 1 -out $f/database1LOWEST_G.pkl
cd $f
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -g -h -s | grep -v "nan" | sort -nrk 2 >> properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -movie; mv movie.xyz structures1LOWEST_G.xyzs
echo "#CLUSTER  dG_298.15K_[Eh] dH_298.15K_[Eh] dS_298.15K_[Eh/K]" > binding_properties1LOWEST_G.txt
JKQC database1LOWEST_G.pkl -ct -g -h -s -formation -unit -noex | grep -v "nan" | sort -nrk 2 >> binding_properties1LOWEST_G.txt
t=`cat binding_properties1LOWEST_G.txt | wc -l`
if [ $t -le 1 ]; then rm binding_properties1LOWEST_G.txt; fi
rm mydatabase.pkl output
cd ..
fi

# ../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/equilibrium/GFN1-xTB/database_s1.pkl
# ../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/equilibrium/GFN1-xTB/database_s2.pkl
# ../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/extended/B97-3c_GFN1-xTB/database.pkl
# ../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/extended/GFN1-xTB/database.pkl
# ../Articles/engsvang23_sa_am/r2SCAN-3c_GFN1-xTB/GFN1-xTB/database_s1.pkl
# ../Articles/engsvang23_sa_am/r2SCAN-3c_GFN1-xTB/GFN1-xTB/database_s2.pkl
# ../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/GFN1-xTB/database_s1.pkl
# ../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/GFN1-xTB/database_s2.pkl
# ../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/wB97X-D_GFN1-XTB/database_s1.pkl
# ../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/wB97X-D_GFN1-XTB/database_s2.pkl
# ../Articles/engsvang23_sa_pa_ca_multibase/DFT/database.pkl
# ../Articles/knattrup23b_multiacid_multibase/MSA_SA_FA_NA_base/DFT/database.pkl
# ../Articles/knattrup23b_multiacid_multibase/Recalculated_Rasmussen_Clusteromics/DFT/database.pkl
# ../Articles/knattrup23b_multiacid_multibase/SA_FA_NA_base/DFT/database.pkl
