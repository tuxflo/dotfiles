
############# AUTOLOAD ######################################

# http://zsh.sourceforge.net/Doc/Release/Functions.html

autoload -Uz promptinit && promptinit
autoload -Uz colors && colors
autoload -Uz complist
autoload -Uz computil
autoload -Uz compinit && compinit
autoload -Uz edit-command-line && zle -N edit-command-line

## Load smart urls if available
for d in $fpath; do
  if [[ -e "$d/url-quote-magic" ]]; then
    if [[ -e "$d/bracketed-paste-magic" ]]; then
      autoload -Uz bracketed-paste-magic
      zle -N bracketed-paste bracketed-paste-magic
    fi
    autoload -U url-quote-magic
    zle -N self-insert url-quote-magic
  fi
done

# http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html

zmodload -i zsh/computil
zmodload -i zsh/complist
zmodload -i zsh/langinfo

