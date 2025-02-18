Data for the clusters used in the study:
"Iodine in the Atmosphere II: Cluster Formation Potential of Iodine Oxyacids and Iodine Oxides"
by Morten Engsvang and Jonas Elm

This folder contains the following calculations:
Main calculation: 
	(acid)_{1-2}(base)_{1-2} calculation, with:
	acid: HIO2 (isa), HIO3 (ica), I2O4 (it), I2O5 (ip), formic acid (fa), sulfuric acid (sa), methanesulfonic acid (msa), nitric acid (na)
	base: NH3 (am), CH3NH2 (ma), CH3NHCH3 (dma), CH3N(CH3)CH3 (tma), H2O (w)
	Initially only clusters with either 1 I2O4 or I2O5 was considered, given that they are
	equivalent to 2 acids via. the hydrolysis reaction.
	In addition to these we added:
	(ica/isa)_{1-4}(w)_{1-2}
	and to consider equivalent oxides we also calculate:
	(it/ip)_{1-2}(w)_{1-3}
	These are not perfectly equivalent due to water being consumed in the hydrolysis reaction
	but they are close enough.
Sulfuric acid--amine:
	Recalculation of the sulfuric acid(sa)-amine clusters on the form of (sa)_{0-2}(amine)_{0-2}
	taken from clusteromics I 2021 by J. Elm.
Furthermore, dimers and monomers are taken from the study:
"Iodine in the Atmosphere I: Computational Benchmark and Dimer Formatin of Oxy-acids and Oxides"
by Morten Engsvang, Haide Wu, and Jonas Elm

The following subfolders are present:
DLPNO_DFT:
        DFT with DLPNO electronic energy correction.
	Folder containing the pickle and txt files for the single-point energy calculations at the
	ZORA-DLPNO-CCSD(T_0), tight PNO level with the SARC-ZORA-TZVPP basis set for I and
	ma-ZORA-def2-TZVPP basis for all other atoms.
	Folder also contains the optimized structures obtained from the calculations stored in DFT.
	The single structure per cluster is obtained by sorting according to DLPNO level single-point energy.

DFT:
	Folder containing the pickle and txt files for the optimization and frequency calculations at the
	wB97X-D3BJ level, with aug-cc-pVTZ-PP combined with the SK-MCDHF-RSC pseudo-potential for I 
	and aug-cc-pVTZ for all other atoms.
	Folder also contains the optimized structures obtained from the calculations stored in DFT.
	The single structure per cluster is obtained by sorting according to DFT level free energy.

