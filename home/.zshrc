#PS4="+%D{%s.%.}> "
#set -o xtrace
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="amuse"
plugins=(git z vi-mode asdf)

# remove ruby version from the prompt
RPROMPT=''

function load_source(){
  [[ -s "$1" ]] && source "$1"
}

eval "$(/opt/homebrew/bin/brew shellenv)"

load_source $ZSH/oh-my-zsh.sh
load_source "$HOME/.bin/tmuxinator.zsh"
load_source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# OSX check
if [[ "$OSTYPE" == "darwin"* ]]; then
  load_source "/Users/jperi/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh"
else
  load_source "/Users/jperi/.vim/plugged/gruvbox/gruvbox_256palette.sh"
fi

# sudo previous command
alias fuck='sudo $(fc -ln -1)'
# setting tmux in 265 colors
alias tmux='tmux -2'
# kill all the tmux sessions
alias kill-tmux="tmux ls | cut -d ':' -f 1 | xargs -I% tmux kill-session -t % "

# ssh to vagrant
alias v="vagrant ssh"

alias pushn="git symbolic-ref --short -q HEAD | xargs git push -u origin"

if hash nvim 2>/dev/null; then
  alias vim='nvim'
fi

export TERM=screen-256color
export EDITOR='nvim'
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
load_source ~/.fzf.zsh

if type "rbenv" > /dev/null; then
  eval "$(rbenv init -)"
fi

eval "$(direnv hook zsh)"

load_source /opt/homebrew/opt/asdf/libexec/asdf.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
load_source "/Users/jperi/google-cloud-sdk/path.zsh.inc"

# The next line enables shell command completion for gcloud.
load_source "/Users/jperi/google-cloud-sdk/completion.zsh.inc"

