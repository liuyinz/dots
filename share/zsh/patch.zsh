#!/usr/bin/env zsh

# Aliases
# default
# -----------------------
alias zr='source ~/.zshrc'

alias ls='gls -F --color --group-directories-first'
alias ll='gls -lhF --color --group-directories-first'
alias la='gls -AF --color --group-directories-first'
alias lla='gls -lhAF --color --group-directories-first'

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
alias etest="emacs -Q --daemon --load ~/.config/emacs/init-mini.el"

# bonclay
alias bb='bonclay backup'
alias bs='bonclay sync'
alias br='bonclay restore'

# Git
# -----------------------
alias ga='git add'
alias gai='git add --interactive'
alias gaa='git add --all'
alias gae='git add --edit'
alias gau='git add --update'

alias gc='git commit'
alias gcm='git commit -m '
alias gcam='git commit -am '
alias gcd='git commit --amend'
alias gcdn='git commit --amend --no-edit'

alias ge='git restore'

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
alias gwm='git switch $(git_main_branch)'
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
alias grbm='git rebase $(git_main_branch)'

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
alias gsmp='git submodule update --remote --merge --jobs "$(nproc)"'
alias gsmj='pfs -c "git pull origin" -j 16'
# git pull origin master --recurse-submodules

# alias gsmp='git submodule foreach --recursive "git switch $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master); git pull"'

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
alias gdd='git diff $(git_main_branch)...HEAD'
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

# brew remove useless dependence
# -------------------
# [B]rew [R]emove [D]ependence
brd() {
  export HOMEBREW_NO_AUTO_UPDATE=1
  brew bundle dump -q -f --file="/tmp/Brewfile"
  brew bundle -f --cleanup --file="/tmp/Brewfile"
  rm /tmp/Brewfile
}

# [B]rew [I]nstall [O]lder Version Formula
# -------------------
bio() {
  local pwd
  pwd=$(pwd)
  cd $HOMEBREW_FORMULA || return
  if git cat-file -e $2 2>/dev/null; then
    if [ -e $1.rb ]; then
      echo "Installing..."
      git checkout $2 $1.rb
      HOMEBREW_NO_AUTO_UPDATE=1 brew install $1
    else
      echo "Error ! file $1.rb not exists."
    fi
  else
    echo "Error ! Commit $2 not exists."
  fi
  cd $pwd || exit
}

# Remove .DS_Store files recursively in a directory, default .
# ------------------
function rmdsstore() {
  find "${@:-.}" -type f -name .DS_Store -delete
}

# Create a folder and move into it in one command
# -------------------
mcd() { mkdir -p "$@" && cd "$_" || return; }

# GitRebuild
# ------------------
grebuild() {
  for BR in $(
    git branch --format="%(refname:lstrip=2)"
  ); do
    git checkout "$BR"
    git checkout --orphan "${BR}_temp"
    git add -A
    git commit -m "Initial commit"
    git branch -D "$BR"
    git branch -m "$BR"
  done
  git gc --aggressive --prune=all
  # git push -f --all
}

# The name of the current branch
current_branch() {
  git_current_branch
}

# Check if main exists and use instead of master
git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in main trunk; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo master
}

update_all() {
  upgrade_ohl_my_zsh
  rm "$ZSH_EVALCACHE_DIR"/init-*.sh
  rm ~/.zcompdump*
}
