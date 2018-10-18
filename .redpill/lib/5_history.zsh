## command history configuration

# info: You should be sure to set the value of HISTSIZE to a larger number than SAVEHIST in order to give you some room for the duplicated events
HISTSIZE=20000
SAVEHIST=10000

# Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

if [ -z "$HISTFILE" ]; then
  HISTFILE=$HOME/.zsh_history
fi
