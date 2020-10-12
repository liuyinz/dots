#!/usr/bin/env zsh

# uncomment line below to  debug zshenv
# set -x

# Zsh
# -----------------------
export CACHE_DIR=$HOME/.cache
export ZCACHE=$HOME/.cache/zsh

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

# misc
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="code"
export PAGER=less
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
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# z.lua
export _ZL_DATA=$ZCACHE/.zlua
export _ZL_ADD_ONCE=1
export _ZL_MATCH_MODE=1
export _ZL_HYPHEN=1
export _ZL_ROOT_MARKERS=".git,.svn,.hg,.root,package.json"
# export _ZL_EXCLUDE_DIRS=(.Library Library)

# fzf
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS=" \
    --ansi \
    --reverse \
    --cycle \
    --multi \
    --sort \
    --inline-info \
    --height '70%' \
    --color=16,fg+:#AA6E90"

# Lang
# -----------------------
# pip
export PATH=$HOME/.local/python/bin:$PATH
export PYTHONPATH=$HOME/.local/python

# rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
# export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
# export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup

# Node
export NVM_DIR="$HOME/.nvm"
export PATH="$NVM_DIR/versions/node/v14.13.1/bin:$PATH"
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true

# Ruby
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=/usr/local/lib/ruby/gems/2.6.0/bin:$PATH
# export LDFLAGS="-L/usr/local/opt/ruby/lib"
# export CPPFLAGS="-I/usr/local/opt/ruby/include"
# export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
