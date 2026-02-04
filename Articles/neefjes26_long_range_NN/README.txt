This is the repository for the manuscript:

Machine learning interatomic potentials with accurate long-range interactions for molecular dynamics collision simulations of atmospherically-relevant molecules

Ivo Neefjes, Jakub Kubecka, and Jonas Elm

The following files are included for the H2SO4-H2SO4, H2SO4-CH(NH3)2, and H2SO4-HSO4- collision systems for both the GFN1-xTB and wB97X-3c level of theory:
- training datasets
- example AIMNet2 model definition and training configuration files
- trained AIMNet2, PaiNN and delta-PaiNN models
- example molecular dynamics collision trajectory simulations submit script

Note that the ML models are given extension .pkl for usage in the JK framework. However, the actual file extensions are .jpt for AIMNet2 and .pt for PaiNN.
