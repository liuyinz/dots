#!/usr/bin/env zsh

# uncomment this and the last line for zprof info
# zmodload zsh/zprof

# use emacs-style keybinds
bindkey -e
bindkey "^V" clear-screen

export ALL_PROXY=http://$HTTP

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# --------------------------------
# Functions
# ---------------------------------

z_ice() {
  zinit ice lucid "$@"
}

# --------------------------------
# Tool
# ---------------------------------

z_ice wait atclone="dircolors -b LS_COLORS > c.zsh" \
    atpull='%atclone' pick='c.zsh' nocompile'!'
zinit light trapd00r/LS_COLORS

zinit wait lucid light-mode for \
  skywind3000/z.lua \
  lukechilds/zsh-nvm \
  ael-code/zsh-colored-man-pages

zinit snippet OMZ::lib/git.zsh

zinit wait lucid light-mode for \
  OMZP::fzf \
  OMZP::sudo \
  OMZP::vscode \
  OMZP::dash \
  OMZP::github \
  OMZP::gitignore \
  OMZP::git-flow-avh \
  OMZP::nvm \
  OMZP::npm

# AUTOSUGGESTIONS, TRIGGER PRECMD HOOK UPON LOAD
z_ice wait atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions
bindkey ",," autosuggest-accept
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

z_ice wait
zinit light Aloxaf/fzf-tab

z_ice as"completion" blockf \
    atload"zicompinit;zicdreplay" atpull"zinit creinstall -q ."
zinit light zsh-users/zsh-completions

# must be last loaded
z_ice wait"1"
zinit light zdharma/fast-syntax-highlighting

export ALL_PROXY=

# --------------------------------
# options
# ---------------------------------

setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
# setopt HIST_IGNORE_ALL_DUPS
setopt hist_expire_dups_first
setopt hist_ignore_dups
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
setopt AUTO_PUSHD
# match hidden file
setopt GLOB_DOTS

# hist
export HISTFILE=$ZCACHE/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HISTTIMEFORMAT="[%F %T] "

# cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZCACHE

# Automatically update PATH entries
zstyle ':completion:*' rehash true

# 结果样式
zstyle ':completion:*' menu yes select # search
zstyle ':completion:*' list-grouped false
zstyle ':completion:*' list-separator ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*:descriptions' format '[%d]'

# color
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true

# smartcase completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'

source $DOT_DIR/share/zsh/alias.sh
source $DOT_DIR/share/zsh/func.sh

command -v kitty >/dev/null && . <(kitty + complete setup zsh 2>/dev/null)
command -v starship >/dev/null && eval "$(starship init zsh)"
command -v pip3 >/dev/null && eval "$(pip3 completion --zsh)"

# uncomment the line below to profile
# zprof | less
