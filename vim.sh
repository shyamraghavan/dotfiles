#!/bin/bash

BOLD="\033[0;1m"
RED="\033[0;31m"
END="\033[0m"

echo -e "${BOLD}Setting up vim...${END}"

if [ ! -e ~/.vim/bundle/Vundle.vim ]
  then
    mkdir -p ~/.vim/bundle; git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

cp ./dotfiles/shyamra/.vimrc ~/.vim
vim +PluginInstall +qall