#!/bin/bash
# Blur lock screen for i3 with i3lock-color

TMPBG=/tmp/screen_locked.png

# Screenshot and blur
maim "$TMPBG"
convert "$TMPBG" -blur 0x8 "$TMPBG"

# Gruvbox colors
BG=282828ff
FG=ebdbb2ff
YELLOW=d79921ff
RED=cc241dff
GREEN=98971aff
GRAY=928374ff
CLEAR=00000000

# Lock with clock and styled indicator
i3lock \
    -i "$TMPBG" \
    -n -e \
    --clock \
    --time-str="%H:%M" \
    --date-str="%A, %B %d" \
    --time-color=$FG \
    --date-color=$GRAY \
    --time-size=72 \
    --date-size=24 \
    --indicator \
    --ring-color=$GRAY \
    --ringver-color=$GREEN \
    --ringwrong-color=$RED \
    --keyhl-color=$YELLOW \
    --bshl-color=$RED \
    --insidever-color=$CLEAR \
    --insidewrong-color=$CLEAR \
    --inside-color=$CLEAR \
    --line-color=$CLEAR \
    --separator-color=$CLEAR \
    --verif-color=$GREEN \
    --wrong-color=$RED \
    --verif-text="Verifying" \
    --wrong-text="Wrong" \
    --noinput-text="" \
    --radius=120 \
    --ring-width=8

rm -f "$TMPBG"
