# ~/.zshenv — sourced by EVERY zsh invocation (login, interactive, scripts,
# subshells from agents/editors). Keep this file pure environment: PATH,
# exports, and small portable shims. NO prompt config, NO plugin loading,
# NO oh-my-zsh, NO completions, NO aliases — those belong in .zshrc.
#
# This file is read before .zshrc and is the right place for env that
# tools spawned outside an interactive terminal (Hermes, editors, cron)
# must see.

# ── Homebrew (Apple Silicon) ─────────────────────────────────────────────
if [[ -x /opt/homebrew/bin/brew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  export HOMEBREW_REPOSITORY="/opt/homebrew"
  path=("/opt/homebrew/bin" "/opt/homebrew/sbin" $path)
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
fi

# ── asdf (Go rewrite, ≥0.16) ─────────────────────────────────────────────
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
path=("$ASDF_DATA_DIR/shims" $path)

# ── Editor ───────────────────────────────────────────────────────────────
export EDITOR='nvim'
export VISUAL='nvim'
export TERM=screen-256color
export KEYTIMEOUT=15

# ── Go ───────────────────────────────────────────────────────────────────
export GOPATH="$HOME/workspace/go"
path+=("$GOPATH/bin")

# ── PATH additions ───────────────────────────────────────────────────────
path=("/usr/local/sbin" $path)
path+=("node_modules/.bin")
path+=("$HOME/.yarn/bin" "$HOME/.config/yarn/global/node_modules/.bin")
path+=("$HOME/.local/bin")              # pipx, custom scripts (mux, spike, note)

# Dedupe and export
typeset -U path
export PATH

# ── Erlang ───────────────────────────────────────────────────────────────
export ERL_AFLAGS="-kernel shell_history enabled"

# ── Notes (zk) ───────────────────────────────────────────────────────────
export ZK_NOTEBOOK_DIR="$HOME/workspace/notes"

# ── Google Cloud SDK (path only — completion stays in .zshrc) ────────────
[[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]] && source "$HOME/google-cloud-sdk/path.zsh.inc"

# ── Local overrides (gitignored) ─────────────────────────────────────────
[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"
