for i in `ls -d */` 
do echo "{\\\"$i\\\",`tail -n 2 ${i}/output | xargs | sed 's/ /,/g'`}"; done | xargs | sed "s/ /,/g"
