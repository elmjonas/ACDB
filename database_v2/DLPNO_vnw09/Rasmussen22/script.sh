#f=/home/rydahl/Kemisk_Projekt/1sa1msa/;for j in `ls -d $f/*/`; for i in $f/1*/DLPNO/*.log; do n=$(basename $i .log); cp $f/1*/$n.log .; cp $f/1*/DLPNO/$n.log $n.out;done;JKlog2xyz

f=/home/rydahl/Kemisk_Projekt/
for j in 1sa1msa  1sa2msa  1sa3msa  2sa1msa  2sa2msa  3sa1msa
do
cd $f/$j
f1=`ls -d */`
#echo $f1
cd -
for i in $f1
do
  if [ "$i" == "1sa1msa4dma/" ] || [ "$i" == "1sa2msa4dma/" ] || [ "$i" == "2sa1msa4dma/" ]
  then
    continue
  fi
  mkdir $i
  cd $i
  pwd 
  for k in `ls $f/$j/$i/CC/*.log` 
  do
    n=$(basename $k .log)
    cp $k $n.out
    cp $f/$j/$i/combined/$n.log $n.log
  done
  JKlog2xyz
  JKname -mol C2H7N1 dma -mol C1H4O3S1 msa -mol H2S1O4 sa
  if [ -e $f/$j/$i/CC/new_CC ]
  then
    for k in `ls $f/$j/$i/CC/new_CC/*.log`
    do
      n=$(basename $k .log)
      cp $k $n.out
      cp $f/$j/$i/combined/$n.log $n.log
    done
    JKlog2xyz
    JKname -mol C2H7N1 dma -mol C1H4O3S1 msa -mol H2S1O4 sa
  fi
  cd ..
done
done
