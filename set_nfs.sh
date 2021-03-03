#!/bin/bash
. functions
. param

ma_machine=hostname -a 

if [ $ma_machine eq "serveur" ]; then 
	echo "machine serveur"
	systemctl enable nfs-server
	systemctl start nfs-server
	systemctl stop firewalld.service
	mkdir -p /export/home 
	mkdir -p /export/opt 
	


else
	echo "machine non serveur"
fi


