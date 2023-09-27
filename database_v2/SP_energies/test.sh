find ../Articles/ -type f -name database.pkl > all_databases.txt
find ../Articles/ -type f -name database_s*.pkl >> all_databases.txt

exc=`echo "
../Articles/engsvang23_sa_pa_ca_multibase/DLPNO-DFT/database.pkl
../Articles/knattrup23_multiacid_multibase/Additional_files/extra_monomers_and_dimers/r2SCAN-3c_GFN1-xTB/database.pkl
../Articles/knattrup23b_multiacid_multibase/MSA_SA_FA_NA_base/DLPNO_DFT/database.pkl
../Articles/knattrup23b_multiacid_multibase/SA_FA_NA_base/DLPNO_DFT/database.pkl
../Articles/knattrup23b_multiacid_multibase/Recalculated_Rasmussen_Clusteromics/DLPNO_DFT/database.pkl
../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/extended/B97-3c_GFN1-xTB/database.pkl
../Articles/knattrup23_multiacid_multibase/clusteromics_III/r2SCAN-3c_GFN1-xTB/database_s1.pkl
../Articles/knattrup23_multiacid_multibase/clusteromics_III/r2SCAN-3c_GFN1-xTB/database_s2.pkl
../Articles/knattrup23_multiacid_multibase/clusteromics_I/r2SCAN-3c_GFN1-xTB/database_s1.pkl
../Articles/knattrup23_multiacid_multibase/clusteromics_I/r2SCAN-3c_GFN1-xTB/database_s2.pkl
../Articles/knattrup23_multiacid_multibase/clusteromics_IV/r2SCAN-3c_GFN1-xTB/database_s1.pkl
../Articles/knattrup23_multiacid_multibase/clusteromics_IV/r2SCAN-3c_GFN1-xTB/database_s2.pkl
../Articles/knattrup23_multiacid_multibase/clusteromics_V/r2SCAN-3c_GFN1-xTB/database_s1.pkl
../Articles/knattrup23_multiacid_multibase/clusteromics_V/r2SCAN-3c_GFN1-xTB/database_s2.pkl
../Articles/knattrup23_multiacid_multibase/clusteromics_II/r2SCAN-3c_GFN1-xTB/database_s1.pkl
../Articles/knattrup23_multiacid_multibase/clusteromics_II/r2SCAN-3c_GFN1-xTB/database_s2.pkl
../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/equilibrium/B97-3c_GFN1-xTB/database_s2.pkl
../Articles/engsvang23_sa_am/B97-3c_GFN1-xTB/equilibrium/B97-3c_GFN1-xTB/database_s1.pkl
../Articles/engsvang23_sa_am/r2SCAN-3c_GFN1-xTB/r2SCAN-3c_GFN1-xTB/database_s2.pkl
../Articles/engsvang23_sa_am/r2SCAN-3c_GFN1-xTB/r2SCAN-3c_GFN1-xTB/database_s1.pkl
../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/wB97X-D_GFN1-XTB/database_s2.pkl
../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/wB97X-D_GFN1-XTB/database_s1.pkl
../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/r2SCAN-3c_GFN1-XTB/database_s1.pkl
../Articles/engsvang23_sa_am/wB97X-D_GFN1-XTB/r2SCAN-3c_GFN1-XTB/database_s2.pkl
" | xargs`
for i in $exc
do 
  sed -i "\|$i|d" all_databases.txt  
done

echo DATABASES
n=`wc -l all_databases.txt | awk '{print $1}'`
for i in `seq 1 $n`
do
  l=`head -n $i all_databases.txt | tail -n 1`
  test=`grep -c "$l" script.sh`
  if [ $test -eq 0 ]
  then 
    echo $l
  fi
done

echo SCRIPT
n=`cat script.sh | xargs -n 1 | grep "../Articles" | sort -u |  xargs`
for i in $n
do
  test=`grep -c "$i" all_databases.txt`
  if [ $test -eq 0 ]
  then
    echo $i
  fi
done
rm all_databases.txt 2>/dev/null
