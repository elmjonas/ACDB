rm all_filtered_databases.txt
find ../Articles/ -type f -name database.pkl > all_databases.txt
find ../Articles/ -type f -name database_s*.pkl >> all_databases.txt

n=`cat all_databases.txt | wc -l`
for i in `seq 1 $n`
do
  l=`head -n $i all_databases.txt | tail -n 1`
  JKQC $l -info > o
  test=`grep -c "(log, gibbs_free_energy)" o`
  if [ $test -eq 1 ]
  then
    test=`grep "(log, gibbs_free_energy)" o | awk '{print $4}'`
    if [ $test -gt 0 ]
    then
      echo $l >> all_filtered_databases.txt
    fi
  fi
done
rm o
