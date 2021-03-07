#!/bin/bash
. functions
. param

#on desactive

systemctl disable firewalld.service
systemctl stop firewalld.service
systemctl disable iptables.service
systemctl stop iptables.service

host=$( hostname -a )

if [ $host == $SERVEUR_NFS ]; then
        echo "machine serveur"
        #Activer et démarrer nfs-server
        systemctl enable nfs-server
        systemctl start nfs-server

        IFS=$'\n'       # make newlines the only separator
        for a in $( cat $MACHINE_LISTE)
        do
                 # name nom de la machine
                name=$( grep $a $MACHINE_LISTE | cut -d ' ' -f 2 )


                echo "" > "/etc/exports"
                add_line "/etc/exports" "$EXPORT_APP $name($EXPORT_APP_OPT)"
                add_line "/etc/exports" "$EXPORT_HOME $name($EXPORT_HOME_OPT)"
        done

        #creation des dossiers en tenant comptes qu'il existe ou pas
        mkdir -p $EXPORT_HOME
        mkdir -p $EXPORT_APP

        exportfs -a
        exportfs -f

else
        serveur:/export/home     /home/serveur   nfs     hard,rw   0 0
        serveur:/export/opt      /opt            nfs     soft,ro   0 0

fi

