#!/usr/bin/env bash
# ┌────────────────┬──────────────┐
# │      vim       │   terminal   │
# └────────────────┴──────────────┘
ROOT="$HOME/.homesick/repos"

w=$(mux_new_session "$ROOT")
mux_split_editor "$w" "$ROOT"
