#!/bin/bash

# Check for exactly one argument
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one log file as argument."
    exit 1
fi

LOGFILE="$1"

# Check if file exists
if [ ! -e "$LOGFILE" ]; then
    echo "Error: Log file does not exist."
    exit 1
fi

# Check if file is readable
if [ ! -r "$LOGFILE" ]; then
    echo "Error: Log file is not readable."
    exit 1
fi

# Count total entries
total_entries=$(wc -l < "$LOGFILE")

# Count log levels
info_count=$(grep -c " INFO " "$LOGFILE")
warning_count=$(grep -c " WARNING " "$LOGFILE")
error_count=$(grep -c " ERROR " "$LOGFILE")

# Get most recent ERROR
recent_error=$(grep " ERROR " "$LOGFILE" | tail -n 1)

# Report file
date_stamp=$(date +"%Y-%m-%d")
report_file="logsummary_${date_stamp}.txt"

# Display output
echo "Log File Analysis: $LOGFILE"
echo "Total entries: $total_entries"
echo "INFO entries: $info_count"
echo "WARNING entries: $warning_count"
echo "ERROR entries: $error_count"
echo "Most recent ERROR:"
echo "$recent_error"

# Write report
{
    echo "Log Summary Report"
    echo "Date: $date_stamp"
    echo "Log file: $LOGFILE"
    echo "-----------------------"
    echo "Total entries: $total_entries"
    echo "INFO entries: $info_count"
    echo "WARNING entries: $warning_count"
    echo "ERROR entries: $error_count"
    echo "Most recent ERROR:"
    echo "$recent_error"
} > "$report_file"

echo "Report generated: $report_file"
