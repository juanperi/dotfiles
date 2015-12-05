dotfiles
========

my personal dotfiles. Nothing fancy... just a lot of copied stuff from other
people

Install
=======

1. Run the Install command:

    ```
    cd ~
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/epilgrim/dotfiles/master/install.sh)"
    ```

1. Install tmux plugins

    Inside a tmux session execute `CTRL+a I` to install the plugins

1. Don't forget to install the following dependencies for extended
   functionality

    ```
    sudo apt-get install silversearcher-ag
    sudo apt-get install exuberant-ctags
    ```
