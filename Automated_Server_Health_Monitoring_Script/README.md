# Automated Server Health Monitoring Script

## 📌 Project Overview
This project is a **Bash script** that monitors system health by checking **CPU usage, memory usage, disk space, and running processes**. If any metric exceeds the defined thresholds, the script logs the event and sends an alert.

## 🚀 Features
✅ Monitors CPU, RAM, Disk, and Process count
✅ Logs system status to a file
✅ Sends alerts if usage exceeds defined thresholds
✅ Can be automated using a **cronjob**

## 🛠 Requirements
- A **Linux system** (Ubuntu, Debian, CentOS, etc.)
- Basic understanding of **Bash scripting**
- Installed tools: `top`, `free`, `df`, `ps`, `mail` (optional for email alerts)

## 📥 Installation & Setup

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/yourusername/server-health-monitor.git
cd server-health-monitor
```

### 2️⃣ Create the Script File
Create a file named `monitor.sh` and paste the following code:

```bash
#!/bin/bash

# Define threshold values
CPU_THRESHOLD=80
RAM_THRESHOLD=70
DISK_THRESHOLD=90
PROC_THRESHOLD=200

# Get system metrics
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
RAM_USAGE=$(free | awk '/Mem/{printf("%.2f"), $3/$2 * 100}')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
PROC_COUNT=$(ps aux | wc -l)

# Log file location
LOG_FILE="/var/log/sys_monitor.log"

# Function to log and alert
alert() {
    echo "$(date): $1" | tee -a $LOG_FILE
    echo "ALERT: $1" | mail -s "Server Alert" your_email@example.com
}

# Check if thresholds are exceeded
[ $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc) -eq 1 ] && alert "High CPU Usage: $CPU_USAGE%"
[ $(echo "$RAM_USAGE > $RAM_THRESHOLD" | bc) -eq 1 ] && alert "High RAM Usage: $RAM_USAGE%"
[ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ] && alert "High Disk Usage: $DISK_USAGE%"
[ "$PROC_COUNT" -gt "$PROC_THRESHOLD" ] && alert "Too Many Processes: $PROC_COUNT"

# Log system status
echo "$(date) | CPU: $CPU_USAGE% | RAM: $RAM_USAGE% | Disk: $DISK_USAGE% | Processes: $PROC_COUNT" >> $LOG_FILE
```

### 3️⃣ Make the Script Executable
chmod +x monitor.sh
then run ./monitor.sh

## ⏳ Automate the Script with Cronjob
To run the script every 5 minutes, add a cronjob:
crontab -e
*/5 * * * * /path/to/monitor.sh

Thank You..
Private blaq


