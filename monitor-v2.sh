#!/bin/bash

echo "========================"
echo " DEVOPS MONITOR V2 "
echo "========================"

DATE=$(date)

echo ""
echo "📅 DATE:"
echo $DATE

echo ""
echo "📌 HOSTNAME:"
hostname

echo ""
echo "📌 CPU LOAD:"
LOAD=$(uptime | awk -F'load average:' '{ print $2 }')
echo $LOAD

echo ""
echo "📌 MEMORY:"
MEM_AVAILABLE=$(free -m | awk 'NR==2 {print $7}')

echo "Available Memory: ${MEM_AVAILABLE}MB"

if [ $MEM_AVAILABLE -lt 500 ]
then
    echo "[WARNING] Low memory!"
else
    echo "[OK] Memory is fine"
fi

echo ""
echo "📌 DISK:"

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "Disk usage: ${DISK_USAGE}%"

if [ $DISK_USAGE -gt 85 ]
then
    echo "[CRITICAL] Disk almost full!"
elif [ $DISK_USAGE -gt 70 ]
then
    echo "[WARNING] Disk usage high"
else
    echo "[OK] Disk is fine"
fi

echo ""
echo "📌 TOP CPU PROCESSES:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -6

echo ""
echo "========================"
echo " END REPORT "
echo "========================"
