from xtb.ase.calculator import XTB
from ase.io import read, write
from ase import units
from ase.md.verlet import VelocityVerlet
import numpy as np
import sys

## SETTTINGS ##
timestep = 1
velo = float(sys.argv[1])*10.1805 #Velocity in [Å/fs]
start_dist= float(sys.argv[2])/2 #Start distance [Å]
off_set = float(sys.argv[3]) #Collsion offset
first_mole_name = str(sys.argv[4]) #Filename with extension. 
second_mole_name = str(sys.argv[5]) #Filename with extension. 
index_to_run = str(sys.argv[6]) 
folder_path = str(sys.argv[7]) 
##Reading files and setting up calculator##
calc = XTB(method="GFN1-xTB")
first_mole= read(f"./{first_mole_name}",index=index_to_run)
second_mole = read(f"./{second_mole_name}",index=index_to_run)

def printenergy(a):
    """Function to print the potential, kinetic and total energy"""
    epot = a.get_potential_energy()/0.043364115308770496 #kcal/mol
    ekin = a.get_kinetic_energy()/0.043364115308770496    #kca/lmol
    dist_n = np.sqrt(np.sum(((a[0:split].get_center_of_mass()-a[split:].get_center_of_mass())**2)))
    dist_x = np.sqrt(np.sum(((a[0:split].get_center_of_mass()-a[split:].get_center_of_mass())**2)[0]))
    dist_y = np.sqrt(np.sum(((a[0:split].get_center_of_mass()-a[split:].get_center_of_mass())**2)[1]))
    print('PROPERTIES2: Epot= %.3f kcal/mol,  Ekin= %.3f kcal/mol, T= %3.0f K, Etot= %.3f kcal/mol, COMs_distance= %.5f x: %.5f y: %.5f Angstrom ' % (epot, ekin, ekin*0.043364115308770496 / (1.5 * units.kB*len(a)), epot + ekin, dist_n, dist_x, dist_y), flush=True)

first_mole.translate(-first_mole.get_center_of_mass()-[start_dist,off_set,0])
first_mole.set_velocities(first_mole.get_velocities()+[velo/2,0,0]) #Å/fs
split=len(first_mole)
second_mole.translate(-second_mole.get_center_of_mass()+[start_dist,0,0])
second_mole.set_velocities(second_mole.get_velocities()-[velo/2,0,0]) #Å/fs
image = first_mole+second_mole
image.set_calculator(calc)

diff = [np.nan,np.nan]
dist_n = np.sqrt(np.sum(((image[0:split].get_center_of_mass()-image[split:].get_center_of_mass())**2)))
dyn3 = VelocityVerlet(image, timestep * units.fs)
diff[0] = dist_n
dyn3.attach(printenergy,a=image, interval=1)
gradient = -10
while gradient < 0:
    dyn3.run(1)
    dist_n = np.sqrt(np.sum(((image[0:split].get_center_of_mass()-image[split:].get_center_of_mass())**2)))
    dist_x =  np.sqrt(np.sum(((image[0:split].get_center_of_mass()-image[split:].get_center_of_mass())**2)[0]))
    if dist_x > (start_dist*2)+1:
        exit()
    diff[1]=dist_n
    gradient = float(np.diff(diff))
    diff[0]=dist_n

COM_array = np.zeros(5000)
for idx in range(5000):
    dyn3.run(1)
    if index_to_run == 0:
        write(f"{folder_path}{index_to_run}_traj.xyz", image, append = True)
    COM_array[idx] = np.sqrt(np.sum(((image[0:split].get_center_of_mass()-image[split:].get_center_of_mass())**2)))
