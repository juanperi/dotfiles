#!/usr/bin/env bash
# ┌─────────────┬────────────┐
# │             │  terminal  │
# │    vim      ├────────────┤
# │             │  opencode  │
# └─────────────┴────────────┘
mux_editor_window "$HOME/workspace"
tmux send-keys -t "${SESSION_NAME}:1.3" "opencode" Enter
