# Part 2: Awk Solution for Warp Shared Block

## Overview
This is Part 2 of the Warp hiring challenge. You need to create an `awk` command that solves the space mission analysis problem and share it as a **Warp Shared Block**.

## The Challenge
Find the security code of the **longest successful Mars mission** using `awk`.

## Awk Command Solution

Here's the `awk` command that solves the problem:

```bash
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
```

## One-Liner Version (for Warp Shared Block)

If you prefer a more compact version:

```bash
awk -F'|' 'BEGIN{max=0;code=""} /^#/||/^SYSTEM:/||/^CONFIG:/||/^CHECKSUM:/{next} NF==8{gsub(/^[ \t]+|[ \t]+$/,"",$1);gsub(/^[ \t]+|[ \t]+$/,"",$2);gsub(/^[ \t]+|[ \t]+$/,"",$3);gsub(/^[ \t]+|[ \t]+$/,"",$4);gsub(/^[ \t]+|[ \t]+$/,"",$5);gsub(/^[ \t]+|[ \t]+$/,"",$6);gsub(/^[ \t]+|[ \t]+$/,"",$7);gsub(/^[ \t]+|[ \t]+$/,"",$8);if(tolower($3)=="mars"&&tolower($4)=="completed"){d=int($6);if(d>max){max=d;code=$8}}} END{print code}' space_missions.log
```

## How to Share as Warp Shared Block

1. Open Warp terminal
2. Run the command above
3. Select the command in Warp
4. Use Warp's "Share" feature to create a Shared Block
5. Copy the link to the Shared Block
6. Submit the link in your application

## How It Works

1. **Field Separator**: `-F'|'` sets the field separator to pipe character
2. **Skip Comments**: Lines starting with `#`, `SYSTEM:`, `CONFIG:`, or `CHECKSUM:` are skipped
3. **Field Trimming**: `gsub()` removes leading/trailing whitespace from each field
4. **Filtering**: Only processes lines where:
   - Destination (field 3) is "Mars" (case-insensitive)
   - Status (field 4) is "Completed" (case-insensitive)
5. **Find Maximum**: Tracks the maximum duration (field 6) and stores the corresponding security code (field 8)
6. **Output**: Prints the security code of the longest mission

## Testing

You can test the command by running:

```bash
chmod +x awk_solution.sh
./awk_solution.sh
```

Or directly:

```bash
awk -F'|' 'BEGIN{max=0;code=""} /^#/||/^SYSTEM:/||/^CONFIG:/||/^CHECKSUM:/{next} NF==8{gsub(/^[ \t]+|[ \t]+$/,"",$1);gsub(/^[ \t]+|[ \t]+$/,"",$2);gsub(/^[ \t]+|[ \t]+$/,"",$3);gsub(/^[ \t]+|[ \t]+$/,"",$4);gsub(/^[ \t]+|[ \t]+$/,"",$5);gsub(/^[ \t]+|[ \t]+$/,"",$6);gsub(/^[ \t]+|[ \t]+$/,"",$7);gsub(/^[ \t]+|[ \t]+$/,"",$8);if(tolower($3)=="mars"&&tolower($4)=="completed"){d=int($6);if(d>max){max=d;code=$8}}} END{print code}' space_missions.log
```

