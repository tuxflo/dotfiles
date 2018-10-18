#!/bin/sh
# <- keep this line for colors in the file ;)

# ZSH Theme by voku - with ❤

setup_prompt()
{
  # Local or SSH session?
  local remote=""
  [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] && remote=1

  # set the user-color
  local user_color="%{$(print -P ${COLOR_LIGHT_GREEN})%}"     # user's color
  [ $UID -eq 0 ] && user_color="%{$fg[red]%}"                 # root's color

  # set the user
  local user=""
  if [[ -z $CONFIG_DEFAULT_USER ]] || [[ $CONFIG_DEFAULT_USER != $USER ]]; then
    user=$USER
  fi

  # set the hostname inside SSH session
  local host=""
  [ -n "$remote" ] && host="%{$(print -P ${COLOR_LIGHT_GREEN})%}${ICON_FOR_AT}%M"

  # set extra ":" after user || host
  local userOrHostExtra=""
  if [[ -n "$host" ]] || [[ -n "$user" ]]; then
    userOrHostExtra="${user_color}:"
  fi

  if [[ "$(tty)" == /dev/pts/* ]]; then
    if [[ -n $remote ]] && [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
      export TERM='gnome-256color'
    elif infocmp xterm-256color >/dev/null 2>&1; then
      export TERM='xterm-256color'
    fi
  fi

	# Format prompt
	PROMPT="%(?.%{$fg[green]%}${ICON_FOR_TRUE}.%{$fg[red]%}${ICON_FOR_FALSE}[%?]) ${user_color}${user}${host}${userOrHostExtra}%{$(print -P ${COLOR_LIGHT_BLUE})%}%~% %{$(print -P ${COLOR_LIGHT_RED})%}${ICON_FOR_ARROW_RIGHT}%{$reset_color%} "
	PROMPT2="%{$fg[red]%}${ICON_FOR_ARROW_RIGHT}%{$reset_color%}"

  RPROMPT='$(git_super_status)%{$(print -P ${COLOR_LIGHT_PURPLE})%}$(__svn_branch)%{$reset_color%}'

	export PROMPT PROMPT2 RPROMPT
}

# Show awesome prompt always
setup_prompt
