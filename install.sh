#!/bin/sh

# Cancel everything if minimun dependencies are not met
if ! hash git 2>/dev/null; then
  echo 'Git is a mandatory dependency'
  exit 1
fi
if ! hash curl 2>/dev/null; then
  echo 'curl is a mandatory dependency'
  exit 1
fi

# Storing the current directory to go back later
pwd=$(pwd)

# Moving to home to make commands relative to here
cd $HOME

# Installing homeshick to manage dotfiles
if [ ! -e $HOME/.homesick/repost/homeshick ]; then
  git clone git@github.com:andsens/homeshick $HOME/.homesick/repos/homeshick
fi

# Loading homeshick
source $HOME/.homesick/repos/homeshick/homeshick.sh

# Getting the dotfiles
homeshick clone git@github.com:epilgrim/dotfiles
homeshick link dotfiles

#Installing zsh
if [ -e /bin/zsh ]; then
  if [ ! -e ~/.oh-my-zsh ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh
  fi
  if [ ! "$SHELL" = '/bin/zsh' ]; then
    echo "Setting zsh as default shell"
    chsh -s /bin/zsh
  fi
fi

# Setup Vim
if hash vim 2>/dev/null; then
  vim +PlugUpgrade +PlugUpdate +qall
fi

if ! hash ag 2>/dev/null; then
  echo "Don't forget to install silversearcher-ag"
fi

if ! hash ctags 2>/dev/null; then
  echo "Don't forget to install ctags"
fi

# back to the original directory
cd $pwd
