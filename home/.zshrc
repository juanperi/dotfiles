#PS4="+%D{%s.%.}> "
#set -o xtrace
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

# Convert a datetime in the format 2024-01-01T00:00:00.000Z to a timestamp with precision

# Inline brew shellenv (faster than eval subshell)
if [[ -x /opt/homebrew/bin/brew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  export HOMEBREW_REPOSITORY="/opt/homebrew"
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
  load_source /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

load_source $ZSH/oh-my-zsh.sh

if (( $+commands[tmux] )); then
  load_source "$HOME/.bin/mux.zsh"
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

export TERM=screen-256color
export EDITOR='nvim'
export VISUAL='nvim'
# To be able to open vim for current command. Check https://github.com/ohmyzsh/ohmyzsh/issues/9588
export KEYTIMEOUT=15

# Golang configurations
export GOPATH="$HOME/workspace/go"
export PATH="$PATH:$GOPATH/bin"

# Vi mode.
bindkey "^R" history-incremental-search-backward

# Add node_modules to path
export PATH=$PATH:node_modules/.bin
# add sbin to path, as brew installs stuff there
export PATH="/usr/local/sbin:$PATH"

# Allow to extend in a local basis
load_source "$HOME/.zshrc.local"

export ERL_AFLAGS="-kernel shell_history enabled"

# load fzf config if it exists
if (( $+commands[fzf] )); then
  load_source ~/.fzf.zsh
fi

# direnv hook
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
load_source "/Users/jperi/google-cloud-sdk/path.zsh.inc"

# The next line enables shell command completion for gcloud.
load_source "/Users/jperi/google-cloud-sdk/completion.zsh.inc"

# The next line loads java's home if the plubin is installed
load_source "~/.asdf/plugins/java/set-java-home.zsh"
# Created by `pipx` on 2025-04-01 07:38:56
export PATH="$PATH:/Users/jperi/.local/bin"
