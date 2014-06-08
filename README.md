dotfiles
========

my personal dotfiles. Nothing fancy... just a lot of copied stuff from other
people

Install
=======

1. Clone this repository

    ```
    git clone https://github.com/Epilgrim/dotfiles.git ~/
    ```

2. Generate symlinks to the corresponding folders

    ```
    cd
    ln -s dotfiles/vim-files/vim .vim
    ln -s dotfiles/vim-files/vim/vimrc .vimrc
    ```

3. Setup Vundle

    ```
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    ```

4. Install the plugins

    ```
    vim +PluginInstall +qall
    ```

5. Link the generic git configurations to your local git

   Add the following at the beginning of your ~/.gitconfig file

    ```
    [include]
        path = ~/dotfiles/git/gitconfig
    ```

