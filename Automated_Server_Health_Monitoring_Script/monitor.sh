#!/bin/bash

#Define threshold values

cpu_threshold=80
ram_threshold=70
disk_threshold=90
proc_threshold=200


#Get ystem metrics

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk  '{print $2 + $4}')
ram_usage=$(free | awk '/Mem/{printf("%.2f"), $3/$2 * 100}')
disk_usage=$(df -h  / | awk 'NR==2 {print $5}' | sed 's/%//')
proc_count=$(ps aux | wc -l)

#Log file
log_file="/var/log/sys_monitor.log"

#Function to  log and alert

alert() {
        echo "$(date)": | tee -a $log_file
        echo "ALERT: $1" | mail -s "Server Alert" adediamichael2019@gmail.com
}


# check thresholds

[ $(echo "$cpu_usage > $cpu_threshold" | bc) -eq 1 ] && alert "High CPU Usage: $cpu_usage%"
[ $(echo "$ram_usage > $ram_threshold" | bc) -eq 1 ] && alert "High Ram Usage: $ram_usage%"
[ "$disk_usage" -gt "$disk_threshold" ] && alert "High Disk usage: $disk_usage%"
[ "$proc_count" -gt "$proc_threshold" ] && alert "High Proc count: $proc_count%"

#Log system status

echo "$(date) | CPU: $cpu_usage% | Ram: $ram_usage | DiskL $disk_usage% | Processes: $proc_count" >> sudo $log_file
