Data for the iodine-containing clusters from the study:
"Iodine in the Atmosphere I: Computational Benchmark and Dimer Formatin of Oxy-acids and Oxides"
of systems which can be written:
(iodine_compound)_{1}(other)_{1}
where:
iodine_compounds = HIO3, HIO2, I2O4, I2O5
other = sulfuric acid, methanesulfuric acid, nitric acid, formic acid, water,
ammonia, methylamine, dimethylamine, trimethylamine, and ethylene diamine.
The calculations are carried out assuming 298.15K and 1 atm.

In this folder the following is present:
DLPNO:
	Folder containing the pickle and txt files for the single-point energy calculations at the
	ZORA-DLPNO-CCSD(T_0), tight PNO level with the SARC-ZORA-TZVPP basis set for I and
	ma-ZORA-def2-TZVPP basis for all other atoms.
	There are 1107 files in total.
	Folder also containing the optimized structures obtained from the calculations stored in DFT.

DFT:
	Folder containing the pickle and txt files for the optimization and frequency calculations at the
	wB97X-D3BJ level, with aug-cc-pVTZ-PP combined with the SK-MCDHF-RSC pseudo-potential for I 
	and aug-cc-pVTZ for all other atoms.
	There are 1107 files in total
	Folder also containing the optimized structures obtained from the calculations stored in DFT.

DLPNO_DFT:
        DFT with DLPNO electronic energy correction.

Additional_files/rel_calc:
	Folder containing the files for the relativistic calculations carried out in the study.

