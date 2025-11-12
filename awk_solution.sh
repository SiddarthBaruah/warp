#!/bin/bash
# Awk solution to find the security code of the longest successful Mars mission
# This command can be shared as a Warp Shared Block

awk -F'|' '
BEGIN {
    max_duration = 0
    security_code = ""
}
# Skip commented lines and system/config lines
/^#/ || /^SYSTEM:/ || /^CONFIG:/ || /^CHECKSUM:/ { next }
# Process lines with 8 fields
NF == 8 {
    # Trim whitespace from fields
    gsub(/^[ \t]+|[ \t]+$/, "", $1)
    gsub(/^[ \t]+|[ \t]+$/, "", $2)
    gsub(/^[ \t]+|[ \t]+$/, "", $3)
    gsub(/^[ \t]+|[ \t]+$/, "", $4)
    gsub(/^[ \t]+|[ \t]+$/, "", $5)
    gsub(/^[ \t]+|[ \t]+$/, "", $6)
    gsub(/^[ \t]+|[ \t]+$/, "", $7)
    gsub(/^[ \t]+|[ \t]+$/, "", $8)
    
    # Check if Destination is Mars and Status is Completed
    if (tolower($3) == "mars" && tolower($4) == "completed") {
        # $6 is Duration (days)
        duration = int($6)
        if (duration > max_duration) {
            max_duration = duration
            security_code = $8  # $8 is Security Code
        }
    }
}
END {
    print security_code
}
' space_missions.log

