
wrk=$PWD
if [ "$1" -eq 1 ]
then
  if [ ! -e Additional_files ]; then mkdir Additional_files; fi
  if [ ! -e Additional_files/Reacted ]; then mkdir Additional_files/Reacted; fi
  
  qc=`find . -type f -name QC_output.tar.gz | xargs`
  for i in $qc
  do
    cd $wrk
    path=$( cd "$(dirname "$i")" ; pwd -P )
    cd $path
    if [ -e pre-database.pkl ] || [ -e database.pkl ] || [ -e database_s1.pkl ]
    then
      sbatch JKsend "JKQC `ls *atabase.pkl database_s*.pkl 2>/dev/null` -pXYZ -reacted2 -noex >> $wrk/Additional_files/rm; rm output mydatabase.pkl 2>/dev/null"
    fi
  done
  #I CANNOT DO THIS: sbatch JKsend sh /home/kubeckaj/ACDB/database_v2/remove_reacted.sh 2 
fi

if [ "$1" -eq 2 ]
then
  if [ ! -e Additional_files ]; then exit; fi
  if [ -e Additional_files/rm ]; 
  then
    test=`wc -l Additional_files/rm | awk '{print $1}'`
    if [ $test -gt 0 ]
    then
      if [ ! -e Additional_files/Reacted ]; then mkdir Additional_files/Reacted; fi
      rm *.pkl *xyzs 2>/dev/null
      folders=`cat Additional_files/rm | rev | sed "s/\// /" | rev | awk '{print $1}' | sort -u | xargs`
      for i in $folders
      do
        cd $wrk
        if [ ! -e "$i" ]; then echo "WTF $i" >> Additional_files/error ; continue; fi
        cd $i
        echo $i
        JKtar QC_output.tar.gz
        files=`grep "^${i}/" $wrk/Additional_files/rm | xargs`
        for j in $files
        do
          base=`echo $j | rev | cut -c5- | rev`
          mv `ls ${base}.*` $wrk/Additional_files/Reacted/
        done
        rm QC_output.tar.gz pre-database.pkl
        tar -czf QC_output.tar.gz *.xyz *.log *.out 2>/dev/null
        JKQC -collect xyz -folder ./ -out pre-database.pkl -noex
        rm *.xyz *.log *.out output 2>/dev/null
        cd $wrk
      done
      JKQC `find . -type f -name pre-database.pkl` -out database.pkl -noex
      sh ~/ACDB/database_v2/collect3.sh skip
      if [ -e pre-database.pkl ]; then rm pre-database.pkl; fi
    fi
    rm Additional_files/rm
  fi
  if [ ! -e Additional_files/Reacted/ ]
  then
    test=`ls Additional_files/ | wc -w`
    if [ $test -eq 0 ]
    then
      rm -r Additional_files
    fi
  else
    test=`ls Additional_files/Reacted/ | wc -w`
    if [ $test -eq 0 ]
    then
      test=`ls Additional_files/ | wc -w`
      if [ $test -eq 0 ]
      then
        rm -r Additional_files
      else
        rm -r Additional_files/Reacted
      fi
    else
      cd Additional_files/Reacted/
      tar -czf QC_crap.tar.gz *.xyz *.log *.out 2>/dev/null
      rm *.xyz *.log *.out 2>/dev/null
      cd ../../
    fi
  fi
  test=`ls Additional_files/ | wc -w`
  if [ $test -eq 0 ]
  then
    rm -r Additional_files
  fi
  rm output
fi
