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

# Configuring git
echo 'Linking .gitconfig'
ln -sf dotfiles/git/gitconfig .gitconfig

# Adding git feedback in the prompt
if [ ! -e dotfiles/shell/bash-git-prompt ]; then
  echo 'Clonning bash-git-prompt'
  git clone https://github.com/magicmonty/bash-git-prompt.git \
    dotfiles/shell/bash-git-prompt
fi

# Adding z to move around
if [ ! -e dotfiles/shell/z ]; then
  echo 'Clonning z to move around filesystem'
  git clone https://github.com/rupa/z.git dotfiles/shell/z
fi

# Add extended_bashrc at the end of .bashrc
echo 'Adding extended_bashrc to .bashrc'
sed -i '/dotfiles.*extended_bashrc/d' .bashrc
echo 'source $HOME/dotfiles/shell/extended_bashrc' >> .bashrc
source .bashrc

# Setup Vim
if hash vim 2>/dev/null; then
  echo 'Linking vim configuration'
  ln -sf dotfiles/vim .vim
  ln -sf dotfiles/vim/vimrc .vimrc
  # Setup Vim Plug (vim plugins manager)
  if [ ! -e .vim/autoload/plug.vim ]; then
    echo 'Clonning Vim Plug'
    curl -fLo .vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
  vim +PlugInstall +qall
else
  echo 'Ignoring Vim setup'
fi

# Setup Tmux plugins
if hash tmux 2>/dev/null; then
  if [ ! -e .tmux/plugins/tpm ]; then
    echo 'Clonning Tmux Plugins'
    git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
  fi
  echo 'Linking Tmux configuration'
  ln -sf dotfiles/tmux/tmux.conf .tmux.conf
  echo 'Reloading Tmux configuration'
  tmux source ~/.tmux.conf
else
  echo 'Ignoring Tmux setup'
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
