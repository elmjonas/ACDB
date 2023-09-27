# ACDB2.0

This folder contains new version of ACDB where the structures are stored in pickled files.

This manual contains descriptions of:
 - Subfolders (i.e. methods that were used to obtain the clusters)
 - Type of files (i.e. what is saved in each file)
 - How to download only specific subfolder!
 - Using the pickles files (i.e. how to utilize JKQC or manipulate with databases)

## Subfolders

### Articles

- This folder contains over 35 articles and molecular clusters/data provided from them.
- The newest folders contain metadata described in greater detail.
- The old articles sometimes lack proper description.

### Full_database

- Full database contains 1112775 entries.

### SP_energies

- This folder contains SP energies calculated level of theory specified by each subfolder
- See the levels.txt file for more details on program version and method input.

- **B97-3c/**
   - contains 28270 entries
   - contains 108 different cluster types
- **DLPNO-CCSD-T_aug-cc-pVTZ_NormalPNO/**
   - contains 5589 entries
   - contains 1592 different cluster types
- **DLPNO-CCSD-T_aug-cc-pVTZ_TightPNO/**
   - contains 1073 entries
   - contains 292 different cluster types
- **G09-wB97X-D_6-31++Gxx/**
   - contains 68695 entries
   - contains 1045 different cluster types
- **G16-wB97X-D_6-31++Gxx/**
   - contains 40117 entries
   - contains 1193 different cluster types
- **GFN1-xTB/**
   - contains 325137 entries
   - contains 382 different cluster types
- **ORCA-wB97X-D_6-311++Gxx/**
   - contains 11350 entries
   - contains 50 different cluster types
- **r2SCAN-3c/**
   - contains 276538 entries
   - contains 382 different cluster types

### Equilibrium_TMD

- This folder contains free energy properties for SP_electronic_energy//geom._optim.+TMD
- Some monomers are missing, hence not all binding properties are provided
- For all wB97X-D TMD, we use anharmonicity (-v 0.996) and low-vibrational (-fc 100) treatement

- **B97-3c__B97-3c/**
   - contains 2233 entries
   - contains 34 different cluster types
- **B97-3c__GFB1-xTB/**
   - contains 17079 entries
   - contains 91 different cluster types
- **DLPNO-CCSD-T_aug-cc-pVTZ_NormalPNO__G09-wB97X-D_6-31++Gxx/**
   - contains 1957 entries
   - contains 782 different cluster types
- **DLPNO-CCSD-T_aug-cc-pVTZ_NormalPNO__G16-wB97X-D_6-31++Gxx/**
   - contains 3293 entries
   - contains 972 different cluster types
- **DLPNO-CCSD-T_aug-cc-pVTZ_TightPNO__G09-wB97X-D_6-31++Gxx/**
   - contains 118 entries
   - contains 88 different cluster types
- **DLPNO-CCSD-T_aug-cc-pVTZ_TightPNO__G16-wB97X-D_6-31++Gxx/**
   - contains 835 entries
   - contains 228 different cluster types
- **G09-wB97X-D_6-31++Gxx__G09-wB97X-D_6-31++Gxx/**
   - contains 44482 entries
   - contains 863 different cluster types
- **G16-wB97X-D_6-31++Gxx__G16-wB97X-D_6-31++Gxx/**
   - contains 60235 entries
   - contains 1265 different cluster types
- **GFN1-xTB__GFB1-xTB/**
   - contains 65001 entries
   - contains 91 different cluster types
- **r2SCAN-3c__GFB1-xTB/**
   - contains 24874 entries
   - contains 91 different cluster types

### FORCES

TO BE DONE

## Files

- databases:
  - database.pkl
    - all data collected from the given folder 
    - database is often split into database_s<int>.pkl files with maximum 10000 entries per file  
  - database1DFT.pkl  
    - 1 lowest (DFT[geometry+TMD]) Gibbs free energy structure per cluster from database.pkl
  - database1DLPNO.pkl
    - 1 lowest (DLPNO[SP corr]//DFT[geometry+TMD]) Gibbs free energy structure from database.pkl
- structures:
  - structures1DFT.xyzs and structures1DLPNO.xyzs
    - structures from database1DFT.pkl and structures1DLPNO.pkl, respectively
- properties:
  - properties1DFT.txt and properties1DLPNO.txt
    - properties from database1DFT.pkl and structures1DLPNO.pkl, respectively
    - QHA and anharmonicity corrections applied
    - these are in the following format:
             structure_name | dG(298.15K) | dH(298.15K) | dS(298.15K)
- binding properties:
  - located only in the most outside folder
  - binding_properties3DFT.txt and binding_properties1DLPNO.txt
    - 1 lowest (DFT or DLPNO//DFT) Gibbs free energies of formation from database3DFT.pkl and database1DLPNO.pkl, respectively

## DOWNLOADING FROM ACDB

If you are interested in e.g. this folder: https://github.com/elmjonas/ACDB/master/tree/database_v2/Articles/kubecka19_sa_gd
then you must replace *master/tree* with *trunk* and use svn to downlaod the folder:

  svn checkout https://github.com/elmjonas/ACDB/trunk/database_v2/Articles/kubecka19_sa_gd

## USING THE PICKLED FILES

In order to use any database, you can:
* use JKQC (see https://jkcs.readthedocs.io/en/latest/) or see below
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

(see other functionalities: https://jkcs.readthedocs.io/en/latest/)

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
 - bda=butane-1,4-diamine
 - buta=butamine
 - dbma=dibuthylmethylamine
 - dea=diethylmine
 - dma=dimethylamine
 - dmea=dimethylethylamine
 - dpenta=dipentamine
 - dpropa=dipropamine
 - eda=ethylendiamine
 - gd=guanidine
 - dhexa=dihexamine
 - ibuta=isobutylamine
 - ipropa=iso-propylamine
 - ipropea=iso-propylethylamine
 - ma=methylamine
 - mda=methylethylendiamine
 - mea=monoethylamine
 - nona=nonamine
 - pda=propan-1,3-diamine
 - propa=propamine
 - put=putrescine
 - pz=piperazine
 - sbuta=sec-butamine
 - tbuta=tributylamine
 - tibuta=triisobutylamine
 - tea=triethylamine
 - tma=trimethylamine
 - tpropa=tripropamine
 - diAAmda=N,N-dimethylethylendiamine
 - diABmda=N,N-dimethylethylendiamine
 - triAABmda=trimethylethylendiamine
 - teAABBmda=tetramethylethylendiamine
 - IIebuta=2-ethylbutylamine
    
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
