#!/usr/bin/env bash
# mux config: dotfiles session
# Layout: vertical split — vim left, terminal right
#
#  ┌────────────────┬──────────────┐
#  │                │              │
#  │      vim       │   terminal   │
#  │                │              │
#  └────────────────┴──────────────┘

ROOT="$HOME/.homesick/repos"

tmux new-session -d -s "$SESSION_NAME" -c "$ROOT"
tmux split-window -h -t "${SESSION_NAME}:1" -c "$ROOT"

tmux send-keys -t "${SESSION_NAME}:1.1" "nvim" Enter
tmux send-keys -t "${SESSION_NAME}:1.2" "clear" Enter

tmux select-pane -t "${SESSION_NAME}:1.1"
