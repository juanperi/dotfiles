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

# Setup Vim
if hash vim 2>/dev/null; then
  # Update VimPlug and Plugins
  vim +PlugUpgrade +PlugUpdate +qall
else
  echo 'Ignoring Vim setup'
fi

if ! hash ag 2>/dev/null; then
  echo "Don't forget to install silversearcher-ag"
  echo "  sudo apt-get install silversearcher-ag"
fi

if ! hash ctags 2>/dev/null; then
  echo "Don't forget to install ctags"
  echo "  sudo apt-get install exuberant-ctags"
fi

# back to the original directory
cd $pwd
