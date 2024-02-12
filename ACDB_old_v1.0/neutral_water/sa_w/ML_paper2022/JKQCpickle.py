####################################################################################################
# Reading input

import os
import sys

def listToString(s,spaces): 
    # initialize an empty string
    str1 = ""
    # traverse in the string  
    for ele in s: 
        str1 += ele  
        str1 += spaces 
    # return string  
    return str1

# Checking if correct environmnent is loaded
if str(os.environ.get("VIRTUAL_ENV").split("/")[-1]) != "JKCS":
  print("Trying to load JKCS environment by myself since you were lazy ass and did not do it!.")
  from subprocess import call
  if not call(['/bin/bash', '-i', '-c', "JKpython; python "+listToString(sys.argv," ")]):
    print("This time, JKCS environment was loaded. Please, load it next time by yourself (JKpython).")
  else:
    print("You did not load JKCS environment and I was not able to do it for you.")
  exit()

def print_help():
  print("##################################################")
  print("### python JKQC.py [FILES] [ARGUMENTS] [PRINT] ###\n")
  print("FILES:")
  print(" any .xyz .log .out files")
  print(" any .pkl (you can also use -in/-out)\n")
  print("ARGUMENTS:")
  print(" -help      print this help")
  print(" -in X.pkl  read data from a database")
  print(" -out X.pkl save data to XX.pkl")
  print(" -folder X  takes in all X/*.log files")
  print(" -noname    the file names are not analysed (e.g. 1000-10_1.xyz)\n")
  print("PRINT:")
  print(" -b                 basename")
  print(" -nXYZ,-nLOG,-nOUT  name with its extension")
  print(" -pXYZ,-pLOG,-pOUT  full_path/name with its extension")
  print(" -ePKL              pkl_full_filepath/:EXTRACT:/basename")
  print(" -el       electronic energy from .log [Eh]   -rot        RMSD of rotational constants [GHz]")
  print(" -elout    el. energy from .out [Eh]          -rots       rotational constants [GHz]") 
  print(" -elc      elc=elout-el [Eh]                  -mult       muliplicity [-]")
  print(" -zpec     ZPE correction [Eh]                -char,-chrg charge [-electron_charge]    ")
  print(" -zpe      ZPE=el+zpec [Eh]                   -mull       Mulliken charges [-electron_charge]")
  print(" -zpeout   ZPEout=elout+zpec [Eh]             -dip        dipole moment [Debye]")
  print(" -uc       energy thermal correction [Eh]     -dips       dipole moments [Debye]")
  print(" -u        internal energy U=el+uc [Eh]       -pol        polarizability [Angstrom^3]")
  print(" -uout     Uout=elout+uc [Eh]                 -templog    temperature used in .log [K]")
  print(" -hc       enthalpy th. corr. hc=uc+kT [Eh]   -preslog    pressure used in .log [atm]")
  print(" -h        enthalpy energy H=el+hc [Eh]       -lf         the lowest vib. freq. [1/cm]")
  print(" -hout     Hout=elout+hc [Eh]                 -f          array of vibration freq. [1/cm]")
  print(" -s        entropy [cal/(mol.K)]              -rsn        rotational symmetry number [-]")
  print(" -gc       Gibbs free energy th. corr. [Eh]   -t,-time    total computational time [mins]")
  print(" -xyz      save all xyz files                 -rg         radius of gyration [Angstrom]")

folder = "./"	
files = []  
input_pkl = []
output_pkl = "mydatabase.pkl"

Qclustername = 1 #Analyse file names for cluster definition?
Qextract = 0 #Do I want to extarct only some cluster_type(s)?
Pextract = []

Qout = 0 #Do I want to save output.pkl?
Pout = []

