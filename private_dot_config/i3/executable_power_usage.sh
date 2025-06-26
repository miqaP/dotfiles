#!/bin/bash

ENERGY_FILE="/sys/class/powercap/intel-rapl:0/energy_uj"

# Check if the file exists
if [ ! -f "$ENERGY_FILE" ]; then
    echo "⚡ N/A"
    exit 1
fi

# First reading
E1=$(cat "$ENERGY_FILE")
T1=$(date +%s%N)

# Wait 1 second
sleep 1

# Second reading
E2=$(cat "$ENERGY_FILE")
T2=$(date +%s%N)

# Avoid division by zero
if [[ "$T2" -le "$T1" ]] || [[ "$E2" -le "$E1" ]]; then
    echo "⚡ 0.0W"
    exit 0
fi

# Compute joules (energy_uj is in microjoules)
JOULES=$(echo "scale=6; ($E2 - $E1) / 1000000" | bc)

# Compute seconds (ns to s)
SECONDS_ELAPSED=$(echo "scale=6; ($T2 - $T1) / 1000000000" | bc)

# Calculate power in watts
POWER=$(echo "scale=1; $JOULES / $SECONDS_ELAPSED" | bc)

echo "⚡ ${POWER}W"

