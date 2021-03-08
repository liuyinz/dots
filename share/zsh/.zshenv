#!/usr/bin/env zsh

# uncomment line below to  debug zshenv
# set -x

# Zsh
# -----------------------
export CONFIG_HOME=$HOME/.config
export CACHE_HOME=$HOME/.cache
export DATA_HOME=$HOME/.local
export ZCACHE=$CACHE_HOME/zcache
export DOT_DIR=$DATA_HOME/dotfile

# misc
# -----------------------
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TIME_STYLE="+%y-%m-%d %H:%M"
export PAGER="less --tabs=4"
export LESSHISTFILE=$CACHE_HOME/.lesshst

# PATH
# -----------------------
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$DATA_HOME/bin:$PATH

# proxy
export SOCKS=127.0.0.1:4781
export HTTP=127.0.0.1:4780

# export EDITOR="nvim"
export EDITOR="ecc"
export GIT_PAGER="diff-so-fancy | less --tabs=4 -RFX"

# Tool
# -----------------------
# homebrew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
export HOMEBREW_FORMULA=/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula

# curl
export PATH="/usr/local/opt/curl/bin:$PATH"
# coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# findutils
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
# other
export PATH="/usr/local/opt/gnu-time/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

# Ripgrep
export RIPGREP_CONFIG_PATH=$CONFIG_HOME/.ripgreprc

# proxychains-ng
export PROXYCHAINS_CONF_FILE=$CONFIG_HOME/proxychains.conf
# bat
export BAT_CONFIG_PATH=$CONFIG_HOME/bat.conf
# z.lua
export _ZL_DATA=$ZCACHE/.zlua
export _ZL_ECHO=1
export _ZL_ADD_ONCE=0
export _ZL_MATCH_MODE=0
export _ZL_HYPHEN=1
export _ZL_ROOT_MARKERS=".git,.svn,.hg,.root,package.json"
export _ZL_EXCLUDE_DIRS="$CACHE_HOME,$HOME/Library"

# fzf
# export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git"'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS=" \
    --reverse \
    --cycle \
    --multi \
    --sort \
    --history=$ZCACHE/.fzf_history \
    --marker='*' \
    --info=inline\
    --margin=0,0,0,1 \
    --height='60%' \
    --color=dark,bg:#242730,fg:#bbc2cf:dim,hl:#7bc275:bold \
    --color=fg+:#d8dde6,bg+:#3d4451,hl+:#7bc275:bold,pointer:#f76582:bold \
    --color=gutter:#242730,marker:#f76582:bold,header:#51afef:dim \
    --color=prompt:#51afef:dim,query:#7bc275:bold,spinner:#fcce7b:dim,info:#c57bdb:bold \
    --bind=change:first,btab:up+toggle \
    --bind=ctrl-n:down,ctrl-p:up,alt-n:next-history,alt-p:previous-history \
    --bind=ctrl-u:cancel,ctrl-l:jump,ctrl-t:toggle-all,ctrl-v:clear-selection"

# Lang
# -----------------------
# pip
export PYTHONUSERBASE=$DATA_HOME/python/3.8
export PATH=$PYTHONUSERBASE/bin:$PATH

# rust
export CARGO_HOME=$DATA_HOME/cargo
export PATH=$CARGO_HOME/bin:$PATH
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

# Node
export NVM_DIR=$DATA_HOME/nvm
export PATH="$NVM_DIR/versions/node/v15.10.0/bin:$PATH"
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true

# Golang
export GOPATH=$HOME/Code/go
export PATH=$GOPATH/bin:$PATH
export GO111MODULE=on
export GOPROXY=https://goproxy.cn
export GOSUMDB=sum.golang.google.cn
