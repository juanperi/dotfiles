source $HOME/.homesick/repos/homeshick/homeshick.sh

#set vim as default editor
export EDITOR=vim

# disable Software Flow Control
# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# to use when i forget to use sudo
# ------------------------------------------------
alias fuck='sudo $(history -p \!\!)'

# setting tmux in 265 colors
# ------------------------------------------------
alias tmux='tmux -2'

# kill all the tmux sessions
# ------------------------------------------------
alias kill-tmux="tmux ls | cut -d ':' -f 1 | xargs -I% tmux kill-session -t % "

# Notify the lines to the operative system
# ------------------------------------------------
alias notify-line="xargs -n1 -I '{}' sh -c \"notify-send '{}'; echo '{}';\""

# Symlinks to quickly navigate to different parts of the filesystem
# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
# ------------------------------------------------
export MARKPATH=$HOME/.marks
function jump {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}
complete -F _completemarks jump unmark

# Function to highlight values from standard input
# ------------------------------------------------
highlight () {
    perl -pe "s/$1/\e[1;31;43m$&\e[0m/g"
}

