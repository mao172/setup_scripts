#!/bin/sh

script_dir=`dirname $0`
$script_dir/vim_install.sh

USER_NAME="Masafumi Okamoto"
USER_EMAIL="okamoto.masafumi@tis.co.jp"
USER_ID=mao172

git config --global user.name "${USER_NAME}"
git config --global user.email "${USER_EMAIL}"
git config --global color.ui auto
git config --global diff.algorithm histogram
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff

REPO_DIR=`pwd`

cd ${REPO_DIR}
if [ $? -ne 0 ] ; then
  exit
fi

git status
if [ $? -ne 0 ] ; then
  exit
fi

url=`git config --list | grep remote.origin.url`
url=`echo $url | sed -e "s/remote\.origin\.url=//g"`
url=`echo $url | sed -e "s/:\/\/${USER_ID}@github\.com/:\/\/github\.com/g"`
url=`echo $url | sed -e "s/github\.com/${USER_ID}@github\.com/g"`

echo $url
git remote set-url origin $url

#git config --list

git config --global branch.master.mergeoptions "--no-ff"
git config --global branch.develop.mergeoptions "--no-ff"
git config --global merge.ff false

git config --global branch.master.rebase true
git config --global pull.rebase true
git config --global pull.rebase preserve

git config --list
