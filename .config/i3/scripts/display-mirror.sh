#!/bin/bash
# Display mirroring script for i3
# Mirrors external displays to the internal laptop screen

INTERNAL="eDP-1"

# Find connected external displays
get_external_display() {
    xrandr --query | grep " connected" | grep -v "$INTERNAL" | awk '{print $1}' | head -1
}

# Get the best common resolution between two displays
get_common_resolution() {
    local internal=$1
    local external=$2

    # Get external display's preferred (native) resolution - usually best choice for mirroring
    local ext_res=$(xrandr --query | grep -A1 "^$external connected" | tail -1 | awk '{print $1}')

    # Check if internal display supports this resolution
    if xrandr --query | sed -n "/^$internal connected/,/^[A-Za-z]/p" | grep -q "$ext_res"; then
        echo "$ext_res"
    else
        # Fall back to 1920x1080 which most displays support
        echo "1920x1080"
    fi
}

EXTERNAL=$(get_external_display)

if [ -n "$EXTERNAL" ]; then
    echo "External display detected: $EXTERNAL"

    # Get resolution to use for mirroring
    RESOLUTION=$(get_common_resolution "$INTERNAL" "$EXTERNAL")
    echo "Using resolution: $RESOLUTION"

    # Mirror: set both displays to same resolution at position 0x0
    xrandr --output "$INTERNAL" --mode "$RESOLUTION" --pos 0x0 --primary \
           --output "$EXTERNAL" --mode "$RESOLUTION" --pos 0x0 --same-as "$INTERNAL"

    # Adjust DPI for the mirrored resolution
    xrandr --dpi 96

    echo "Mirroring $INTERNAL to $EXTERNAL at $RESOLUTION"
else
    echo "No external display detected, using internal only"

    # Reset to native resolution with HiDPI
    xrandr --output "$INTERNAL" --auto --primary
    xrandr --dpi 192
fi

# Refresh wallpaper for new resolution
if command -v feh &> /dev/null; then
    feh --bg-fill /home/michael/Pictures/5m5kLI9.png 2>/dev/null || true
fi
