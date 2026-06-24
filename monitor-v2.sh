#!/bin/bash

LOG_FILE="$HOME/monitoring.log"
DATE=$(date "+%Y-%m-%d %H:%M:%S")

echo "========================"
echo " DEVOPS MONITOR V2 "
echo "========================"

echo "[$DATE] Monitoring start" >> $LOG_FILE

# --------------------
# CPU LOAD
# --------------------
CPU_LOAD=$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1 | sed 's/ //g')

echo ""
echo "📌 CPU LOAD (1min): $CPU_LOAD"

echo "[$DATE] CPU LOAD: $CPU_LOAD" >> $LOG_FILE

# --------------------
# MEMORY
# --------------------
MEM_AVAILABLE=$(free -m | awk 'NR==2 {print $7}')

echo ""
echo "📌 MEMORY AVAILABLE: ${MEM_AVAILABLE}MB"

echo "[$DATE] MEMORY: ${MEM_AVAILABLE}MB" >> $LOG_FILE

if [ $MEM_AVAILABLE -lt 500 ]
then
    echo "[WARNING] Low memory!"
    echo "[$DATE] WARNING: LOW MEMORY" >> $LOG_FILE
else
    echo "[OK] Memory OK"
fi

# --------------------
# DISK
# --------------------
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

echo ""
echo "📌 DISK USAGE: ${DISK_USAGE}%"

echo "[$DATE] DISK: ${DISK_USAGE}%" >> $LOG_FILE

if [ $DISK_USAGE -gt 85 ]
then
    echo "[CRITICAL] Disk almost full!"
    echo "[$DATE] CRITICAL: DISK FULL" >> $LOG_FILE

elif [ $DISK_USAGE -gt 70 ]
then
    echo "[WARNING] Disk usage high"
    echo "[$DATE] WARNING: DISK HIGH" >> $LOG_FILE

else
    echo "[OK] Disk OK"
fi

# --------------------
# PROCESS TOP
# --------------------
echo ""
echo "📌 TOP CPU PROCESSES:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -6

echo "[$DATE] Monitoring end" >> $LOG_FILE

echo ""
echo "========================"
echo " END REPORT "
echo "========================"
