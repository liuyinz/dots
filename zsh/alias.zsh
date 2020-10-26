#!/usr/bin/env zsh

# Aliases
# default
# -----------------------
alias reload='source ~/.zshrc'

alias ls='gls -F --color --group-directories-first'
alias ll='gls -lhF --color --group-directories-first'
alias la='gls -AF --color --group-directories-first'
alias lla='gls -lhAF --color --group-directories-first'

alias du="du -h"
alias df="df -h"
# alias sort="sort -hr"
alias grep='grep -E --color=auto'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# alias ap='ALL_PROXY=socks5://127.0.0.1:1080'
# alias setp="export ALL_PROXY=socks5://127.0.0.1:1080"
alias ap='ALL_PROXY=socks5://127.0.0.1:4781'
alias eap="export ALL_PROXY=socks5://127.0.0.1:4781"
alias ueap="unset ALL_PROXY"
# alias ssha='ssh root@157.245.125.95'

# App
# -----------------------
# alias git='hub'
alias asr='alias | rg'
alias rt='rmtrash'
alias vi='nvim'
alias lg='lazygit'

# bonclay
alias bb='cd ~/dots && bonclay backup bonclay.yaml'
alias bs='cd ~/dots && bonclay sync bonclay.yaml'
alias br='cd ~/dots && bonclay restore bonclay.yaml'

# Scripts
# -----------------------
# alias wt='when-changed -v -r -1 -s ./ pytest -s '
