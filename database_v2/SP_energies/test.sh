find ../Articles/ -type f -name database.pkl > all_databases.txt
find ../Articles/ -type f -name database_s*.pkl >> all_databases.txt
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
rm all_databases.txt 2>/dev/null
