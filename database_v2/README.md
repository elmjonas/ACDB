-------
ACDB2.0
-------

Files
-----

database.pkl = contains 3 lowest (DFT) Gibbs free energy structures, i.e. if you seek for el. energy corrected energies at DLPNO level of theory, you must recollect the data.

ACDC_NPF_rates.csv = ACDC simulation outputs

properties.txt = contains standard binding properties of global minima

                 structure_name | dG(298.15K) | dH(298.15K) | dS(298.15K) 

Subfolders
----------

- DLPNO_vnw16 
  - optimized geometry + vibration freq.: wB97X-D/6-31++G(d,p) (Gaussian 16)
  - SP el. correction:  DLPNO-CCSD(T)/aug-cc-pVTZ with NormalPNO (ORCA 5)
      - (aug-cc-pVTZ aug-cc-pVTZ/C DLPNO-CCSD(T) TightSCF RI-JK aug-cc-pVTZ/JK) 
- DLPNO_vtw16 
  - optimized geometry + vibration freq.: wB97X-D/6-31++G(d,p) (Gaussian 16)
  - SP el. correction:  DLPNO-CCSD(T)/aug-cc-pVTZ with TightPNO (ORCA 4)
      - (aug-cc-pVTZ aug-cc-pVTZ/C DLPNO-CCSD(T) GRID4 nofinalgrid TightPNO TightSCF)

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
   
   
** NAMES **
-----------

Water:
 - w=water

Positive charges: 
 - 1p=proton (+)
 - 1am1p=ammonium cat (+)
 - 1dma1p=dimethylammonium cat. (+)  
 - 1gly1p=glycinium cat. (+)

Bases:
 - am=ammonia
 - dma=dimethylamine
 - tma=trimethylamine
 - gd=guanidine
 - ma=methylamine
 - put=putrescine
 - mea=monoethylamine
 - pz=piperazine
 - eda=ethylendiamine
 - mda=methylethylendiamine
 - bda=butane-1,4-diamine
 - pda=propan-1,3-diamine
 - diAAmda=N,N-dimethylethylendiamine
 - diABmda=N,N’-dimethylethylendiamine
 - triAABmda=trimethylethylendiamine
 - teAABBmda= tetramethylethylendiamine
    
Anorganic acids:
 - sa=sulfuric acid
 - b=bisulphate (-)
 - pha=phosforic acid
 - msa=methanesulfonic acid
 - hcl=hydrogenchloride
 - cl=chloride (-)
 - cla=chloric acid
 - pcla=perchloric acid
 - nta=nitric acid

Organics:
 - gly=glycine
 - glyt=glycinate an. (-)
 - homF=C6H8O7
 - homJ=C10H16O8
 - fd=folrmaldehyde
 - ml=methanol
 - pxml=methanolperoxide

Organic acids:
 - aca=acetic acid
 - acc=acetic an. (-)
 - bza=benzoic acid
 - bzc=benzoic an. (-)
 - ca=caric acid
 - cc=caric an. (-)
 - fa=formic acid
 - fc=formic an. (-)
 - hgta=3-hydroxy-glutaric acid
 - maa=maleic acid
 - mbtca=3-methyl-1,2,3-butanetricarboxylic acid
 - mbtcc=3-methyl-1,2,3-butanetricarboxylic an. (-)  
 - mca=malic acid
 - moa=malonic acid
 - oa=oxalic acid
 - oc=oxalic an. (-)
 - pa=pinic acid
 - paca=phenylacetic acid
 - pc=pinic an. (-)
 - pta=phtalic acid
 - pua=pyruvic acid
 - pxfa=peroxyformic acid
 - pxaca=peroxyacetic acid
 - sua=succinic acid
 - suc=succinic an. (-) 
 - tba=terebic acid
 - tbc=terebic an. (-)
 - tpa=terpenylic acid
 - tpc=terpenylic an. (-)
 - tta=tartaric acid
 - ttc=tartaric an. (-)