last = ""
for i in sys.argv[1:]:
  #HELP
  if i == "-help" or i == "--help":
    print_help()
    exit()
  #FOLDER
  if i == "-folder":
    last = "-folder"
    continue
  if last == "-folder":
    last = ""
    if os.path.exists(i):
      folder = i
      continue
    else:
      print("Folder "+i+" does not exist. [EXITING]")
      exit()
  #INPKL
  if i == "-in" or i == "-i":
    last = "-in"
    continue
  if last == "-in":
    last = ""
    if os.path.exists(i):    
      input_pkl.append(i)
      continue
    else:
      print("File "+i+" does not exist. Sorry [EXITING]")
      exit()
  #OUTPKL
  if i == "-out" or i == "-o":
    last = "-out"
    continue
  if last == "-out":
    last = ""
    if output_pkl != "mydatabase.pkl":
      print("Hey are you trying to use two different outputs? "+output_pkl+"/"+i+" [EXITING]")
      exit()
    else:
      output_pkl = i
      Qout = 1
      continue
  #NONAME
  if i == "-noname":
    Qclustername = 0
    continue
  #EXTRACT
  if i == "-extract":
    last = "-extract"
    continue
  if last == "-extract":
    last = ""
    Qextract = 1
    Pextract.append(i)
    continue
  #INPUT FILES
  if len(i) > 3:
    ext = i[-4:]
    if ext == ".xyz" or ext == ".log" or ext == ".out":
      if os.path.exists(i):
        files.append(i)
        continue
      else:
        print("File "+i+" does not exist. Sorry [EXITING]")
        exit()
    if ext == ".pkl":
      if os.path.exists(i):
        input_pkl.append(i)
        continue
      else:
        if output_pkl != "mydatabase.pkl":
          print("Hey either one input database does not exist or you are trying to use two different outputs? "+output_pkl+"/"+i+" [EXITING]")
          exit()
        else:
          output_pkl = i
          continue
  ########
  # XYZ
  if i == "-xyz" or i == "--xyz" or i == "-XYZ" or i == "--XYZ":
    Pout.append("-xyz")
    continue
  # RG
  if i == "-rg" or i == "--rg" or i == "-Rg" or i == "--Rg":
    Pout.append("-rg")
    continue
  # INFO
  if i == "-b" or i == "-basename" or i == "--b" or i == "--basename":
    Pout.append("-b")
    continue
  if i == "-nOUT" or i == "--nOUT":
    Pout.append("-nOUT")
    continue
  if i == "-nLOG" or i == "--nLOG":
    Pout.append("-nLOG")
    continue
  if i == "-nXYZ" or i == "--nXYZ":
    Pout.append("-nXYZ")
    continue
  if i == "-pOUT" or i == "--pOUT":
    Pout.append("-pOUT")
    continue
  if i == "-pLOG" or i == "--pLOG":
    Pout.append("-pLOG")
    continue
  if i == "-pXYZ" or i == "--pXYZ":
    Pout.append("-pXYZ")
    continue
  if i == "-ePKL" or i == "--ePKL":
    Pout.append("-ePKL")
    continue
  # LOG & OUT
  if i == "-el" or i == "-elen" or i == "--el" or i == "--elen":
    Pout.append("-el")
    continue
  if i == "-elout" or i == "--elout":
    Pout.append("-elout")
    continue
  if i == "-elc" or i == "--elc":
    Pout.append("-elc")
    continue
  if i == "-g" or i == "-gibbs" or i == "--g" or i == "--gibbs":
    Pout.append("-g")
    continue
  if i == "-h" or i == "-enthalpy" or i == "--h" or i == "--enthalpy":
    Pout.append("-g")
    continue
  if i == "-zpec" or i == "-zpecorr" or i == "--zpec" or i == "--zpecorr":
    Pout.append("-zpec")
    continue
  if i == "-zpe" or i == "-ZPE" or i == "--zpe" or i == "--ZPE":
    Pout.append("-zpe")
    continue
  if i == "-zpeout" or i == "-ZPEout" or i == "--zpeout" or i == "--ZPEout":
    Pout.append("-zpeout")
    continue
  if i == "-lf" or i == "-lfreq" or i == "--lf" or i == "--lfreq":
    Pout.append("-lf")
    continue
  if i == "-f" or i == "-freq" or i == "--f" or i == "--freq":
    Pout.append("-f")
    continue
  if i == "-rot" or i == "--rot":
    Pout.append("-rot")
    continue
  if i == "-rots" or i == "--rots":
    Pout.append("-rots")
    continue
  if i == "-mult" or i == "--mult":
    Pout.append("-mult")
    continue
  if i == "-char" or i == "-chrg" or i == "--char" or i == "--chrg":
    Pout.append("-char")
    continue
  if i == "-mull" or i == "--mull":
    Pout.append("-mull")
    continue
  if i == "-dip" or i == "--dip":
    Pout.append("-dip")
    continue
  if i == "-dips" or i == "--dips":
    Pout.append("-dips")
    continue
  if i == "-pol" or i == "--pol":
    Pout.append("-pol")
    continue
  if i == "-templog" or i == "--templog":
    Pout.append("-templog")
    continue
  if i == "-preslog" or i == "--preslog":
    Pout.append("-preslog")
    continue
  if i == "-rsn" or i == "--rsn":
    Pout.append("-rsn")
    continue
  if i == "-t" or i == "--t" or i == "-time" or i == "--time":
    Pout.append("-t")
    continue
  #UNKNOWN ARGUMENT   
  print("I am sorry but I do not understand the argument: "+i+" [EXITING]")
  exit()  

