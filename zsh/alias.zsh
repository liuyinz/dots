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
# alias python='/usr/local/bin/python3'
# alias pip='/usr/local/bin/pip3'
alias rt='rmtrash'

# bonclay
alias bb='cd ~/dots && bonclay backup bonclay.yaml'
alias bs='cd ~/dots && bonclay sync bonclay.yaml'
alias br='cd ~/dots && bonclay restore bonclay.yaml'

# Scripts
# -----------------------
# alias wt='when-changed -v -r -1 -s ./ pytest -s '

# Git
# -----------------------
## Query
alias gs='git status -sb'
alias gbl='git blame -w --abbrev=6'
alias gslog='git shortlog -nc'

alias gl='git log --graph'
alias glt='git log --graph --stat'
alias glp='git log --graph --stat -p'
alias gla='git log --graph --all'
alias glta='git log --graph --all --stat'
alias glpa='git log --graph --all --stat -p'

## Diff
alias gd='git diff'
alias gdc='git diff --cached'
alias gds='git diff --stat'
alias gdcs='git diff --stat --cached'
alias gdd='git diff master...HEAD'
alias gdt='git difftool'

## Debug
alias gbs='git bisect'
alias gbss='git bisect start'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsk='git bisect skip'
alias gbsr='git bisect run'
alias gbsl='git bisect log'
alias gbsr='git bisect reset'

## Branch
alias gb='git branch'
alias gbd='git branch -d'
alias gbu='git branch -u origin/$(git_current_branch)'
alias gbv='git branch --list -vv -a'
alias gbm='git branch -vv --merged'

alias gw='git switch'
alias gwm='git switch master'
alias gwd='git switch develop'
alias gwc='git switch -c'
alias gwt='git switch --track'

# alias gk='git checkout'
# alias gkb='git checkout -b'
# alias gkt='git checkout --track'
# alias gkm='git checkout master'
# alias gkd='git checkout develop'

## Worktree & Index
alias gclean='git clean -id'
alias grm='git rm -r'
alias grmc='git rm -r --cached'

alias ge='git restore'
alias gec='git restore --staged'
alias ges='git restore -s'
alias gecs='git restore --staged -s'
alias gea='git restore --staged --worktree -s'

alias ga='git add'
alias gai='git add --interactive'
alias gaa='git add --all'
alias gae='git add --edit'
alias gap='git add --patch'
alias gau='git add --update'
alias gaf='git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 git add'
alias gafp='git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 -o -t git add -p'

alias gc='git commit'
alias gcm='git commit -m '
alias gcam='git commit -am '
alias gcd='git commit --amend'
alias gcdn='git commit --amend --no-edit'

alias gcp='git cherry-pick'
alias grv='git revert'
alias grvv='git revert HEAD'
alias grvn='git revert --no-commit'

alias grt='git reset'
alias grth='git reset --hard'
alias grts='git reset --soft'

alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gsts='git stash show --stat -p'
alias gstb='git stash branch'

## Merge & Rebase
alias gm='git merge'
alias gmt='git mergetool'
alias gmo='git merge origin/master'
alias gmu='git merge upstream/master'

alias grb='git rebase'
alias grbi='git rebase -i'
alias grbd='git rebase develop'
alias grbm='git rebase master'

## Repos
alias gcl='git clone'
alias gclr='git clone --recurse-submodules'

alias gr='git remote'
alias gra='git remote add'
alias grr='git remote remove'

alias gf='git fetch'
alias gfo='git fetch origin'
alias gfu='git fetch upstream'
alias gfa='git fetch --all --prune'

alias gp='git push'
alias gpo='git push origin "$(git_current_branch)"'
alias gpa='git push --all origin'
alias gpt='git push --tags origin'
alias gpp='git push --prune origin'
alias gpd='git push --delete'
alias gpu='git push --set-upstream origin $(git_current_branch)'

alias gpl='git pull'
alias gplu='git pull upstream $(git_current_branch)'
alias gplo='git pull origin "$(git_current_branch)"'
alias gplr='git pull --rebase --autostash -v'

# submodule
alias gsm='git submodule'
alias gsma='git submodule add'
alias gsms='git submodule status'
alias gsmi='git submodule init'
alias gsmd='git submodule deinit'
alias gsmu='git submodule update'
alias gsmf='git submodule foreach'
alias gsmp='git submodule foreach "git pull origin master"'

# alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
# alias gsps='git show --pretty=short --show-signature'

# alias gsu='git submodule update'
# alias gsw='git switch'
# alias gswc='git switch -c'
# alias gtl='gtl(){ git tag --sort=-v:refname -n -l "${1}*" }; noglob gtl'
# alias gts='git tag -s'
# alias gtv='git tag | sort -V'
# alias gunignore='git update-index --no-assume-unchanged'
# alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'

# alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
# alias gfg='git ls-files | grep'
# alias gignored='git ls-files -v | grep "^[[:lower:]]"'
# alias glwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
