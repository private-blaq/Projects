#!/bin/bash

#Define threshold values

cpu_threshold=80
ram_threshold=70
disk_threshold=90
proc_threshold=200


#Get ystem metrics

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
ram_usage=$(free | awk '/Mem/{printf("%.2f), $3/$2 * 100})
disk_usage=$(df -h  / | awk 'NR==2 {print $5}' | sed 's/%//')
proc_count=$(ps aux | wc -l)

#Log file
log_file="/var/log/sys_monitor.log"

#Function to  log and alert

alert() {
        echo "$(date): | tee -a $log_file
        echo "ALERT: $1" | mail -s "Server Alert" adediamichael2019@gmail.com
}