####################################################################################################
# Checking for arguments

if len(files) == 0:
  if len(input_pkl) == 0:
    import glob
    files = glob.glob(folder+"/*.log")
    if len(files) == 0:
      print("No inputs. No *.log files. [EXITING]")
      exit()
  if len(input_pkl) > 1:
    Qout = 1
else:
  if len(Pout) == 0:
    Qout = 1
    print("Number of files: "+str(len(files)))
  else:
    Qout = 2

import pandas as pd
import re
import numpy as np
from ase.io import read,write


####################################################################################################
# THIS IS TAKEN FROM tool.py IN JKCS.py 
### Append to dataframe 
def df_add_append(dataframe,label,name,indexs,variables):
  if (label,name) in dataframe.columns:
    newdataframe = pd.DataFrame(variables, index = indexs, columns = pd.MultiIndex.from_tuples([(label,name)]) )
    dataframe = dataframe.append(newdataframe)
  elif dataframe.shape == (0, 0):
    dataframe = pd.DataFrame(variables, index = indexs, columns = pd.MultiIndex.from_tuples([(label,name)]) )
  else:
    dataframe[label,name] = pd.DataFrame(variables, index = indexs, columns = pd.MultiIndex.from_tuples([(label,name)]) )

  return dataframe

### Add to dataframe via iteration
def df_add_iter(dataframe,label,name,indexs,variables):
  if (label,name) in dataframe.columns:
    df_l = dataframe.shape[0]
    var_l = len(variables)
    for i in range(var_l):
      dataframe[label,name][df_l-var_l+i] = variables[i]
  elif dataframe.shape == (0, 0):
    dataframe = pd.DataFrame(variables, index = indexs, columns = pd.MultiIndex.from_tuples([(label,name)]) )
  else:
    dataframe[label,name] = pd.DataFrame(index = indexs, columns = pd.MultiIndex.from_tuples([(label,name)]) )
    for i in range(len(variables)):
      dataframe[label,name][i] = variables[i]

  return dataframe
####################################################################################################

# Loading input pikles
if len(input_pkl) == 0:
  clusters_df = pd.DataFrame()
else:
  for i in range(len(input_pkl)):
    newclusters_df = pd.read_pickle(input_pkl[i])
    newclusters_df.index = [str(j) for j in range(len(newclusters_df))]
    if Qout == 1:
      print("Number of files in "+input_pkl[i]+": "+str(len(newclusters_df)))
    if i == 0: 
      clusters_df = newclusters_df
    else:
      len_clusters_df = len(clusters_df)
      newclusters_df.index = [str(j+len_clusters_df) for j in range(len(newclusters_df))]
      clusters_df = clusters_df.append(newclusters_df)

def seperate_string_number(string):
    previous_character = string[0]
    groups = []
    newword = string[0]
    for x, i in enumerate(string[1:]):
        if i == "_" or previous_character == "_":
            newword += i
        elif i.isalpha() and previous_character.isalpha():
            newword += i
        elif i.isnumeric() and previous_character.isnumeric():
            newword += i
        else:
            groups.append(newword)
            newword = i
        previous_character = i
        if x == len(string) - 2:
            groups.append(newword)
            newword = ''
    return groups

def zeros(input_array):
  output_string = ""
  skip = 0
  for i in range(len(input_array)):
    if skip == 1:
      skip = 0
      continue
    if input_array[i] == "0":
      skip = 1
      continue
    output_string += input_array[i]
  return output_string

