#!/bin/bash

# 📌 Set log file path
LOG_FILE="/var/log/network_monitor.log"

# 🌐 Check Internet Connectivity (Google DNS)
if ping -c 3 8.8.8.8 &> /dev/null; then
    echo "$(date): ✅ Internet is UP" | tee -a "$LOG_FILE"
else
    echo "$(date): ❌ Internet is DOWN! Restarting network..." | tee -a "$LOG_FILE"
    systemctl restart networking  # Restart network service
fi

# 🏢 Check Internal Server (Replace with Dreamline’s actual server IP)
SERVER_IP="192.168.1.100"

if ping -c 3 "$SERVER_IP" &> /dev/null; then
    echo "$(date): ✅ Server at $SERVER_IP is UP" | tee -a "$LOG_FILE"
else
    echo "$(date): ❌ Server at $SERVER_IP is DOWN! Restarting service..." | tee -a "$LOG_FILE"
    systemctl restart apache2  # Restart Apache server (Change for your service)
fi

