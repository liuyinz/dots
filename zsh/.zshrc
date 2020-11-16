#!/usr/bin/env zsh

# uncomment this and the last line for zprof info
# zmodload zsh/zprof

export ALL_PROXY=http://${HTTP}

# use emacs-style keybinds
bindkey -e

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

z_lucid() {
    zinit ice lucid "$@"
}

zi_a() {
    z_lucid wait'0a' "$@"
}
zi_b() {
    z_lucid wait'0b' "$@"
}

zi_c() {
    z_lucid wait'0c' "$@"
}

zi_pr() {
    zi_a as'program' "$@"
}

zi_cm() {
    zi_a as'completion' "$@"
}


# --------------------------------
# theme
# --------------------------------
z_lucid from"gh-r" as"program" bpick"*apple-darwin*" pick"starship" atload'eval "$(starship init zsh)"'
zinit light starship/starship

# zinit ice from"gh-r" as"command" atload'eval "$(starship init zsh)"'
# zinit load starship/starship

# --------------------------------
# Tool
# ---------------------------------

z_lucid
zinit light skywind3000/z.lua

# install NVM
z_lucid
zinit light lukechilds/zsh-nvm

zinit wait lucid for \
    OMZP::fzf \
    OMZP::sudo \
    OMZP::colored-man-pages \
    OMZP::vscode \
    OMZP::dash \
    OMZP::github \
    OMZP::gitignore \
    OMZP::nvm \
    OMZP::npm


# --------------------------------
# Completion Colletion
# ---------------------------------

# git-extra
zi_cm has'git-extras'
zinit snippet https://github.com/tj/git-extras/blob/master/etc/git-extras-completion.zsh

# tldr
zi_cm has'tldr' mv"zsh_tealdeer -> _tldr"
zinit snippet https://github.com/dbrgn/tealdeer/blob/master/zsh_tealdeer

zi_cm has'hub' mv'hub.zsh_completion -> _hub'
zinit snippet https://github.com/github/hub/raw/master/etc/hub.zsh_completion

zinit lucid wait as"completion" for \
    OMZP::pip/_pip \
    OMZP::pylint/_pylint \
    OMZP::nvm/_nvm


# --------------------------------
# Zsh
# ---------------------------------
# AUTOSUGGESTIONS, TRIGGER PRECMD HOOK UPON LOAD
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
zi_a atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions
bindkey ",," autosuggest-accept

# fzf-tab
# z_lucid wait'1'
# zinit light Aloxaf/fzf-tab

zi_c pick"zsh/fzf-zsh-completion.sh"
zinit light lincheney/fzf-tab-completion

zi_c blockf atpull"zinit creinstall -q ."
zinit light zsh-users/zsh-completions

# SYNTAX HIGHLIGHTING
zi_c atinit"zpcompinit;zpcdreplay"
zinit light zdharma/fast-syntax-highlighting
# zinit ice lucid wait"5"; zinit light zsh-users/zsh-syntax-highlighting

# generate by cmd
autoload -Uz compinit
compinit
command -v kitty >/dev/null && . <(kitty + complete setup zsh 2>/dev/null)
# command -v pip >/dev/null && . <(pip completion --zsh)

# options
# -----------------------
# hist
export HISTFILE="${ZCACHE}/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HISTTIMEFORMAT="[%F %T] "

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

# setopt autolist
# setopt automenu
# setopt auto
# setopt LIST_PACKED
# setopt AUTO_PARAM_SLASH


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

# typeset -U PATH

source ~/.zsh/alias.sh
source ~/.zsh/func.sh

export ALL_PROXY=
# uncomment the line below to profile
# zprof | less
