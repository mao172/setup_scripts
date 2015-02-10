#!/bin/sh

which vim
if [ $? -ne 0 ] ; then
  yum install -y vim
fi

grep Diff ~/.vimrc
if [ $? -eq 0 ] ; then
  exit
fi

echo "highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22" >> ~/.vimrc
echo "highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52" >> ~/.vimrc
echo "highlight DiffChange cterm=bold ctermfg=10 ctermbg=17" >> ~/.vimrc
echo "highlight DiffText   cterm=bold ctermfg=10 ctermbg=21" >> ~/.vimrc

cat ~/.vimrc