# Reading the new files in
missing = "NaN"
for file_i in files:
  folder = os.path.abspath(file_i)[::-1].split("/",1)[1][::-1]+"/"
  file_i_BASE = file_i[:-4][::-1].split("/",1)[0][::-1]
  file_i_XTB  = folder+file_i_BASE+".log"
  file_i_G16  = folder+file_i_BASE+".log"
  file_i_XYZ  = folder+file_i_BASE+".xyz"
  file_i_ORCA = folder+file_i_BASE+".out"
  file_i_INFO = folder+"info.txt" 
 
  ###############
  ### INFO ######
  ###############
  cluster_id = len(clusters_df)
  clusters_df = df_add_append(clusters_df, "info", "folder_path", [str(cluster_id)], folder)
  clusters_df = df_add_iter(clusters_df, "info", "file_basename", [str(cluster_id)], [file_i_BASE])
  # sorted cluster type
  if Qclustername == 1:
    cluster_type_array = seperate_string_number(file_i_BASE.split("-")[0])  
    cluster_type_2array_sorted = sorted([cluster_type_array[i:i + 2] for i in range(0, len(cluster_type_array), 2)],key=lambda x: x[1])
    cluster_type_array_sorted = [item for sublist in cluster_type_2array_sorted for item in sublist]
    cluster_type_string = zeros(cluster_type_array_sorted)
    clusters_df = df_add_iter(clusters_df, "info", "cluster_type", [str(cluster_id)], [cluster_type_string])
    #
    components = re.split('(\d+)', file_i_BASE.split("-")[0])[1:][1::2]
    clusters_df = df_add_iter(clusters_df, "info", "components", [str(cluster_id)], [components])
    component_ratio = [int(i) for i in re.split('(\d+)', file_i_BASE.split("-")[0])[1:][0::2]]
    clusters_df = df_add_iter(clusters_df, "info", "component_ratio", [str(cluster_id)], [component_ratio])
  if os.path.exists(file_i_INFO):
    file = open(file_i_INFO, "r")  
    for line in file:
      clusters_df = df_add_iter(clusters_df, "info", str(line.split(" ",1)[0]), [str(cluster_id)], [line.split(" ",1)[-1].strip()])    
    file.close()

  ###############
  ### XTB #######
  ###############
  if os.path.exists(file_i_XTB):
    file = open(file_i_XTB, "r")
    testXTB = 0
    for i in range(5):
      if re.search("\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-", file.readline()):
        testXTB = 1
        break
    if testXTB == 1:
      out_electronic_energy = ""                    #1
      for line in file:
        if re.search("TOTAL ENERGY", line): #1
          out_electronic_energy = float(line.split()[3])
      if out_electronic_energy == "": #1
        out_electronic_energy = missing
      clusters_df = df_add_iter(clusters_df, "log", "electronic_energy", [str(cluster_id)], [out_electronic_energy])
    file.close()

  ###############
  ### G16 #######
  ###############
  if os.path.exists(file_i_G16):
    file = open(file_i_G16, "r")
    testG16 = 0
    for i in range(5):
      if re.search("Gaussian", file.readline()):
        testG16 = 1
        break
    if testG16 == 1:
      out_time = missing                                 #TIME
      out_charge = missing                               #I1
      out_multiplicity = missing                         #I2
      out_NAtoms = missing                               #I3
      out_rotational_constants = missing                 #O1
      out_rotational_constant = missing                  #O2
      out_electronic_energy = missing                    #O3
      out_mulliken_charges = missing                     #O4
      out_dipole_moment = missing                        #O5
      out_dipole_moments = missing                       #O6
      out_polarizability = missing                       #O7
      out_vibrational_frequencies = missing              #V1
      out_temperature = missing                          #V2
      out_pressure = missing                             #V3
      out_rotational_symmetry_number = missing           #T1
      out_zero_point_correction = missing                #T2
      out_energy_thermal_correction = missing            #T3
      out_enthalpy_thermal_correction = missing          #T4
      out_gibbs_free_energy_thermal_correction = missing #T5
      out_zero_point_energy = missing                    #T6
      out_internal_energy = missing                      #T7
      out_enthalpy_energy = missing                      #T8
      out_gibbs_free_energy = missing                    #T9
      out_entropy = missing                              #E1
      search=-1
      save_mulliken_charges=0
      save_something=""
      for line in file:
        #TIME
        if re.search("Job cpu time:",line): 
          if out_time == missing:
            out_time = 0
          out_time += float(line.split()[3])*24*60+float(line.split()[5])*60+float(line.split()[7])+float(line.split()[9])/60 
        #INITIAL SEARCH
        if search==-1:
          if re.search(" Charge = ", line): #I1/I2
            out_charge = int(line.split()[2])
            out_multiplicity = int(line.split()[5])
            search += 1
            continue
        #OPTIMIZATION SEARCH
        ## I will convert the strings into floats/ints later !!!!!!!
        if search==0 or search==-1: 
          if out_NAtoms == missing: 
            if re.search(" NAtoms=", line): #I3
              out_NAtoms = int(line.split()[1])
              continue
          if re.search("Rotational constants ", line): #O1/O2
            out_rotational_constants = [str(line.split()[3]),str(line.split()[4]),str(line.split()[5])]
            continue
          if re.search("SCF Done", line): #O3
            out_electronic_energy = str(line.split()[4])
            continue
          ## MULLIKEN
          if re.search(" Mulliken charges:", line): #O4
            save_mulliken_charges = out_NAtoms+1
            save_something = "mulliken_charges"
            out_mulliken_charges = ["0"]*out_NAtoms
            continue
          if save_something == "mulliken_charges":
            if save_mulliken_charges<=out_NAtoms:
              out_mulliken_charges[out_NAtoms-save_mulliken_charges] = str(line.split()[2])
            save_mulliken_charges-=1
            if save_mulliken_charges == 0:
              save_something = ""
            continue
          ## DIPOLE
          if re.search('Dipole moment \(field-independent basis, Debye\):', line): #O5/O6
            save_something = "dipole_moment"
            continue
          if save_something == "dipole_moment":
            out_dipole_moment = str(line.split()[7])
            out_dipole_moments = [str(line.split()[1]), str(line.split()[3]), str(line.split()[5])]
            save_something = ""
            continue
          # POLARIZABILITY 
          if re.search("Exact polarizability", line): #O7
            pol = [float(i) for i in line.split()[2:]]
            pol_mat = np.matrix([[pol[0],pol[1],pol[3]],[pol[1],pol[2],pol[4]],[pol[3],pol[4],pol[5]]])
            out_polarizability = 0.14818471147*sum(np.linalg.eigh(pol_mat)[0])/3.
            search+=1
            #+unit conversion
            out_rotational_constants = [float(i) for i in out_rotational_constants]
            out_rotational_constant = np.linalg.norm(out_rotational_constants)
            out_electronic_energy = float(out_electronic_energy)
            out_mulliken_charges = [float(i) for i in out_mulliken_charges]
            out_dipole_moment = float(out_dipole_moment)
            out_dipole_moments = [float(i) for i in out_dipole_moments]
            continue       
        #VIBRATIONAL FREQUENCIES
        if search==1:
          if re.search("Frequencies", line): #V1
            if out_vibrational_frequencies == missing:
              out_vibrational_frequencies = []
            out_vibrational_frequencies += [float(i) for i in line.split()[2:]]
            continue
          if re.search("Kelvin.  Pressure", line): #V2/V3
            out_temperature = float(line.split()[1])
            out_pressure = float(line.split()[4])
            search+=1
            continue
        #THERMOCHEMISTRY
        if search==2:
          if re.search("Rotational symmetry number", line): #T1
            out_rotational_symmetry_number = float(line.split()[3])
            continue
          if re.search("Zero-point correction=", line): #T2
            out_zero_point_correction = float(line.split()[2])
            continue
          if re.search("Thermal correction to Energy", line): #T3
            out_energy_thermal_correction = float(line.split()[4])
            continue
          if re.search("Thermal correction to Enthalpy", line): #T4
            out_enthalpy_thermal_correction = float(line.split()[4])
            continue
          if re.search("Thermal correction to Gibbs Free Energy", line): #T5
            out_gibbs_free_energy_thermal_correction = float(line.split()[6])
            continue
          if re.search("Sum of electronic and zero-point Energies", line): #T6
            out_zero_point_energy = float(line.split()[6])
            continue
          if re.search("Sum of electronic and thermal Energies", line): #T7
            out_internal_energy = float(line.split()[6])
            continue
          if re.search("Sum of electronic and thermal Enthalpies", line): #T8
            out_enthalpy_energy = float(line.split()[6])
            continue
          if re.search("Sum of electronic and thermal Free Energies", line): #T9
            out_gibbs_free_energy = float(line.split()[7])
            search += 1
            continue
        #ENTROPY
        if search==3:
          if re.search("Total", line): #E1
            out_entropy = float(line.split()[3])
            search += 1 
      #SAVE
      clusters_df = df_add_iter(clusters_df, "log", "time", [str(cluster_id)], [out_time]) #TIME
      clusters_df = df_add_iter(clusters_df, "log", "charge", [str(cluster_id)], [out_charge]) #I1
      clusters_df = df_add_iter(clusters_df, "log", "multiplicity", [str(cluster_id)], [out_multiplicity]) #I2
      clusters_df = df_add_iter(clusters_df, "log", "NAtoms", [str(cluster_id)], [out_NAtoms]) #I3
      clusters_df = df_add_iter(clusters_df, "log", "rotational_constants", [str(cluster_id)], [out_rotational_constants]) #O1
      clusters_df = df_add_iter(clusters_df, "log", "rotational_constant", [str(cluster_id)], [out_rotational_constant]) #O2
      clusters_df = df_add_iter(clusters_df, "log", "electronic_energy", [str(cluster_id)], [out_electronic_energy]) #O3
      clusters_df = df_add_iter(clusters_df, "log", "mulliken_charges", [str(cluster_id)], [out_mulliken_charges]) #O4
      clusters_df = df_add_iter(clusters_df, "log", "dipole_moment", [str(cluster_id)], [out_dipole_moment]) #O5
      clusters_df = df_add_iter(clusters_df, "log", "dipole_moments", [str(cluster_id)], [out_dipole_moments]) #O6
      clusters_df = df_add_iter(clusters_df, "log", "polarizability", [str(cluster_id)], [out_polarizability]) #O7
      clusters_df = df_add_iter(clusters_df, "log", "vibrational_frequencies", [str(cluster_id)], [out_vibrational_frequencies]) #V1
      clusters_df = df_add_iter(clusters_df, "log", "temperature", [str(cluster_id)], [out_temperature]) #V2
      clusters_df = df_add_iter(clusters_df, "log", "pressure", [str(cluster_id)], [out_pressure]) #V3
      clusters_df = df_add_iter(clusters_df, "log", "rotational_symmetry_number", [str(cluster_id)], [out_rotational_symmetry_number]) #T1
      clusters_df = df_add_iter(clusters_df, "log", "zero_point_correction", [str(cluster_id)], [out_zero_point_correction]) #T2
      clusters_df = df_add_iter(clusters_df, "log", "energy_thermal_correction", [str(cluster_id)], [out_energy_thermal_correction]) #T3
      clusters_df = df_add_iter(clusters_df, "log", "enthalpy_thermal_correction", [str(cluster_id)], [out_enthalpy_thermal_correction]) #T4
      clusters_df = df_add_iter(clusters_df, "log", "gibbs_free_energy_thermal_correction", [str(cluster_id)], [out_gibbs_free_energy_thermal_correction]) #T5
      clusters_df = df_add_iter(clusters_df, "log", "zero_point_energy", [str(cluster_id)], [out_zero_point_energy]) #T6
      clusters_df = df_add_iter(clusters_df, "log", "internal_energy", [str(cluster_id)], [out_internal_energy]) #T7
      clusters_df = df_add_iter(clusters_df, "log", "enthalpy_energy", [str(cluster_id)], [out_enthalpy_energy]) #T8
      clusters_df = df_add_iter(clusters_df, "log", "gibbs_free_energy", [str(cluster_id)], [out_gibbs_free_energy]) #T9
      clusters_df = df_add_iter(clusters_df, "log", "entropy", [str(cluster_id)], [out_entropy]) #E1
    file.close()

  ###############
  ### XYZ #######
  ###############
  if os.path.exists(file_i_XYZ):
    out = read(file_i_XYZ)
    clusters_df = df_add_iter(clusters_df, "xyz", "structure", [str(cluster_id)], [out])

  ###############
  ### ORCA ######
  ###############
  if os.path.exists(file_i_ORCA):
    file = open(file_i_ORCA, "r")
    out = []
    for line in file:
      if re.search("FINAL SINGLE POINT ENERGY", line):
        out += line.split()[4:]
    file.close()
    out = [float(i) for i in out]
    clusters_df = df_add_iter(clusters_df, "out", "electronic_energy", [str(cluster_id)], [out])

