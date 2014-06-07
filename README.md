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

4. Compile command-t

    ```
    $ cd ~/dotfiles/vim/vim/bundle/command-t/ruby/command-t
    $ ruby extconf.rb
    $ make
    ```

5. Install the plugins

    ```
    vim +PluginInstall +qall
    ```

