#!/bin/bash

# Detect internal (primary) screen
PRIMARY=$(xrandr | grep " connected" | grep -E 'eDP' | awk '{print $1}')

# Detect external screen (assuming the first non-primary screen is external)
EXTERNAL=$(xrandr | grep " connected" | grep -v "$PRIMARY" | awk '{print $1}')

# Check if PRIMARY is found, otherwise fallback
if [ -z "$PRIMARY" ]; then
    PRIMARY=$(xrandr | grep " connected" | grep -v 'disconnected' | awk '{print $1}' | head -n 1)
fi
# Paths
TEMPLATE="$HOME/.config/i3/screens.template"
OUTPUT="$HOME/.config/i3/screens.conf"

# Generate config by replacing placeholders
sed -e "s|__ISCREEN__|$PRIMARY|g" -e "s|__ESCREEN__|$EXTERNAL|g" "$TEMPLATE" > "$OUTPUT"
