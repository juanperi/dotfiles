#!/usr/bin/env bash
# mux config: workspace session
# Layout: vim left | terminal top-right, opencode bottom-right
#
#  ┌─────────────┬────────────┐
#  │             │  terminal  │
#  │    vim      ├────────────┤
#  │             │  opencode  │
#  └─────────────┴────────────┘

ROOT="$HOME/workspace"

tmux new-session -d -s "$SESSION_NAME" -c "$ROOT"
tmux split-window -h -t "${SESSION_NAME}:1" -c "$ROOT"
tmux split-window -v -t "${SESSION_NAME}:1.2" -c "$ROOT"

tmux send-keys -t "${SESSION_NAME}:1.1" "nvim" Enter
tmux send-keys -t "${SESSION_NAME}:1.3" "opencode" Enter

tmux select-pane -t "${SESSION_NAME}:1.1"
