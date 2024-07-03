length=`cat structures.txt |wc -l`

j=1
for i in `seq 40 40 $length`
do
  j=`echo $j+1 | bc`
  head -n $i structures.txt | tail -n 13 > task$j.txt
done 
