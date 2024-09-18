#!/bin/bash

# Log file to store system health checks
log_file="system_health.log"

# Get CPU usage as a percentage
cpu_usage=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}')
cpu_usage_int=${cpu_usage%.*}  # Convert to integer

# Get total and available memory from `free` command
total_mem=$( free | grep Mem | awk '{print $2}')
used_mem=$( free | grep Mem | awk '{print $3}')
available_mem=$((total_mem - used_mem))
available_mem_percentage=$((available_mem * 100 / total_mem))

# Get the current date and time
current_time=$(date +"%Y-%m-%d %H:%M:%S")

# Log the current CPU and memory status
echo "[$current_time] CPU Usage: $cpu_usage% | Available Memory: $available_mem_percentage%" >> "$log_file"

# Check if CPU usage is above 80% or available memory is below 20%
if [ "$cpu_usage_int" -gt 80 ]; then
    echo "[$current_time] ALERT: CPU usage is above 80%!" >> "$log_file"
fi

if [ "$available_mem_percentage" -lt 20 ]; then
    echo "[$current_time] ALERT: Available memory is below 20%!" >> "$log_file"
fi

echo "System health check completed and logged to $log_file."
