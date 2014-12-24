#!/bin/bash
# Swap ESC and Caps Lock
xmodmap -e "keycode 9 = Caps_Lock"
xmodmap -e "clear Lock"
xmodmap -e "keycode 66 = Escape"
