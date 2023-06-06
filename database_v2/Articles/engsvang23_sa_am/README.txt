These folders contain the files from the calculations carried out in the
study by Engsvang et al. The numbering of structures is consistent
across the databases, i.e., identical structures in each database has
identical names.
Due to a change in naming convention, halfway through the project, we could
not associate the original GFN1-xTB optimization to each final structure.
Therefore, we carried out hessian calculations on each GFN1-xTB structure
in order to obtain correctly associated thermal corrections.
These calculations showed that all 21667 GFN1-xTB structures are 
equilibrium structures. Therefore r2SCAN-3c was calculated for all of them,
however, the initial calculations had showed that a subset were imaginary, 
therefore, B97-3c was only calculated for 17079 of the structures.
wB97X-D for the whole set of structures was attempted, however, due to the 
scaling of the method only clusters of limited size was calculated.

There are 4 folders, 3 corresponding to calculations carried out at the 3
different levels of theory and 1 for the leftover structures for which
single-point corrections were not carried out.
The 3 folders corresponding to the full calculations are:
B97-3c_GFN1-xTB: Calculations at the B97-3c//GFN1-xTB level of theory.
r2SCAN-3c_GFN1-xTB: Calculations at the r2SCAN-3c//GFN1-xTB level of theory.
wB97X-D_GFN1-xTB: Calculations at the wB97X-D3BJ/6-311++G(3df,3pd)//GFN1-xTB
level of theory.

Additional_files: Contains the structures for which B97-3c was not 
calculated, i.e., these are the ones for which the initial calculations
showed them to be imaginary.

See https://github.com/elmjonas/ACDB/tree/master/database_v2#using-the-pickled-files to understand how to handle the pickled files
