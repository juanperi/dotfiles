export EDITOR=vim #set vim as default editor

source $HOME/.homesick/repos/homeshick/homeshick.sh

# sudo previous command
alias fuck='sudo $(history -p \!\!)'

# setting tmux in 265 colors
alias tmux='tmux -2'

# kill all the tmux sessions
alias kill-tmux="tmux ls | cut -d ':' -f 1 | xargs -I% tmux kill-session -t % "

# Notify the lines to the operative system
alias notify-line="xargs -n1 -I '{}' sh -c \"notify-send '{}'; echo '{}';\""

# highlight maching. eg: grep file | highlight pattern
highlight () {
    perl -pe "s/$1/\e[1;31;43m$&\e[0m/g"
}

# disable Software Flow Control
# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# load fzf config if it exists
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
