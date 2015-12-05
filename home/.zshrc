ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ys"
plugins=(git)

function load_source(){
  [[ -s "$1" ]] && source "$1"
}

load_source $ZSH/oh-my-zsh.sh
load_source "$HOME/.tmux/tmuxinator.zsh"
load_source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# sudo previous command
alias fuck='sudo $(history -p \!\!)'
# setting tmux in 265 colors
alias tmux='tmux -2'
# kill all the tmux sessions
alias kill-tmux="tmux ls | cut -d ':' -f 1 | xargs -I% tmux kill-session -t % "

# # Customize to your needs...
export TERM=xterm-256color
export EDITOR='vim'
