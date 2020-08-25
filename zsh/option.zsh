#!/usr/bin/env zsh

# options
# -----------------------
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt bang_hist
setopt print_exit_value
setopt hist_verify
setopt PROMPT_SUBST
# setopt   no_hist_save_by_copy
setopt inc_append_history_time
setopt no_inc_append_history
setopt no_share_history
setopt extended_history
setopt AUTO_PUSHD

# setopt autolist
# setopt automenu
# setopt auto
# setopt LIST_PACKED
# setopt AUTO_PARAM_SLASH

HISTFILE="${ZCACHE}/.zsh_history"
HISTSIZE=20000
SAVEHIST=10000

# zstyle ':completion:incremental:*'  menu select=2 search
# zstyle :incremental stop-keys $'[\e\C-b\C-f\C-n\C-p\C-u-\C-x]'
# remove whether display xxx lines?
zstyle ':completion:*' list-prompt   ''
zstyle ':completion:*' select-prompt ''
zstyle ':completion:*' list-colors ''
# Group results by category
zstyle ':completion:*' group-name ''
# Automatically update PATH entries
zstyle ':completion:*' rehash true
# Don't try parent path completion if the directories exist
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' accet-exact '*(N)'
# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true
# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending
# zstyle ':completion:*:*:*:default' menu yes select search
zstyle ':completion:*' verbose true
# case insensetive
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' use-cache 1
zstyle ':completion:*' cache-path $ZCACHE
# menu if nb items > 2
zstyle ':completion:*' menu select=2 search
# zstyle ':completion:*' menu select=2
# Always use menu selection for `cd -`
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
# Nicer format for completion messages
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:corrections' format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings' format '%F{202}%BSorry, no matches for: %F{214}%d%b'
# Prettier completion for processes
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,args -w -w"
zstyle ':completion:*' single-ignored show

typeset -U PATH

autoload -Uz compinit
() {
  setopt extendedglob local_options
  local zcd=${ZCACHE}/.zcompdump
  local zcdl=${ZCACHE}/.zcompdump(N.m+1)
  local zcdc="$zcd.zwc"
  if [[ -f "$zcdl" ]]; then
    compinit -i -d "$zcd"
    { rm -f "$zcdc" && zcompile "$zcd" } &!
  else
    compinit -C -d "$zcd"
    { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
  fi
}
