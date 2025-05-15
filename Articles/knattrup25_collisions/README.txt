---------------------
CODE
---------------------
equ.py does the equilibrium simulations
shoot.py does the collision simulations

Examples:
python3 shoot.py 0.004 20 30 1am_T300_MEANSIZE100.xyz 10sa10am_T300_MEANSIZE100.xyz 99
Will shoot the structures indexed with 99 at each other with a velocity of 400 m/s, a distance of 20 Å and an offset of 30 Å.

python3 equ.pyi 10sa10dma.xyz
Will equlibrate 10sa10dma. 

----------------------
LOGS
----------------------
Data for Figure 2: 200.toml
Data for Figure 6: mixed_data.csv 
Data for Figure 8: grid_sa_am_am_gfn.csv and grid_sa_am_sa_gfn.csv
Data for Figure 9: data_10sa10am_1am.zip and data_10sa10am_1sa.zip
