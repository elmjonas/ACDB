l=$1
N=`cat all_filtered_databases.txt | wc -l`
if [ $l -gt $N ]; then exit;fi
line=`head -n $l all_filtered_databases.txt | tail -n 1`
echo $line
JKQC $line -levels
