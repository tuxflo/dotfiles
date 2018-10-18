
############# SETOPT ######################################

# http://zsh.sourceforge.net/Doc/Release/Options-Index.html

setopt \
  `# please no beeeeeeps` \
  NO_BEEP \
  `# list jobs in the long format by default` \
  LONG_LIST_JOBS \
  `# Save each command’s beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file` \
  EXTENDED_HISTORY \
  `# Do not enter command lines into the history list if they are duplicates of the previous event` \
  HIST_IGNORE_DUPS \
  `# If the internal history needs to be trimmed to add the current command line, setting this option will cause the oldest history event that has a duplicate to be lost before losing a unique event` \
  HIST_EXPIRE_DUPS_FIRST \
  `# remove command lines from the history list when the first character on the line is a space` \
  HIST_IGNORE_SPACE \
  `# remove the history (fc -l) command from the history list when invoked` \
  HIST_NO_STORE \
  `# remove superfluous blanks from each command line being added to the history list` \
  HIST_REDUCE_BLANKS \
  `# whenever the user enters a line with history expansion, don’t execute the line directly ` \
  HIST_VERIFY \
  `# add to history-file ` \
  APPEND_HISTORY \
  `# Make cd push the old directory onto the directory stack ` \
  AUTO_PUSHD \
  `# swapped the meaning of cd +1 and cd -1; we want them to mean the opposite of what they mean im csh ` \
  PUSHDMINUS \
  `# automatically list choices on an ambiguous completion` \
  AUTO_LIST \
  `# automatically use menu completion after the second consecutive request for completion` \
  AUTO_MENU \
  `# when listing files that are possible completions, show the type of each file with a trailing identifying mark` \
  LIST_TYPES \
  `# all unquoted arguments of the form identifier=expression appearing after the command name have file expansion` \
  MAGIC_EQUAL_SUBST \
  `# don’t push multiple copies of the same directory onto the directory stack` \
  PUSHD_IGNORE_DUPS \
  `# if unset, the cursor is set to the end of the word if completion is started. Otherwise it stays there and completion is done from both ends` \
  COMPLETE_IN_WORD \
  `# when the current word has a glob pattern, do not insert all the words resulting from the expansion but generate matches as for completion and cycle through them` \
  GLOB_COMPLETE \
  `# more patterns for filename generation` \
  EXTENDED_GLOB \
  `# extra completion` \
  COMPLETE_ALIASES \
  `# append a trailing ‘/’ to all directory names resulting from filename generation` \
  MARK_DIRS \
  `# remove any right prompt from display when accepting a command line. This may be useful with terminals with other cut/paste methods` \
  TRANSIENT_RPROMPT \
  `# allow comments even in interactive shells` \
  INTERACTIVECOMMENTS \
  `# if a completion is performed with the cursor within a word, and a full completion is inserted, the cursor is moved to the end of the word` \
  ALWAYS_TO_END \
  `# TODO` \
  MULTIOS \
  `# TODO` \
  CDABLEVARS \
  `# the prompt string is first subjected to parameter expansion, command substitution and arithmetic expansion` \
  PROMPT_SUBST

unsetopt \
  `# do not set auto_name_dirs because it messes up prompts ` \
  AUTO_NAME_DIRS \
  `# do not autoselect the first completion entry ` \
  MENU_COMPLETE \
  `# do not freezes output to the terminal until you type ^q `\
  FLOWCONTROL \
  `# do not print the directory stack after pushd or popd` \
  PUSHD_SILENT \
  `# if a command is not in the hash table, and there exists an executable directory by that name, perform the cd command to that directory` \
  AUTO_CD \
  `# this option both imports new commands from the history file, and also causes your typed command ` \
  SHARE_HISTORY \
  `# do not beeep, please ` \
  HIST_BEEP

