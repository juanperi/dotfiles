#!/usr/bin/env bash
w=$(mux_new_session "$HOME")
mux_split_tiled "$w" "$HOME"

tmux send-keys -t "${SESSION_NAME}:${w}.1" "clear; genact" Enter
tmux send-keys -t "${SESSION_NAME}:${w}.2" "clear; genact" Enter
tmux send-keys -t "${SESSION_NAME}:${w}.3" "clear; genact" Enter
tmux send-keys -t "${SESSION_NAME}:${w}.4" "clear; genact" Enter
