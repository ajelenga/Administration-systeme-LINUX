#!/bin/bash
. functions
. param



if [ ! $# -eq 1 ]; then
	echo "Usage set_network non"
	exit
fi

#execution des scripts 

sudo ./set_network.sh $1

reset

ping $1
