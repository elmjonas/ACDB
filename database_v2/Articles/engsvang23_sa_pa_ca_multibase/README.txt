Data for the chlorine containing clusters from the study:
"Chlorine Oxyacids is Likely Contribute to Arctic Aerosol Formation"
of systems which can be written (acid)_{0-2}(base)_{0-2}
where acid: chloric acid, perchloric acid, and sulfuric acid
and base: ammonia, methylamine, dimethylamine, and trimethylamine.
The calculations are carried out assuming 298.15K and 1 atm, unless otherwise stated.

In this folder the following is present:

DLPNO:
Folder containing single-point energy calculations at the DLPNO-CCSD(T_0)/aug-cc-pVTZ
level of theory. They were run using ORCA 5.0.4 with normal PNO settings.
The files are stored in a .tar.gz file and the results can also be found in a pickle
There are 510 files.

DLPNO-DFT:
Folder containing the combined calculations at the DLPNO-CCSD(T_0)/aug-cc-pVTZ//wB97X-D/6-31++G(d,p)
level of theory. There are 510 structures in total. This folder contains:
database.pkl:
	All 510 structures stored in 1 pickle file, with the energy at the
	DLPNO-CCSD(T_0)/aug-cc-pVTZ//wB97X-D/6-31++G(d,p) level of theory. 
database1DFT.pkl:
	All data for the lowest energy structure of each cluster type at the
	wB97X-D/6-31++G(d,p) level of theory.
database1DLPNO.pkl:
	All data for the lowest energy structure of each cluster type at the
        DLPNO-CCSD(T_0)/aug-cc-pVTZ//wB97X-D/6-31++G(d,p) level of theory.
properties1DFT.txt
	Thermochemistry of the lowest energy structure of each cluster type
	at the wB97X-D/6-31++G(d,p) level of theory at 298.15K
	Gibbs free energy, enthalpy and entropy is given in either Hartree or
	Hartree/K
properties1DLPNO.txt
	Thermochemistry of the lowest energy structure of each cluster type
        at the DLPNO-CCSD(T_0)/aug-cc-pVTZ//wB97X-D/6-31++G(d,p) level of theory at 298.15K
        Gibbs free energy, enthalpy and entropy is given in either Hartree or
        Hartree/K
structures1DFT.xyzs
	XYZ coordinates of the lowest energy structure of each cluster type at the
	wB97X-D/6-31++G(d,p) level of theory.
structures1DLPNO.xyzs
	XYZ coordinates of the lowest energy structure of each cluster type at the
        DLPNO-CCSD(T_0)/aug-cc-pVTZ//wB97X-D/6-31++G(d,p) level of theory.
structures.xyzs
	XYZ coordinates of all the generated structures.

Additional files:
Folder containing geometry optimization logs at the wB97X-D/6-31++G(d,p)
level of theory. They were run using Gaussian 16. The files are stored in a .tar.gz file in our own reposortories.
There are 510 files.
