#from ase.calculators.orca import ORCA
from xtb.ase.calculator import XTB
from ase.io import read
from ase.io import write
from ase import units
from ase.md.velocitydistribution import MaxwellBoltzmannDistribution
from ase.md.velocitydistribution import Stationary
from ase.md.velocitydistribution import ZeroRotation
from ase.md.langevin import Langevin
from ase.md.npt import NPT
from ase.md.andersen import Andersen
from ase.io.trajectory import Trajectory,TrajectoryReader
import numpy as np
import sys
huh = sys.argv[1]
sub_dir = sys.argv[2]
input_name = huh[:-4]
calc = XTB(method="GFN1-xTB")
first_mole = read(f"./{input_name}.xyz",'-2')

first_mole.translate(-first_mole.get_center_of_mass())
first_mole.set_calculator(calc)


class LowMemoryMeanCalculator:
    def __init__(self, window_size):
        self.window_size = window_size
        self.values = [0] * window_size
        self.pointer = 0
        self.count = 0
        self.sum = 0

    def add_value(self, value):
        self.sum += value - self.values[self.pointer]
        self.values[self.pointer] = value

        self.pointer = (self.pointer + 1) % self.window_size

        if self.count < self.window_size:
            self.count += 1
    def print_val(self):
        return self.values

    def mean(self):
        if self.count == 0:
            return 0  # or return None, depending on your use case
        return self.sum / self.count



## SETTTINGS ##
T=300
timestep = 1
frict = 0.01
equ_steps = 1000000
mean_size = 100

## First molecule equ.
#print('######################################', flush=True)
#print('#### Andersen act 1e-1 ####', flush=True)
#print('######################################', flush=True)
MaxwellBoltzmannDistribution(first_mole, temperature_K=T, force_temp=True)
dyn = Langevin(first_mole, timestep * units.fs, temperature_K=T, friction=frict/units.fs, fixcm=True)

#tot_mean = LowMemoryMeanCalculator(window_size=mean_size)
#rot_mean = LowMemoryMeanCalculator(window_size=mean_size)
#vib_mean = LowMemoryMeanCalculator(window_size=mean_size)
#traj = Trajectory('example.traj', 'w', first_mole)
#dyn.attach(traj,interval=1000)
a=first_mole
counter_num=-1

def backupme(a,counter_num):
    counter_num += 1
    print('BACKUP WRITTEN', flush=True)
#    write(sub_dir+'/'+f'{input_name}_BACKUP_{counter_num}.xyz',a, append = True)
dyn.attach(backupme,a=a,interval=equ_steps/10,counter_num=counter_num)
def testing(a):
    epot = a.get_potential_energy()/0.043364115308770496 #kcal/mol
    ekin=a.get_kinetic_energy()
    change_a = a.copy()
    T_temp = change_a.get_temperature()
    Stationary(change_a, False)
    T_com =  change_a.get_temperature()
    ZeroRotation(change_a, False)
    T_rotate = change_a.get_temperature()
    T_tr =  len(change_a)*(T_temp-T_com)
    T_rot = len(change_a)*(T_com-T_rotate)
    T_vib = len(change_a)/(len(change_a)-2)*T_rotate
   
#    tot_mean.add_value(T_temp)
#    rot_mean.add_value(T_rot)
#    vib_mean.add_value(T_vib)
    write(sub_dir+'/'+f'{input_name}_T{T}_MEANSIZE{mean_size}.xyz',a, append = True)
    print(T_com,T_rotate,T_temp,T_tr,T_rot,T_vib,flush=True)

for x in range(equ_steps):
    dyn.run(1)
dyn.attach(testing,a=a,interval=500)
dyn.run(500*100+1)

