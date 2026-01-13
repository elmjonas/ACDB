Data for the Article: "Coupled Cluster Free Energies for Atmospheric Molecular Clusters: Benchmark and Matching Experimental Free Energies"

outputfile_values:
- Contains TOML files with the output values from the calculations.
- The energy is the electronic energy in Hartree
- Frequency are the list of frequencies in cm^-1.
- num_imag are the number of imaginary frequencies. They will correspond to the frequncies at the start of the list.
- sigma is the rotational symmetry number.
- mass is the mass im amu. 
- rot_const is the list of rotational constants in cm^-1

binding_values:
 - contains TOML files with the calculated quasi-harmonic (100 cm^-1) free energy terms and their binding values.
 - All values are in kcal/mol
 - G is the free energy
 - G_thermal is the thermal free energy
 - VibEntropy is the vibrational entropy calculated using the quasi-harmonic approximation at 100 cm^-1
 - zpe is the zero point vibrational energy
 - "bind" refers to the binding value of the term

ccsdt_f12_structures:
 - Contains the DF-CCSD(F12b)(T*)/cc-pVDZ-F12 optimized structures for which the energies, frequencies, etc. can be found in  outputfile_values/ccsdt_f12.toml

sampling_dimers:
 - Contains the calculated properties for the sampling part of the article and the structures.
 - The headers in the space separated datafile are:
 - clustername: Is the clustertype
 - filename: Gives the full name of the structure file"
 - rotational_sym_number: The rotational symmetry number
 - freqs: The list of frequencies in cm^-1
 - mass: The mass of the cluster in amu
 - elec_sp: The electronic single point energy at the Normal LNO-CCSD(T)/CBS(aug-3,aug-4) level of theory
 - rotational_numbers: The list of rotational constants in cm^-1
