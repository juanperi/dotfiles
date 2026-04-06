#!/usr/bin/env bash
w=$(mux_new_session "$HOME")
mux_split_tiled "$w" "$HOME"

tmux set-window-option -t "${SESSION_NAME}:${w}" synchronize-panes on
tmux send-keys -t "${SESSION_NAME}:${w}.1" "clear; genact" Enter
tmux set-window-option -t "${SESSION_NAME}:${w}" synchronize-panes off
