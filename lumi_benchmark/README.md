Databases of molecular cluster systems (Clusteromics I-III) calculated at different levels of theory. Each calculated single-point electronic energies (or heat of formations for semi-empirical methods) is together with the xyz structure saved in a pickled file.

In order to use any database, you have to first setup your python environment:
1) Modify the python version (>3.8.0 and <4.0.0) you use in the following file:
  >> vim install.sh
2) setup the environment:
  >> sh install.sh
3) It will add one line to your ~/.bashrc file, therefore source it
  >> source ~/.bashrc
4) and activate the environment:
  >> JKpython
5) now you should be able to use the JKQCpickle.py file
  >> python JKQCpickle.py -help

** USING JKQCpickle.py **
for purpose of the paper where we used these databases, you need only the function that prints out the cluster names and their energies:
  >> python JKQCpickle.py DATABASE.PKL -b -el
or generate all xyz files:
  >> python JKQCpickle.py DATABASE.PKL -xyz

The JKQCpickle.py is still under development. However, as it already contains many functionalities you can read more details about this program on:
   https://jkcspy.readthedocs.io/en/latest/JKQC.html
(This website is also under development)

** NOT USING JKQCpickle.py **
After activating the correct python environment (e.g., with JKpython), use python to analyse/use the data:
$USER/: python
> import pandas as pd
> clusters_dataframe = pd.read_pickle("DATABASE.PKL")
