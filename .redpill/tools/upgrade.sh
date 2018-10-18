#!/bin/sh

echo $DOTFILESSRCDIR

cd $DOTFILESSRCDIR

printf '\033[0;34m%s\033[0m\n' "Upgrading ..."

if git pull --rebase --stat origin master; then
  printf '\033[0;34m%s\033[0m\n' '... done!'
else
  printf '\033[0;31m%s\033[0m\n' 'There was an error updating. Try again later?'
fi

