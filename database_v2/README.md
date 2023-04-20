# ACDB2.0

This manual contains descriptions of:
 - Subfolders (i.e. methods that were used to obtain the clusters)
 - Files (i.e. what is saved in each file)
 - Using the pickles files (i.e. how to utilize JKQC or manipulate with the databases)

## Subfolders

- **DLPNO_vnw09**
  - *(67170 structures of 1027 different clusters)*
  - optimized geometry + vibration freq.: wB97X-D/6-31++G(d,p) (**Gaussian 09**)
  - SP el. correction:  DLPNO-CCSD(T)/aug-cc-pVTZ with **NormalPNO** (ORCA 5)
      - (aug-cc-pVTZ aug-cc-pVTZ/C DLPNO-CCSD(T) TightSCF RI-JK aug-cc-pVTZ/JK)
- **DLPNO_vnw16** 
  - *(23158 structures of 340 different clusters)*
  - optimized geometry + vibration freq.: wB97X-D/6-31++G(d,p) (**Gaussian 16**)
  - SP el. correction:  DLPNO-CCSD(T)/aug-cc-pVTZ with **NormalPNO** (ORCA 5)
      - (aug-cc-pVTZ aug-cc-pVTZ/C DLPNO-CCSD(T) TightSCF RI-JK aug-cc-pVTZ/JK) 
- **DLPNO_vtw16** 
  - *(4939 structures of 399 different clusters)*
  - optimized geometry + vibration freq.: wB97X-D/6-31++G(d,p) (**Gaussian 16**)
  - SP el. correction:  DLPNO-CCSD(T)/aug-cc-pVTZ with **TightPNO** (ORCA 4)
      - (aug-cc-pVTZ aug-cc-pVTZ/C DLPNO-CCSD(T) GRID4 nofinalgrid TightPNO TightSCF)
- **DLPNO_vtw09** 
  - *(89 structures of 77 different clusters)*
  - optimized geometry + vibration freq.: wB97X-D/6-31++G(d,p) (**Gaussian 16**)
  - SP el. correction:  DLPNO-CCSD(T)/aug-cc-pVTZ with **TightPNO** (ORCA 4)
      - (aug-cc-pVTZ aug-cc-pVTZ/C DLPNO-CCSD(T) GRID4 nofinalgrid TightPNO TightSCF)   

## Files

- databases:
  - database.pkl
    - all data collected from the given folder  
  - database3DFT.pkl  
    - 3 lowest (DFT) Gibbs free energy structures from database.pkl and all database3DFT.pkl in subfolders
    - QHA: anharmonicity correction: 0.996; low-vibrational freq. cutoff: 100 1/cm
  - database1DLPNO.pkl
    - 1 lowest (DLPNO//DFT) Gibbs free energy structure from database.pkl and all database1DLPNO.pkl in subfolders
    - QHA: anharmonicity correction: 0.996; low-vibrational freq. cutoff: 100 1/cm
- structures:
  - structures3DFT.xyz and structures1DLPNO.xyz
    - structures from database3DFT.pkl and structures1DLPNO.pkl, respectively
- properties:
  - properties3DFT.txt and properties1DLPNO.txt
    - properties from database3DFT.pkl and structures1DLPNO.pkl, respectively
    - these are in the following format:
             structure_name | dG(298.15K) | dH(298.15K) | dS(298.15K)
- binding properties:
  - located only in the most outside folder
  - binding_properties3DFT.txt and binding_properties1DLPNO.txt
    - 1 lowest (DFT or DLPNO//DFT) Gibbs free energies of formation from database3DFT.pkl and database1DLPNO.pkl, respectively
- ACDC results:
  - ACDC_NPF_rates.csv
    - ACDC simulation outputs (relevant only for specific articles)

## USING THE PICKLED FILES

In order to use any database, you can:
* use JKQC (see https://jkcspy.readthedocs.io/en/latest/JKQC.html) or see below
* use your own python script (see below)

### USING JKQC

First, donwload JKCS:
  > cd \<App_dir\>
  
  > git clone https://github.com/kubeckaj/JKCS2.1.git
  
1) Then, setup JKCS and python environment for JKQC with correct python (see the online manual):
  > sh setup.sh -help
  
  > sh setup.sh -python python3.9 -module "module load python3.9" -r 
3) It will add one line to your ~/.bashrc file, therefore source it
  > source ~/.bashrc
4) Now you should be able to use JKQC, e.g.:
  > JKQC -help
  
  > JKQC DATABASE.PKL -b -el
 
  > JKQC DATABASE.PKL -xyz

(see other functionalities: https://jkcspy.readthedocs.io/en/latest/JKQC.html)

### USING YOUR OWN PYTHON SCRIPT 

Theoretically, you can use only your own python but I really recommend to setup your python environment via JKCS (step 1-3 above). Then run:
  > JKpython

After activating the correct python environment, use python to analyse/use the data:
   > $USER/: python
   
   > import pandas as pd
   
   > clusters_dataframe = pd.read_pickle("DATABASE.PKL")
   
   
### STUCTURES NAMES

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
