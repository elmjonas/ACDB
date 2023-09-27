#find ../Articles/ -type f -name database.pkl > all_databases.txt
#find ../Articles/ -type f -name database_s*.pkl >> all_databases.txt

#REMOVE WHAT I DO NOT NEED
#exc=`echo "
#" | xargs`
#for i in $exc
#do
#  sed -i "\|$i|d" all_databases.txt
#done

echo DATABASES
n=`wc -l all_filtered_databases.txt | awk '{print $1}'`
for i in `seq 1 $n`
do
  l=`head -n $i all_filtered_databases.txt | tail -n 1`
  test=`grep -c "$l" script2.sh`
  if [ $test -eq 0 ]
  then 
    echo $l
  fi
done

echo SCRIPT
n=`cat script2.sh | xargs -n 1 | grep "../Articles" | sort -u |  xargs`
for i in $n
do
  test=`grep -c "$i" all_filtered_databases.txt`
  if [ $test -eq 0 ]
  then
    echo $i
  fi
done
#rm all_databases.txt 2>/dev/null
