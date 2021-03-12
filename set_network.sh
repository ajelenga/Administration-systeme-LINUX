#!/bin/bash
. functions
. param


if [ ! $# -eq 1 ]; then
	echo "Usage set_network non"
	exit
fi

val=$( exist $MACHINE_LISTE $1 )
ip=$( grep $1 $MACHINE_LISTE | cut -d ' ' -f 1 )
if [ $val -eq 0 ]; then
	echo "Le $MACHINE_LISTE existe "
	echo $ip
	echo "modification de l'adresse ip"
	ifconfig $IF $ip
	echo "voir resultat avec la cmd ifconfig"
fi

valeur=$( exist /etc/sysconfig/network-scripts/ifcfg-enp0s3 BOOTPROTO )
echo $valeur
if [ $valeur -eq 0 ]; then
	replace_line /etc/sysconfig/network-scripts/ifcfg-enp0s3 BOOTPROTO BOOTPROTO=none
else
	add_line /etc/sysconfig/network-scripts/ifcfg-enp0s3 BOOTPROTO=none
fi

valeur1=$( exist /etc/sysconfig/network-scripts/ifcfg-enp0s3 IPADDR )
echo $valeur1
val=$( exist $MACHINE_LISTE $1 )
ip=$( grep $1 $MACHINE_LISTE | cut -d ' ' -f 1 )
echo $ip
if [ $valeur1 -eq 0 ]; then
	replace_line /etc/sysconfig/network-scripts/ifcfg-enp0s3 IPADDR IPADDR=$ip
else
	add_line /etc/sysconfig/network-scripts/ifcfg-enp0s3 IPADDR=$ip
fi

valeur2=$( exist /etc/sysconfig/network-scripts/ifcfg-enp0s3 GATEWAY )
echo $valeur2
if [ $valeur2 -eq 0 ]; then
	replace_line /etc/sysconfig/network-scripts/ifcfg-enp0s3 GATEWAY GATEWAY=192.168.56.100
else
	add_line /etc/sysconfig/network-scripts/ifcfg-enp0s3 GATEWAY=192.168.56.100
fi

valeur3=$( exist /etc/sysconfig/network-scripts/ifcfg-enp0s3 PREFIX )
echo $valeur3
if [ $valeur3 -eq 0 ]; then
	replace_line /etc/sysconfig/network-scripts/ifcfg-enp0s3 PREFIX PREFIX=24
else
	add_line /etc/sysconfig/network-scripts/ifcfg-enp0s3 PREFIX=24
fi

echo "etape4"
IFS=$'\n'       # make newlines the only separator
    for a in $( cat $MACHINE_LISTE )    
    do
	valeur4=$( exist /etc/hosts $a )
	echo $valeur4

        if [ $valeur4 -eq 1 ]; then
	
		add_line /etc/hosts $a	
	fi
    done   

echo "etape 5"

IFS=$'\n'       # make newlines the only separator
    for a in $( cat /etc/hostname )
    do
        echo "ancien nom: $a"
    done 

    echo $1 > /etc/hostname
    for a in $( cat /etc/hostname ) 
        do
        echo "nouveau nom: $a"
    done












