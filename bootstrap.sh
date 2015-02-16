#!/usr/bin/env bash

echo -e "${COLOR_GREEN}"

for z in {1..50}; do
  for i in {1..16}; do
    r="$(($RANDOM % 2))"
    if [[ $(($RANDOM % 5)) == 1 ]]; then
      if [[ $(($RANDOM % 4)) == 1 ]]; then
        v+="\e[1m $r   "
      else
        v+="\e[2m $r   "
      fi
    else
      v+="     "
    fi
  done
  echo -e "$v"
  v="";
done

echo "      _       _         __ _ _"
echo "   __| | ___ | |_      / _(_) | ___  ___"
echo "  / _\` |/ _ \| __|____| |_| | |/ _ \/ __|"
echo " | (_| | (_) | ||_____|  _| | |  __/\__ \\"
echo "  \__,_|\___/ \__|    |_| |_|_|\___||___/"
echo ""

echo -e "${COLOR_NO_COLOUR}"


if [[ "$1" == "--force" ]] || [[ "$1" == "-f" ]]; then
  FORCE=1
else
  FORCE=0
fi

git pull origin master

doIt()
{
  if [ ! -f ~/.config_dotfiles ]; then
    cp .config_dotfiles_default ~/.config_dotfiles
  fi

  # copy dotfiles
  git config --global -l | LANG=C sort > /tmp/oldgit$$
  rsync --exclude-from .IGNORE -avhi --no-perms . ~/
	source ~/.bash_profile

  git config --global -l | LANG=C sort > /tmp/newgit$$

  echo "git configuration not present anymore after bootstrapping:"
  LANG=C comm -23 /tmp/oldgit$$ /tmp/newgit$$
  echo -e "\nYou can use the following commands to add it again:"
  LANG=C comm -23 /tmp/oldgit$$ /tmp/newgit$$ | while read line; do echo "git config --global --add "$(echo $line | sed 's/=/ \"/;s/$/\"/') ;done

  # check for "force"
  if [[ "$FORCE" == "1" ]]; then
    return 0
  fi

  # try zsh?
  read -p "Do you want to use the zsh-shell? (y/n) " -n 1 yesOrNo
  echo
  if [[ $yesOrNo =~ ^[Yy]$ ]]; then
    sudo pacman -S zsh
    chsh -s $(which zsh)
  fi

  # install vim-plugin-manager
  if [ ! -d ~/.vim/bundle/vundle ]; then
    mkdir ~/.vim/bundle
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    vim +BundleInstall +qall
  else
    read -p "Do you want to update vim-plugins? (y/n) " -n 1 yesOrNo
    echo
    if [[ $yesOrNo =~ ^[Yy]$ ]]; then
      cd ~/.vim/bundle/vundle
      git pull
      vim +BundleUpdate +qall
    fi
  fi
}

dryRun()
{
	rsync --exclude-from .IGNORE -avhni --no-perms . ~/
	source ~/.bash_profile
}

if [[ "$FORCE" == "1" ]]; then
	doIt
else
  echo "Executing dry run..."
  echo

  dryRun
  echo
  echo
  read -p "The files listed above will overwritten in your home directory. Are you sure you want to continue? (y/n) " -n 1 yesOrNo
  echo
  if [[ $yesOrNo =~ ^[Yy]$ ]]; then
    doIt
  fi
fi

unset -f doIt
unset -f dryRun
