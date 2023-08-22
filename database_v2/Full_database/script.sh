#sbatch --mem=40gb JKsend sh script.sh
rm output all_databases.txt
rm full_database*.pkl 2>/dev/null

find ../Articles/ -type f -name database.pkl > all_databases.txt
find ../Articles/ -type f -name database_s*.pkl >> all_databases.txt
JKQC `cat all_databases.txt | xargs` -out full_database.pkl

#SPLIT DATABASE IF NEEDED + MAKE STRUCTURES.xyz
length=`JKQC full_database.pkl -b | wc -l`
splits=`echo "($length-$length%10000)/10000+1" | bc`
JKQC full_database.pkl -split $splits -out full_database.pkl

