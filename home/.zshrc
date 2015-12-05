ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ys"
plugins=(git gitfast ruby)

function load_source(){
  [[ -s "$1" ]] && source "$1"
}

load_source $ZSH/oh-my-zsh.sh
load_source "$HOME/.rvm/scripts/rvm"
load_source "/usr/local/rvm/scripts/rvm"
load_source "$HOME/.tmux/tmuxinator.zsh"

# # Customize to your needs...
export TERM=xterm-256color
export EDITOR='vim'
