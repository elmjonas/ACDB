thisdir=$PWD
dirs=`find . -type d`
for i in $dirs
do
  cd $thisdir
  cd $i
  if [ ! -e QC_output.tar.gz ] && [ -e database.pkl ]
  then
    pwd
    echo `JKQC database.pkl -b | awk '{printf("%s.* ",$1)}'` > .compress
    files=`cat .compress`
    rm .compress
    tar -czf QC_output.tar.gz $files
    rm $files
    #echo `cat o | awk '{printf("%s.\* ",$1)}'`
  fi
done
