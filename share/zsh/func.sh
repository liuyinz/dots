#!/usr/bin/env bash

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
