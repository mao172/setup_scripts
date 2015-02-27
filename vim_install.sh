#!/bin/sh

which vim
if [ $? -ne 0 ] ; then
  yum install -y vim
fi

ls -al ~/.vim/bundle
if [ $? -ne 0 ] ; then
  mkdir -p ~/.vim/bundle
  git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
  git clone https://github.com/Shougo/vimproc ~/.vim/bundle/vimproc
fi

echo "set nocompatible" >> ~/.vimrc
echo "filetype plugin indent off" >> ~/.vimrc
echo "" >> ~/.vimrc
echo "if has('vim_starting')" >> ~/.vimrc
echo "  set runtimepath+=~/.vim/bundle/neobundle.vim" >> ~/.vimrc
echo "endif" >> ~/.vimrc
echo "" >> ~/.vimrc
echo "call neobundle#begin(expand('~/.vim/bundle'))" >> ~/.vimrc
echo "NeoBundleFetch 'Shougo/neobundle.vim'" >> ~/.vimrc
echo "call neobundle#end()" >> ~/.vimrc
echo "" >> ~/.vimrc
echo "filetype plugin indent on" >> ~/.vimrc
echo "" >> ~/.vimrc

echo "NeoBundle 'scrooloose/syntastic'" >> ~/.vimrc
echo "let g:syntastic_mode_map = { 'mode': 'passive','active_filetypes': ['ruby'] }" >> ~/.vimrc
echo "let g:syntastic_ruby_checkers = ['rubocop']" >> ~/.vimrc
echo "" >> ~/.vimrc

grep Diff ~/.vimrc
if [ $? -ne 0 ] ; then

  echo "highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22" >> ~/.vimrc
  echo "highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52" >> ~/.vimrc
  echo "highlight DiffChange cterm=bold ctermfg=10 ctermbg=17" >> ~/.vimrc
  echo "highlight DiffText   cterm=bold ctermfg=10 ctermbg=21" >> ~/.vimrc
fi

echo "set tabstop=2" >> ~/.vimrc
echo "set shiftwidth=2" >> ~/.vimrc
echo "set expandtab" >> ~/.vimrc

cat ~/.vimrc
