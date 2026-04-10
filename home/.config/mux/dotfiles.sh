#!/usr/bin/env bash
ROOT="$HOME/.homesick/repos"

w=$(mux_new_session "$ROOT")
tw=$(mux_split_editor "$w" "$ROOT")
tmux send-keys -t "${SESSION_NAME}:${tw}.2" "opencode . --port" Enter
