if [[ $BASH_PREVIEW ]];
then
  unset BASH_PREVIEW #Prevent infinite looping
  echo "

  Previewing Bash Themes

  "

  THEMES="$RED_PILL/themes/*/*.theme.bash"
  for theme in $THEMES
  do
    RED_PILL_THEME=$(basename -s '.theme.bash' $theme)
    echo "
    $RED_PILL_THEME"
    echo "" | bash --init-file $RED_PILL/bash_it.sh -i
  done
fi