## EXTRACT
def dash(input_array):
  output_array = [input_array]
  for element in range(len(input_array)):
    if input_array[element] == "-":
      output_array = []
      partbefore = input_array[0:element-1]
      partafter = input_array[element+2:]
      output_array_1 = []
      for thenumber in range(int(input_array[element-1]),int(input_array[element+1])+1):
        output_array_1.append(partbefore+[str(thenumber)]+partafter)
      for i in output_array_1:
        for j in dash(i): 
          output_array.append(j)
      break
  return output_array

def comma(input_array):
  output_array = []
  output_string = ""
  bracket_val = 0
  for element in range(len(input_array)):
    if input_array[element] == "(":
      bracket_val += 1
    if input_array[element] == ")":
      bracket_val -= 1
    if input_array[element] == ",":
      if bracket_val == 0:
        output_array.append(output_string)
        output_string = ""
        continue 
    output_string += input_array[element]
  output_array.append(output_string)
  return output_array

def comma2(input_array):
  output_array = [input_array]
  for element in range(len(input_array)):
    if input_array[element] == "(":
      elementL = element
    if input_array[element] == ")":
      output_array = []
      elementR = element
      partbefore = input_array[0:elementL]
      partafter = input_array[elementR+1:]
      thenumbers = listToString(input_array[elementL+1:elementR],"").split(",")
      for thenumber in thenumbers:
        for j in comma2(partbefore+[str(thenumber)]+partafter):
          output_array.append(j)
      break
  return output_array

