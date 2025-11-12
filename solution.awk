BEGIN {
    max_duration = 0
    security_code = ""
}
/^#/ || /^SYSTEM:/ || /^CONFIG:/ || /^CHECKSUM:/ { next }
NF == 8 {
    gsub(/^[ \t]+|[ \t]+$/, "", $1)
    gsub(/^[ \t]+|[ \t]+$/, "", $2)
    gsub(/^[ \t]+|[ \t]+$/, "", $3)
    gsub(/^[ \t]+|[ \t]+$/, "", $4)
    gsub(/^[ \t]+|[ \t]+$/, "", $5)
    gsub(/^[ \t]+|[ \t]+$/, "", $6)
    gsub(/^[ \t]+|[ \t]+$/, "", $7)
    gsub(/^[ \t]+|[ \t]+$/, "", $8)
    
    if (tolower($3) == "mars" && tolower($4) == "completed") {
        duration = int($6)
        if (duration > max_duration) {
            max_duration = duration
            security_code = $8
        }
    }
}
END {
    print security_code
}