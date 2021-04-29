#!/usr/bin/env bash


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
