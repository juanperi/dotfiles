#!/usr/bin/env bash
# mux config: showoff session — 4 panes running genact
#
#  ┌──────────┬──────────┐
#  │  genact  │  genact  │
#  ├──────────┼──────────┤
#  │  genact  │  genact  │
#  └──────────┴──────────┘

ROOT="$HOME"

tmux new-session -d -s "$SESSION_NAME" -c "$ROOT"
tmux split-window -h -t "${SESSION_NAME}:1" -c "$ROOT"
tmux split-window -v -t "${SESSION_NAME}:1.2" -c "$ROOT"
tmux split-window -v -t "${SESSION_NAME}:1.1" -c "$ROOT"

tmux send-keys -t "${SESSION_NAME}:1.1" "clear; genact" Enter
tmux send-keys -t "${SESSION_NAME}:1.2" "clear; genact" Enter
tmux send-keys -t "${SESSION_NAME}:1.3" "clear; genact" Enter
tmux send-keys -t "${SESSION_NAME}:1.4" "clear; genact" Enter
