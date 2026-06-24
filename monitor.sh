#!/bin/bash

echo "========================"
echo " DEVOPS SYSTEM MONITOR "
echo "========================"

echo ""
echo "📌 HOSTNAME:"
hostname

echo ""
echo "📌 UPTIME:"
uptime

echo ""
echo "📌 CPU LOAD:"
uptime | awk -F'load average:' '{ print $2 }'

echo ""
echo "📌 MEMORY:"
free -h

echo ""
echo "📌 DISK:"
df -h /

echo ""
echo "📌 TOP PROCESSES:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -10 | grep -v "monitor.sh"

echo ""
echo "========================"
echo " END REPORT "
echo "========================"
