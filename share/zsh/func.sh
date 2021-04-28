#!/usr/bin/env bash

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
