#!/usr/bin/env bash
# ┌─────────────┬────────────┐
# │             │  terminal  │
# │    vim      ├────────────┤
# │             │  opencode  │
# └─────────────┴────────────┘
ROOT="$HOME/workspace"

w=$(mux_new_session "$ROOT")
mux_split_editor "$w" "$ROOT"
mux_opencode "${SESSION_NAME}:${w}.3" "$ROOT"
