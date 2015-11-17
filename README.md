dotfiles
========

my personal dotfiles. Nothing fancy... just a lot of copied stuff from other
people

Install
=======

1. Clone this repository

    ```
    cd ~
    git clone https://github.com/Epilgrim/dotfiles.git
    ```

1. Generate symlinks to the corresponding folders

    ```
    ln -s dotfiles/vim .vim
    ln -s dotfiles/vim/vimrc .vimrc
    ln -s dotfiles/tmux/tmux.conf .tmux.conf
    ```

1. Setup Vim Plug (vim plugins manager)

    ```
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```

1. Setup Tmux plugins

    ```
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    tmux source ~/.tmux.conf
    ```
    And Inside a Tmux session execute `CTRL+a I` to install the plugins

1. Install vim plugins

    ```
    vim +PlugInstall
    ```

1. Link the generic git configurations to your local git

   Add the following at the beginning of your ~/.gitconfig file

    ```
    [include]
        path = ~/dotfiles/git/gitconfig
    ```

1. Enable the .bashrc customizations

   Add the following at the end of your ~/.bashrc file

    ```
    source $HOME/dotfiles/shell/extended_bashrc
    ```

    After saving the changes, run

    ```
    source ~/.bashrc
    ```
1. If you want all the plugins to work, don't forget to install

    ```
    sudo apt-get install silversearcher-ag
    sudo apt-get install exuberant-ctags
    ```

1. If you want git information in your prompt, then clone

    ```
    git clone https://github.com/magicmonty/bash-git-prompt.git dotfiles/shell/bash-git-prompt
    ```

1. If you want to move around using z

    ```
    git clone https://github.com/rupa/z.git dotfiles/shell/z
    ```
