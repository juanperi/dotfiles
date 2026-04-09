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
if [ ! -e $HOME/.homesick/repos/homeshick ]; then
  git clone https://github.com/andsens/homeshick $HOME/.homesick/repos/homeshick
fi

# Loading homeshick
source $HOME/.homesick/repos/homeshick/homeshick.sh

# Getting the dotfiles
if [ ! -e $HOME/.homesick/repos/dotfiles ]; then
    homeshick clone https://github.com/juanperi/dotfiles
else
    homeshick -f pull dotfiles
fi
homeshick -f link dotfiles

#Installing zsh
ZSH_BIN=`which zsh`
if [ -n $ZSH_BIN ]; then
  if [ ! -e ~/.oh-my-zsh ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh
  fi
  if [ ! "$SHELL" = "$ZSH_BIN" ]; then
    echo "Dont forget to set $ZSH_BIN as your default shell (chsh -s" $ZSH_BIN ")"
  fi
fi

if ! hash ag 2>/dev/null; then
  echo "Don't forget to install silversearcher-ag"
fi


if ! hash gcc 2>/dev/null; then
  echo "Don't forget to install gcc (needed for nvim-treesitter parser compilation)"
fi

if ! hash tree-sitter 2>/dev/null; then
  echo "Don't forget to install the tree-sitter CLI (needed for nvim-treesitter parser compilation)"
  echo "  macOS:  brew install tree-sitter"
  echo "  Linux:  https://github.com/tree-sitter/tree-sitter/releases/latest"
fi

# back to the original directory
cd $pwd
