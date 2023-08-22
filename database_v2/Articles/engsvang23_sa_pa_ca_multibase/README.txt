Data for the chlorine containing clusters from the study:
"Chlorine Oxyacids is Likely Contribute to Arctic Aerosol Formation"
of systems which can be written (acid)_{0-2}(base)_{0-2}
where acid: chloric acid, perchloric acid, and sulfuric acid
and base: ammonia, methylamine, dimethylamine, and trimethylamine.
In this folder the following is present:

chlorine.pkl:
pickle file containing the information from the freq and single-point calculations.
Currently the 1ca1am and 1ca1am1dma files are duplicated i.e. there are two instances
of each file present in the pickle, we apologise for the inconvenience.
There are therefore 517 structures present in the pickle vs. the 510 in the rest of the folders.

optimization:
Folder containing log files from geometry optimization at the wB97X-D/6-31++G(d,p) level of theory.
There are 510 files. The optimization of the 1pa1dma structures were done with opt freq, 
which means that the opt and freq files for these are identical.
They were run using Gaussian 16

frequencies:
Folder containing log files from vibrational calculation at the wB97X-D/6-31++G(d,p) level of theory.
There are 510 files. The vibrational calculation of the 1pa1dma structures were done with opt freq, 
which means that the opt and freq files for these are identical.
They were run using Gaussian 16

single_point:
Folder containing out files from single-point energy calculation at the DLPNO-CCSD(T_0)/aug-cc-pVTZ
level of theory. There are 510 files. They were run using ORCA 5.0.4 with normal PNO settings.

structures:
Folder containing the optimized structures. There are 510 files.

