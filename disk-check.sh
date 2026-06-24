#!/bin/bash

DISK_USAGE=$(df -h | awk 'NR==3 {print $5}' | sed 's/%//')


echo "Utilisation disque : $DISK_USAGE%"

if [ $DISK_USAGE -gt 80 ]
then 
	echo "[WARNING] Disque dur superieur à 80%"
else
	echo "[OK] Disque normal"
fi

