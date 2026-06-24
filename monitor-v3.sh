#!/bin/bash

# =========================
# CONFIG
# =========================
LOG_FILE="$HOME/projects/monitoring-lab/monitoring-v3.log"
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# =========================
# FUNCTION LOG
# =========================
log() {
    echo "[$DATE] $1" | tee -a $LOG_FILE
}

# =========================
# HEADER
# =========================
echo "========================"
echo " DEVOPS MONITOR V3 "
echo "========================"

log "Monitoring started"

# =========================
# CPU
# =========================
CPU_LOAD=$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1 | sed 's/ //g')

log "CPU LOAD (1min): $CPU_LOAD"

CPU_INT=$(echo $CPU_LOAD | cut -d'.' -f1)

if [ "$CPU_INT" -ge 2 ]; then
    log "[CRITICAL] CPU load high"
elif [ "$CPU_INT" -ge 1 ]; then
    log "[WARNING] CPU load medium"
else
    log "[OK] CPU normal"
fi

# =========================
# MEMORY
# =========================
MEM_AVAILABLE=$(free -m | awk 'NR==2 {print $7}')

log "MEM AVAILABLE: ${MEM_AVAILABLE}MB"

if [ "$MEM_AVAILABLE" -lt 500 ]; then
    log "[WARNING] Low memory"
else
    log "[OK] Memory OK"
fi

# =========================
# DISK
# =========================
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

log "DISK USAGE: ${DISK_USAGE}%"

if [ "$DISK_USAGE" -ge 85 ]; then
    log "[CRITICAL] Disk full risk"
elif [ "$DISK_USAGE" -ge 70 ]; then
    log "[WARNING] Disk usage high"
else
    log "[OK] Disk OK"
fi

# =========================
# TOP PROCESSES
# =========================
log "Top processes snapshot"

ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -6 >> $LOG_FILE

log "Monitoring finished"

echo ""
echo "DONE"
