#!/usr/bin/env bash
# ┌─────────────┬────────────┐
# │             │  terminal  │
# │    vim      ├────────────┤
# │             │  opencode  │
# └─────────────┴────────────┘
ROOT="$HOME/workspace"

w=$(mux_new_session "$ROOT")
mux_split_editor "$w" "$ROOT"
tmux send-keys -t "${SESSION_NAME}:${w}.3" "opencode" Enter
