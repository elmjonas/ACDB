list="PM7 M06-2x_6-311ppGss M06-2x_6-31ppGss M06-2x_6-31pGs PW91_6-311ppGss PW91_6-31ppGss PW91_6-31pGs wB97xd_6-311ppGss wB97xd_6-31ppGss wB97xd_6-31pGs RI-MP2_aug-cc-pVQZ_welloptimized XTB1 XTB2 B97-3c r2SCAN-3c wB97X-3c AMC-xTB"
#RI-MP2_aug-cc-pVQZ
N=`echo $list | wc -w`
rm .joblist.txt
# list_include_item "10 11 12" "2"
function list_include_item {
  local list="$1"
  local item="$2"
  if [[ $list =~ (^|[[:space:]])"$item"($|[[:space:]]) ]] ; then
    # yes, list include item
    result=0
  else
    result=1
  fi
  return $result
}
for i in `seq 1 $N`
do
  i1=`echo $i+1 | bc`
  if [ $i1 -le $N ]
  then
    for j in `seq $i1 $N`
    do
      A=`echo $list | awk -v var=$i '{print $var}'`
      B=`echo $list | awk -v var=$j '{print $var}'`
      if [ -e ${A}_$B ]; then continue; fi
      mkdir ${A}_$B
      cd ${A}_$B
      if `list_include_item "AMC-xTB XTB1 XTB2" "$A"`
      then
        cp ../../collection${A}.pkl A.pkl
      else
        JKQC ../../collection${A}.pkl -filter_ne termination nan -filter_ne termination 0 -out A.pkl
      fi
      if `list_include_item "AMC-xTB XTB1 XTB2" "$B"`
      then	
	cp ../../collection${B}.pkl B.pkl	
      else
	JKQC ../../collection${B}.pkl -filter_ne termination nan -filter_ne termination 0 -out B.pkl
      fi
      echo "cd ${A}_$B; export PYTHONPATH=$PYTHONPATH:/home/kubeckaj/Applications/JKCS2.1/JKQC/src/; source ~/.JKCSusersetup.txt; program_PYTHON ../sc.py > output" >> ../.joblist.txt
      cd ..
    done
  fi
done
JKsbatchfilelines .joblist.txt "1 --time 1:00:00"
