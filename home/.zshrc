#PS4="+%D{%s.%.}> "
#set -o xtrace

# Env vars and PATH live in ~/.zshenv (sourced earlier by zsh, including
# from non-interactive subshells spawned by agents and editors).
# This file is for interactive ergonomics: prompt, plugins, aliases, keys.

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="amuse"
plugins=(git z vi-mode)

# Speed up compinit
ZSH_DISABLE_COMPFIX=true
# Fix oh-my-zsh bug #12952: deduplicate fpath so compinit cache works
fpath=(${(uo)fpath})

# remove ruby version from the prompt
RPROMPT=''

function load_source(){
  [[ -s "$1" ]] && source "$1"
}

# asdf completions (data dir was exported in .zshenv)
if [[ -x /opt/homebrew/bin/brew ]]; then
  fpath=("$ASDF_DATA_DIR/completions" $fpath)
fi

load_source $ZSH/oh-my-zsh.sh

if (( $+commands[tmux] )); then
  load_source "$HOME/.local/bin/mux.zsh"
fi

load_source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# sudo previous command
alias fuck='sudo $(fc -ln -1)'
# setting tmux in 265 colors
alias tmux='tmux -2'
# kill all the tmux sessions
alias kill-tmux="tmux ls | cut -d ':' -f 1 | xargs -I% tmux kill-session -t % "

alias moto='fortune | cowsay -r'

alias pushn="git symbolic-ref --short -q HEAD | xargs git push -u origin"

if (( $+commands[nvim] )); then
  alias vim='nvim'
fi

alias notifyDone='tput bel; terminal-notifier -title "Terminal" -message "Done with task! Exit status: $?" --sound default' -activate com.apple.Terminal

# Vi mode.
bindkey "^R" history-incremental-search-backward

# Allow to extend in a local basis
load_source "$HOME/.zshrc.local"

# load fzf config if it exists
if (( $+commands[fzf] )); then
  load_source ~/.fzf.zsh
fi

# direnv hook
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

# gcloud shell command completion (path moved to .zshenv)
load_source "$HOME/google-cloud-sdk/completion.zsh.inc"

# Java home plugin (if asdf java plugin installed)
load_source "$HOME/.asdf/plugins/java/set-java-home.zsh"
