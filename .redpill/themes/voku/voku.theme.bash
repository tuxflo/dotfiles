#!/usr/bin/env bash

prompt_command()
{
  # Local or SSH session?
  local remote=""
  [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] && remote=1

  # set the user-color
  local user_color=$COLOR_LIGHT_GREEN           # user's color
  [ $UID -eq 0 ] && user_color=$COLOR_RED       # root's color

  # set the user
  local user=""
  if [[ -z $CONFIG_DEFAULT_USER ]] || [[ "$CONFIG_DEFAULT_USER" != "$USER" ]]; then
    user=$USER
  fi

  # set the hostname inside SSH session
  local host=""
  [ -n "$remote" ] && host="\[$COLOR_LIGHT_GREEN\]${ICON_FOR_AT}\h"

  # set extra ":" after user || host
  local userOrHostExtra=""
  if [[ -n "$host" ]] || [[ -n "$user" ]]; then
    userOrHostExtra="\[$user_color\]:"
  fi

  local isCygwinMings=false
  [[ $SYSTEM_TYPE == "CYGWIN" || $SYSTEM_TYPE == "MINGW" ]] && isCygwinMings=true

  if [[ "$(tty)" == /dev/pts/* ]] || $isCygwinMings; then
    if [[ -n $remote ]] && [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
      export TERM='gnome-256color'
    elif infocmp xterm-256color >/dev/null 2>&1; then
      export TERM='xterm-256color'
    elif $isCygwinMings ; then
      export TERM='xterm-256color'
    fi
  fi

  local scm
  if command -v svn > /dev/null 2>&1; then
    scm="\$(__svn_branch)"
  fi

  # Terminal title
  local TITLE=""
  # echo title sequence only for pseudo terminals
  # real tty do not support title escape sequences.
  if [[ "$(tty)" == /dev/pts/* ]] || $isCygwinMings; then
    TITLE="\[\033]0;${USER}@${HOSTNAME}: \w\007\]"
  fi

  # INFO:   Text (commands) inside \[...\] does not impact line length calculation which fixes stange bug when looking through the history
  #         $? is a status of last command, should be processed every time prompt prints

  # Format prompt
  export PS1="${TITLE}\`if [ \$? -eq 0 ]; then echo -e \[\$COLOR_GREEN\]\${ICON_FOR_TRUE}; else echo -e \[\$COLOR_RED\]\${ICON_FOR_FALSE}; fi\` \[$user_color\]${user}${host}${userOrHostExtra}\[$COLOR_LIGHT_BLUE\]\w\[$COLOR_LIGHT_RED\]${ICON_FOR_ARROW_RIGHT}\[$COLOR_LIGHT_PURPLE\]${scm}\[$COLOR_NO_COLOUR\] "

  # Multiline command
  export PS2="\[$COLOR_LIGHT_RED\]${ICON_FOR_ARROW_RIGHT}\[$COLOR_NO_COLOUR\]"

  # Restore the original prompt for select menus. This is unset initially and
  # seems to default to "#? ".
  unset PS3;
}

safe_append_prompt_command prompt_command
