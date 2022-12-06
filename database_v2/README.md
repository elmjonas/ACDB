files:

database.pkl = contains 3 lowest Gibbs free energy structures

ACDC_NPF_rates.csv = ACDC simulation outputs

properties.txt = contains standard binding properties of global minima

                 structure_name | dG(298.15K) | dH(298.15K) | dS(298.15K) 

methods:

DLPNO_vnw16 
-----------
optimized geometry: wB97X-D/6-31++G(d,p) (Gaussian 16)
                    (wB97X-D 6-31++G(d,p) opt freq)
SP el. correction:  DLPNO-CCSD(T)/aug-cc-pVTZ (ORCA 5)
                    (aug-cc-pVTZ aug-cc-pVTZ/C DLPNO-CCSD(T) TightSCF RI-JK aug-cc-pVTZ/JK) 
anharmonicity correction: 0.996
low-vibrational freq. cutoff in QHA: 100 1/cm

## USAGE OF PICKLED FILES

In order to use any database, you can:
* use JKQC (see https://jkcspy.readthedocs.io/en/latest/JKQC.html), or
* use JKQCpickle.py (see below), or
* use your own python script (see below)

** USING JKQCpickle.py **
-------------------------

First, setup your python environment:
1) Modify the python version (>3.8.0 and <4.0.0) you use in the following file:
  > vim install.sh
2) setup the environment:
  > sh install.sh
3) It will add one line to your ~/.bashrc file, therefore source it
  > source ~/.bashrc
4) and activate the environment:
  > JKpython
5) now you should be able to use the JKQCpickle.py file
  > python JKQCpickle.py -help

for purpose of the paper where we used these databases, you need only the function that prints out the cluster names and their energies:
  > python JKQCpickle.py DATABASE.PKL -b -el

or generate all xyz files:
  > python JKQCpickle.py DATABASE.PKL -xyz

(see other functionalities: https://jkcspy.readthedocs.io/en/latest/JKQC.html)

** USING YOUR OWN PYTHON SCRIPT **
-----------------------------

First, setup your python environment (step 1-4 above).

After activating the correct python environment (e.g., with JKpython), use python to analyse/use the data:
   > $USER/: python
   
   > import pandas as pd
   
   > clusters_dataframe = pd.read_pickle("DATABASE.PKL")
