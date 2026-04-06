#!/usr/bin/env bash
# ┌────────────────┬──────────────┐
# │      vim       │   terminal   │
# └────────────────┴──────────────┘
ROOT="$HOME/.homesick/repos"

w=$(mux_new_session "$ROOT")
tmux split-window -h -t "${SESSION_NAME}:${w}" -c "$ROOT"
tmux send-keys -t "${SESSION_NAME}:${w}.1" "nvim" Enter
tmux select-pane -t "${SESSION_NAME}:${w}.1"
