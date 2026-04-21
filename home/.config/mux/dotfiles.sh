#!/usr/bin/env bash
ROOT="$HOME/.homesick/repos"

w=$(mux_new_session "$ROOT")
mux_split_editor "$w" "$ROOT"
mux_opencode "${SESSION_NAME}:${w}.2" "$ROOT"