def unique(list1):
    # initialize a null list
    unique_list = []
    # traverse for all elements
    for x in list1:
        # check if exists in unique_list or not
        if x not in unique_list:
            unique_list.append(x)
    # return list
    return unique_list

if Qextract > 0:
  #print(Pextract)
  Pextract_comma = []
  for extract_i in Pextract:
    comma_separated = comma(extract_i)
    for separated_i in range(len(comma_separated)):
      Pextract_comma.append(comma_separated[separated_i])
  #print(Pextract_comma)    
  Pextract_dash = []
  for extract_i in Pextract_comma:
    separated = seperate_string_number(extract_i)
    dash_separated = dash(separated)
    for separated_i in range(len(dash_separated)):
      Pextract_dash.append(dash_separated[separated_i])
  #print([listToString(i,"") for i in Pextract_dash])
  Pextract_comma2 = []
  for extract_i in Pextract_dash:
    comma2_separated = comma2(extract_i)
    for separated_i in range(len(comma2_separated)):
      Pextract_comma2.append(comma2_separated[separated_i])
  #print(Pextract_comma2)
  Pextract_sorted = []
  for extract_i in Pextract_comma2:
    if len(extract_i) > 1:
      array_sorted = sorted([extract_i[i:i + 2] for i in range(0, len(extract_i), 2)],key=lambda x: x[1])
      Pextract_sorted.append([item for sublist in array_sorted for item in sublist])
    else:
      Pextract_sorted.append(extract_i)
      Qclustername = 0
  #print(Pextract_sorted)
  Pextract_final = []
  for extract_i in Pextract_sorted:
    corrected = zeros(extract_i)
    if len(corrected) > 0:
      Pextract_final.append(corrected)
  Pextract_ultimate = unique(Pextract_final)
  #print(Pextract_ultimate)
  newclusters_df = pd.DataFrame()
  for extract_i in Pextract_ultimate:
    if Qclustername == 0:
      extracted_df = clusters_df[clusters_df["info"]["file_basename"].values == extract_i]
    else:
      extracted_df = clusters_df[clusters_df["info"]["cluster_type"].values == extract_i]
    if len(extracted_df) > 0:
      if len(newclusters_df) == 0:
        newclusters_df = extracted_df
      else:
        #print(newclusters_df)
        newclusters_df = newclusters_df.append(extracted_df)
        #print(newclusters_df)
  clusters_df = newclusters_df

