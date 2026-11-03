# Sulfuric acid–base cluster data

## Associated study

Wu et al., *Bridging molecular and nanometer scales in atmospheric new particle formation with quantum chemical modeling.*

ChemRxiv preprint DOI: [10.26434/chemrxiv.15010418/v1](https://chemrxiv.org/doi/abs/10.26434/chemrxiv.15010418/v1)

## Dataset

`added_04fil_w_monomers.pkl` contains molecular structures, electronic energies, vibrational frequencies, and thermochemical quantities for four neutral, unhydrated sulfuric acid–base systems:

- Sulfuric acid–ammonia (SA–AM)
- Sulfuric acid–methylamine (SA–MA)
- Sulfuric acid–dimethylamine (SA–DMA)
- Sulfuric acid–trimethylamine (SA–TMA)

The dataset contains **8,104 records** spanning **132 composition labels**. Binary clusters extend through 11:11, including neighboring compositions with one excess acid or base molecule. The original file also contains eight isolated monomer records, including `1fa`, `1msa`, and `1nta`.

## Computational methods

Structures and vibrational frequencies were calculated at the B97-3c level. Electronic-energy refinement uses direct DLPNO-CCSD(T₀)/aug-cc-pVTZ calculations for smaller clusters and Δ-learning corrections for larger clusters, using kernel ridge regression with the FCHL19 representation. Further methodological details are provided in the associated study.
