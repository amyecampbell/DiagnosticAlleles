#!/bin/sh
# Amy Campbell
# Chilean clade markers 

source /home/campbela12/miniforge3/bin/activate WhatsGnuEnv

StaphDB=/scr1/users/campbela12/downloadedDBs/Sau_Ortholog_10350.pickle
WhatsGNUoutput=/scr1/users/campbela12/ST105/WhatsGNUNovGenomes/
for file in /scr1/users/campbela12/ST105/ST105Tree_11_2023/FAAs/*; do
	Base=$(basename $file)
	IDstring=${Base/".faa"/""}

	WhatsGNU_main.py -d $StaphDB -dm ortholog -o $WhatsGNUoutput$IDstring $file
done


#WhatsGNU_main.py -d $StaphDB -dm ortholog -o $output176_GCA_003336555 $input176_GCA_003336555