## SAVE OUTPUT.pkl ##
if Qout > 0:
  clusters_df.to_pickle(output_pkl)
  if Qout == 1:
    if len(clusters_df) == 0:
      print(clusters_df)
      print("No files in the input!")
    else:
      print(clusters_df.iloc[0])
      print("Number of files in "+output_pkl+": "+str(len(clusters_df)))

## EXTRACT DATA ##
output = []
for i in Pout:
  #XYZ
  if i == "-xyz":
    for ind in clusters_df.index:
      write(clusters_df["info"]["file_basename"][ind]+".xyz",clusters_df["xyz"]["structure"][ind])
    continue
  #Rg
  if i == "-rg":
    rg = []
    for aseCL in clusters_df["xyz"]["structure"]:
      rg.append((np.sum(np.sum((aseCL.positions-np.tile(aseCL.get_center_of_mass().transpose(),(len(aseCL.positions),1)))**2,axis=-1)*aseCL.get_masses())/np.sum(aseCL.get_masses()))**0.5)
    output.append(rg)
    continue 
  #INFO
  if i == "-b": 
    output.append(clusters_df["info"]["file_basename"].values)
    continue
  if i == "-nOUT":
    output.append(clusters_df["info"]["file_basename"].values+".out")
    continue
  if i == "-nLOG":
    output.append(clusters_df["info"]["file_basename"].values+".log")
    continue
  if i == "-nXYZ":
    output.append(clusters_df["info"]["file_basename"].values+".xyz")
    continue
  if i == "-pOUT":
    output.append(clusters_df["info"]["folder_path"].values+clusters_df["info"]["file_basename"].values+".out")
    continue
  if i == "-pLOG":
    output.append(clusters_df["info"]["folder_path"].values+clusters_df["info"]["file_basename"].values+".log")
    continue
  if i == "-pXYZ":
    output.append(clusters_df["info"]["folder_path"].values+clusters_df["info"]["file_basename"].values+".xyz")
    continue
  if i == "-ePKL":
    if Qout > 0 or len(input_pkl) == 1:
      if Qout > 0:
        output.append(os.path.abspath(output_pkl)+"/:EXTRACT:/"+clusters_df["info"]["file_basename"].values)
      else:
        output.append(os.path.abspath(input_pkl[0])+"/:EXTRACT:/"+clusters_df["info"]["file_basename"].values)
    else:
      print("Sorry but it seems to me that you are taking this from more file or no file is formed (yet)")
      exit()
    continue
  if i == "-el":
    output.append(clusters_df["log"]["electronic_energy"].values)
    continue
  if i == "-elout":
    output.append(clusters_df["out"]["electronic_energy"].values)
    continue
  if i == "-elc":
    output.append(clusters_df["out"]["electronic_energy"].values-clusters_df["log"]["electronic_energy"].values)
    continue
  if i == "-zpec": 
    output.append(clusters_df["log"]["zero_point_correction"].values)
    continue
  if i == "-zpe":
    output.append(clusters_df["log"]["electronic_energy"].values+clusters_df["log"]["zero_point_correction"].values)
    continue
  if i == "-zpeout":
    output.append(clusters_df["out"]["electronic_energy"].values+clusters_df["log"]["zero_point_correction"].values)
    continue
  if i == "-g":
    output.append(clusters_df["log"]["gibbs_free_energy"].values)
    continue
  if i == "-h":
    output.append(clusters_df["log"]["out_enthalpy_energy"].values)
    continue
  if i == "-lf": 
    output.append([value[0] for value in clusters_df["log"]["vibrational_frequencies"].values])
    continue
  if i == "-f":
    output.append(clusters_df["log"]["vibrational_frequencies"].values)
    continue
  if i == "-rot":
    output.append(clusters_df["log"]["rotational_constant"].values)
    continue
  if i == "-rots":
    output.append(clusters_df["log"]["rotational_constants"].values)
    continue
  if i == "-mult":
    output.append(clusters_df["log"]["multiplicity"].values)
    continue
  if i == "-char":
    output.append(clusters_df["log"]["charge"].values)
    continue
  if i == "-mull":
    output.append(clusters_df["log"]["mulliken_charges"].values)
    continue
  if i == "-dip":
    output.append(clusters_df["log"]["dipole_moment"].values)
    continue
  if i == "-dips":
    output.append(clusters_df["log"]["dipole_moments"].values)
    continue
  if i == "-pol":
    output.append(clusters_df["log"]["polarizability"].values)
    continue
  if i == "-templog":
    output.append(clusters_df["log"]["temperature"].values)
    continue
  if i == "-preslog":
    output.append(clusters_df["log"]["pressure"].values)
    continue
  if i == "-rsn":
    output.append(clusters_df["log"]["rotational_symmetry_number"].values)
    continue
  if i == "-t":
    output.append(clusters_df["log"]["time"].values)
    continue
  output.append(["UNKNOWN_ARGUMENT"]*len(clusters_df))

## PRINT DATA ##
if not len(output) == 0:
  f = open(".help.txt", "w")
  [f.write(" ".join(map(str,row))+"\n") for row in list(zip(*output))]
  f.close()
  #TODO can you make this working using only python?
  os.system("cat .help.txt | column -t")
  os.remove(".help.txt")
