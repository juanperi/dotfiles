ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ys"
plugins=(git)

function load_source(){
  [[ -s "$1" ]] && source "$1"
}

load_source $ZSH/oh-my-zsh.sh
load_source "$HOME/.tmux/tmuxinator.zsh"
load_source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# # Customize to your needs...
export TERM=xterm-256color
export EDITOR='vim'
