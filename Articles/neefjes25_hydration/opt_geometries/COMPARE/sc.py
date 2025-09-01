import pandas as pd
import ArbAlign
import numpy as np
a = pd.read_pickle("A.pkl").sort_values([('info','file_basename')]).reset_index()
b = pd.read_pickle("B.pkl").sort_values([('info','file_basename')]).reset_index()
output = []
for i in range(len(a)):
  print(i)
  try:
    c=b[b['info','file_basename']==a['info','file_basename'][i]]
    d=a[a.index == i]
    if np.isnan(float(d[("log","electronic_energy")])) or np.isnan(float(c[("log","electronic_energy")])):
      continue
    if ("log","termination") in c.columns:
      cc = c.loc[:,("log","termination")].values 
      if cc[0] == 0:
        print("Here")
        continue
    if ("log","termination") in d.columns:
      dd = d.loc[:,("log","termination")].values
      if dd[0] == 0:
        continue
    if len(c) == 1:
      #c=c.iloc[0]
      #print("OK")
      #print(d[("xyz","structure")])
      #print(c[("xyz","structure")])
      output.append(ArbAlign.compare(d[("xyz","structure")].values[0],c[("xyz","structure")].values[0]))
  except Exception as e:
    print("WEIRD EXCEPTION",e)

print(len(output))
print(output)
output = np.array(output)
print(np.mean(output))
print(np.median(output))
print(np.std(output))

