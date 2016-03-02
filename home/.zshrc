ZSH=$HOME/.oh-my-zsh
ZSH_THEME="amuse"
plugins=(git z)

function load_source(){
  [[ -s "$1" ]] && source "$1"
}

load_source $ZSH/oh-my-zsh.sh
load_source "$HOME/.tmux/tmuxinator.zsh"
load_source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# OSX check
if [[ "$OSTYPE" == "darwin"* ]]; then
  load_source "/Users/jperi/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh"
else
  load_source "/Users/jperi/.vim/plugged/gruvbox/gruvbox_256palette.sh"
fi

# sudo previous command
alias fuck='sudo $(history -p \!\!)'
# setting tmux in 265 colors
alias tmux='tmux -2'
# kill all the tmux sessions
alias kill-tmux="tmux ls | cut -d ':' -f 1 | xargs -I% tmux kill-session -t % "

# Bunch of ruby aliases
alias rake='noglob bundle exec rake'
alias foreman='bundle exec foreman'
alias rails='bundle exec rails'
alias unicorn='bundle exec unicorn'
alias thin='bundle exec thin'
alias cap='bundle exec cap'

if hash nvim 2>/dev/null; then
  alias vim='nvim'
fi

export TERM=xterm-256color
export EDITOR='vim'

# Golang configurations
export GOPATH="$HOME/workspace/go"
export PATH="$PATH:$GOPATH/bin"

# Allow to extend in a local basis
load_source "$HOME/.zshrc.local"
