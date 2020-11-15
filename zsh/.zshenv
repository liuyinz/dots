#!/usr/bin/env zsh

# uncomment line below to  debug zshenv
# set -x

# Zsh
# -----------------------
export CONFIG_DIR=$HOME/.config
export CACHE_DIR=$HOME/.cache

export ZCACHE=$CACHE_DIR/zsh

# ZPLUG
# -----------------------
export ZPLUG_THREADS=32

# Env
# -----------------------
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# self-defined
export PATH=$HOME/bin:$PATH

# terminfo
# export TERM=xterm-24bit

# proxy
export SOCKS=127.0.0.1:4781
export HTTPS=127.0.0.1:4780
export PROXYCHAINS_CONF_FILE=$CONFIG_DIR/proxychains.conf

# misc
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"
export PAGER="less --tabs=4"
export GIT_PAGER="diff-so-fancy | less --tabs=4 -RFX"
export LESSHISTFILE=$CACHE_DIR/.lesshst
# gls
export TIME_STYLE="+%y-%m-%d %H:%M"

# Tool
# -----------------------
# homebrew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles

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
export RIPGREP_CONFIG_PATH=$HOME/.rg/.ripgreprc

# z.lua
export _ZL_DATA=$ZCACHE/.zlua
export _ZL_ADD_ONCE=1
export _ZL_MATCH_MODE=1
export _ZL_HYPHEN=1
export _ZL_ROOT_MARKERS=".git,.svn,.hg,.root,package.json"
export _ZL_EXCLUDE_DIRS="$CACHE_DIR,$HOME/Library"

# fzf
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS=" \
    --ansi \
    --reverse \
    --cycle \
    --multi \
    --sort \
    --marker '+' \
    --inline-info \
    --height '70%' \
    --color=dark,bg:#282c34,bg+:#2c323c,fg:#979eab,fg+:#aa6e90 \
    --color=hl+:#98c379,hl:#98c379,pointer:#aa6e90,marker:#aa6e90,gutter:#282c34 \
    --color=info:#61afef,prompt:#61afef,spinner:#98c379,header:#e5c07b"

# Lang
# -----------------------
# pip
export PATH=$HOME/.local/python/bin:$PATH
export PYTHONPATH=$HOME/.local/python

# rust
export PATH=$HOME/.cargo/bin:$PATH
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

# Node
export NVM_DIR="$HOME/.nvm"
export PATH="$NVM_DIR/versions/node/v14.14.0/bin:$PATH"
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true

# Ruby
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=/usr/local/lib/ruby/gems/2.6.0/bin:$PATH
