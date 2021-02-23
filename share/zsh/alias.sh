#!/usr/bin/env bash

# Aliases
# default
# -----------------------
alias reload='source ~/.zshrc'

alias ls='gls -F --color --group-directories-first'
alias ll='gls -lhF --color --group-directories-first'
alias la='gls -AF --color --group-directories-first'
alias lla='gls -lhAF --color --group-directories-first'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir

alias du="du -h"
alias df="df -h"

alias ap="ALL_PROXY=http://$HTTP"
alias eap="export ALL_PROXY=http://$HTTP"
alias uap="export ALL_PROXY="
# alias ssha='ssh root@157.245.125.95'

# App
# -----------------------
alias asr='alias | rg'
alias rt='trash'
alias rr="ranger"
alias vi='nvim'
alias lg='lazygit'
alias pc="proxychains4"

# bonclay
alias bb='bonclay backup'
alias bs='bonclay sync'
alias br='bonclay restore'

#pfs
alias gsmj='pfs -c "git pull origin" -j 16'

# Scripts
# -----------------------
# alias wt='when-changed -v -r -1 -s ./ pytest -s '

# Git
# -----------------------
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

alias ge='git restore'
alias gec='git restore --staged'
alias ges='git restore -s'
alias gecs='git restore --staged -s'
alias gea='git restore --staged --worktree -s'

alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gsts='git stash show --stat -p'
alias gstb='git stash branch'

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

alias gm='git merge'
alias gmt='git mergetool'
alias gmd='git merge develop'
alias gmo='git merge origin/master'
alias gmu='git merge upstream/master'

alias grb='git rebase'
alias grbi='git rebase -i'
alias grbd='git rebase develop'
alias grbm='git rebase master'

alias gp='git push'
alias gpo='git push origin "$(git_current_branch)"'
alias gpa='git push --all origin'
alias gpt='git push --tags origin'
alias gpp='git push --prune origin'
alias gpd='git push --delete'
alias gpu='git push --set-upstream origin $(git_current_branch)'

alias gf='git fetch'
alias gfo='git fetch origin'
alias gfu='git fetch upstream'
alias gfa='git fetch --all'

alias gcl='git clone'
alias gclr='git clone --recurse-submodules'

alias gr='git remote'
alias gra='git remote add'
alias grr='git remote remove'

alias gpl='git pull'
alias gplu='git pull upstream $(git_current_branch)'
alias gplo='git pull origin "$(git_current_branch)"'
alias gplr='git pull --rebase --autostash -v'

# submodule
alias gsm='git submodule'
alias gsma='git submodule add'
alias gsmaf='git submodule add --depth 1 --force'
alias gsman='git submodule add --depth 1 --name'
alias gsms='git submodule status'
alias gsmi='git submodule init'
alias gsmd='git submodule deinit'
alias gsmu='git submodule update'
alias gsmf='git submodule foreach'
alias gsmp='git submodule foreach "git pull origin"'

alias gs='git status -sb'
alias gbl='git blame -w --abbrev=6'
alias gslog='git shortlog -nc'

alias gl='git log --graph'
alias glt='git log --graph --stat'
alias gla='git log --graph --all'
alias glta='git log --graph --all --stat'

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

## Worktree & Index
alias gclean='git clean -id'
alias grm='git rm -r -f'
alias grmc='git rm -r --cached'

alias gcp='git cherry-pick'
alias grv='git revert'
alias grvv='git revert HEAD'
alias grvn='git revert --no-commit'

alias grt='git reset'
alias grth='git reset --hard'
alias grts='git reset --soft'

# alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
# alias gsps='git show --pretty=short --show-signature'

# alias gtl='gtl(){ git tag --sort=-v:refname -n -l "${1}*" }; noglob gtl'
# alias gunignore='git update-index --no-assume-unchanged'
# alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'

# alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
# alias gfg='git ls-files | grep'
# alias gignored='git ls-files -v | grep "^[[:lower:]]"'
# alias glwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'