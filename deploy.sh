#!/usr/bin/sh

ln -fs `realpath ./vim` ~/.vim
echo 'source $HOME/.vim/vimrc' > ~/.vimrc

ln -fs `realpath ./zshrc` ~/.zshrc
ln -fs `realpath ./cenouro.zsh-theme` ~/.oh-my-zsh/custom/
