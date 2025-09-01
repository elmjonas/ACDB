for file in RI-MP2_aug-cc-pVQZ #wB97X-3c #r2SCAN-3c  #wB97xd_6-31ppGss #wB97X-3c #B97-3c r2SCAN-3c  RI-MP2_aug-cc-pVQZ  wB97xd_6-31ppGss 
do
  JKQC ${file}.pkl -freq -filter_ne lf nan -noex > o1
  JKQC ${file}.pkl -freq -filter_ne lf nan -noex -v anh > o2
  paste o1 o2 > o3
  cat o3 | sed "s/\[/{/g" | sed "s/\]/\}/g" | sed "s/ //g" > ${file}.dat
  rm o1 o2 o3
done
