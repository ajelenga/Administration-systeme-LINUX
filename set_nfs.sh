#!/bin/bash
. functions
. param

#ma_machine=hostname -a 

#if [ $ma_machine -eq "serveur" ]; then 
	#echo "machine serveur"
#	systemctl enable nfs-server
#	systemctl start nfs-server
#	systemctl stop firewalld.service
	cheminopt=/export/opt
	cheminhome=/export/home
	#mkdir -p $cheminhome
	#mkdir -p $cheminopt 
	#mise a jour 

		IFS=$'\n'
		#echo $( cat $MACHINE_LISTE )
		echo "------------------------------"
		nom=$( cut -d ' ' -f2 $MACHINE_LISTE  )
        #echo $nom
        for a in $nom
    	do
        	echo "$cheminopt $a()"
    	done 
    	
#else
#	echo "machine non serveur"
#fi
