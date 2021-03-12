#!/bin/bash
. functions
. param


#code fait mais pas encore testé
host=$( hostname )

if [ $host == $SERVEUR_NFS ]; then
	#côté serveur
	systemctl stop firewalld.service
        echo "activation et demarrage"
	systemctl enable ypserv
        systemctl start ypserv
        nisdomainname $DOMAIN_NIS
        line="nisdomainname=$DOMAIN_NIS"
        valeur=$( exist /etc/sysconfig/network $line )
	if [ $valeur -eq 0 ]; then
		echo "la ligne : $line a deja ete ajouter "
	else
		add_line /etc/sysconfig/network $line
	fi
	# pas reussi  faire 
        cd /var/yp
	make   
	echo "execution 2"
	sudo ./usr/lib64/yp/ypinit -m <<< FIN
	reset
	 ls /var/yp/$DOMAIN_NIS
else
	#côté client
	nisdomainname $DOMAINE_NIS
	line="nisdomainname=$DOMAIN_NIS"
        valeur=$( exist /etc/sysconfig/network $line )
	if [ $valeur -eq 0 ]; then
		echo "la ligne : $line a deja ete ajouter "
	else
		add_line /etc/sysconfig/network $line
	fi
	#lecture non effectuer 
	systemctl enable ypbind
	systemctl start ypbind
	echo "demaragge efectuer"	
	line="passwd: files nis"
	valeur=$( exist /etc/nsswitch.conf  $line )
	if [ $valeur -eq 0 ]; then
		echo "la ligne : $line a deja ete ajouter "
	else
		add_line /etc/sysconfig/nsswitch.conf $line
	fi
	
	
	line="group: files nis"
	valeur=$( exist /etc/nsswitch.conf  $line )
	if [ $valeur -eq 0 ]; then
		echo "la ligne : $line a deja ete ajouter "
	else
		add_line /etc/sysconfig/nsswitch.conf $line
	fi
	
	line="shadow: files nis"
	valeur=$( exist /etc/nsswitch.conf  $line )
	if [ $valeur -eq 0 ]; then
		echo "la ligne : $line a deja ete ajouter "
	else
		add_line /etc/sysconfig/nsswitch.conf $line
	fi
	
	
fi

