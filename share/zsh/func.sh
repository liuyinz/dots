#!/usr/bin/env bash

# Chorme
# -----------------------
# h - browse chrome history
h() {
  local cols sep
  cols=$((COLUMNS / 3))
  sep='{::}'

  cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h

  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
    awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
    fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' |
    xargs open &>/dev/null
}

# b  - browse chrome Bookmarks
b() {

  which jq >/dev/null 2>&1 || echo "jq is not installed !!!"

  local bookmarks_path=~/Library/Application\ Support/Google/Chrome/Default/Bookmarks
  local jq_script='def ancestors: while(. | length >= 2; del(.[-1,-2])); . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'
  jq -r $jq_script <"$bookmarks_path" |
    sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' |
    fzf --ansi --multi --no-hscroll --tiebreak=begin |
    awk 'BEGIN { FS = "\t" } { print $2 }' |
    xargs open &>/dev/null
}

# PIP
# -----------------------
# [P]ip [I]nstall
ppi() {
  local inst
  inst=$(curl -s "$(pip3 config get global.index-url)/" |
    grep '</a>' | sed 's/^.*">//g' | sed 's/<.*$//g' |
    eval "fzf ${FZF_DEFAULT_OPTS} --exact --header='[pip:install]'")

  if [[ $inst ]]; then
    for prog in $(echo "$inst"); do
      pip3 install --user "$prog"
    done
  fi
}

# [P]ip [U]pgrade
ppu() {
  local inst
  inst=$(pip3 list --outdated | tail -n +3 | awk '{print $1}' |
    eval "fzf ${FZF_DEFAULT_OPTS} --header='[pip:upgrade]'")

  if [[ $inst ]]; then
    for prog in $(echo "$inst"); do
      pip3 install --user --upgrade "$prog"
    done
  fi
}

# [P]ip [C]lean
ppc() {
  local inst
  inst=$(pip3 list | tail -n +3 | awk '{print $1}' |
    eval "fzf ${FZF_DEFAULT_OPTS} --header='[pip:uninstall]'")

  if [[ $inst ]]; then
    for prog in $(echo "$inst"); do
      pip3 uninstall --yes "$prog"
    done
  fi
}

# BREW
# ------------------

# [B]rew [I]nstall [P]lugin
bip() {
  local inst
  inst=$(brew formulae | eval "fzf ${FZF_DEFAULT_OPTS} \
    --exact --header='[brew:install]'")

  if [[ $inst ]]; then
    for prog in $(echo "$inst"); do
      if brew ls --versions $prog &>/dev/null; then
        echo "$prog already installed."
      else
        brew install $prog
      fi
    done
  fi
}

# [B]rew [C]ask [I]nstall [P]lugin
bci() {
  local inst
  inst=$(brew search --casks | eval "fzf ${FZF_DEFAULT_OPTS} \
    --exact --header='[brew cask:install]'")

  if [[ $inst ]]; then
    for prog in $(echo "$inst"); do
      if brew ls --cask --versions $prog &>/dev/null; then
        echo "$prog already installed."
      else
        brew install $prog
      fi
    done
  fi
}

# [B]rew [C]lean [P]lugin
bcp() {
  local uninst
  uninst=$(brew leaves | eval "fzf ${FZF_DEFAULT_OPTS} \
    --header='[brew formulae:uninstall]'")

  if [[ $uninst ]]; then
    for prog in $(echo "$uninst"); do
      brew uninstall "$prog"
    done
  fi
}

# [B]rew [C]ask [C]lean [P]lugin
bcc() {
  local uninst
  uninst=$(brew list --cask | eval "fzf ${FZF_DEFAULT_OPTS} \
    --header='[brew cask:uninstall]'")

  if [[ $uninst ]]; then
    for prog in $(echo "$uninst"); do
      brew uninstall --cask "$prog"
    done
  fi
}

# [B]rew [U]pdate [P]lugin
bup() {
  brew update
  local upd
  upd=$(brew outdated --greedy | eval "fzf ${FZF_DEFAULT_OPTS} \
    --header='[brew:update]'")

  if [[ $upd ]]; then
    for prog in $(echo "$upd"); do
      brew upgrade --greedy "$prog"
    done
  fi
}

# [B]rew [U]n[T]ap
but() {
  local upd
  upd=$(brew tap | eval "fzf ${FZF_DEFAULT_OPTS} \
    --header='[brew untap:]'")

  if [[ $upd ]]; then
    for prog in $(echo "$upd"); do
      brew untap "$prog"
    done
  fi
}

# PATH
# ------------------
# [F]ind [P]ath
# list directories in $PATH,press [enter] on an entry to list,press [escape] to go back,[escape] twice to exit completely

fp() {
  local loc
  loc=$(echo "$PATH" | sed -e $'s/:/\\\n/g' |
    eval "fzf ${FZF_DEFAULT_OPTS} --header='[find:path]'")

  if [[ -d $loc ]]; then
    rg --files "$loc" | rev | cut -d"/" -f1 | rev | eval \
      "fzf ${FZF_DEFAULT_OPTS} --header='[find:exe] => ${loc}' \
      >/dev/null"
    fp
  fi
}

# [F]ind [FP]ath
# list directories in $FPATH,press [enter] on an entry to list,press [escape] to go back,[escape] twice to exit completely
ffp() {
  local loc
  loc=$(echo "$FPATH" | sed -e $'s/:/\\\n/g' |
    eval "fzf ${FZF_DEFAULT_OPTS} --header='[find:path]'")

  if [[ -d $loc ]]; then
    rg --files "$loc" | rev | cut -d"/" -f1 | rev | eval \
      "fzf ${FZF_DEFAULT_OPTS} --header='[find:exe] => ${loc}' \
      >/dev/null"
    fp
  fi
}

# PROCESS
# ------------------
# mnemonic: [K]ill [P]rocess
# show output of "ps -ef", use [tab] to select one or multiple entries
# press [enter] to kill selected processes and go back to the process list.
# or press [escape] to go back to the process list. Press [escape] twice to exit completely.

kp() {
  local pid
  pid=$(ps -ef | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} \
    --header='[kill:process]'" | awk '{print $2}')

  if [ "x$pid" != "x" ]; then
    echo "$pid" | xargs kill -"${1:-9}"
    kp "$@"
  fi
}

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

# Create a folder and move into it in one command
# -------------------
mcd() { mkdir -p "$@" && cd "$_" || return; }

# brew clean useless dependence
# -------------------
# [B]rew [R]emove [D]ependence
brd() {
  export HOMEBREW_NO_AUTO_UPDATE=1
  brew bundle dump -q -f --file="/tmp/Brewfile"
  brew bundle -f --cleanup --file="/tmp/Brewfile"
  rm /tmp/Brewfile
  # brew bundle dump -f --file=- | brew bundle --cleanup --file=-
}

# Remove .DS_Store files recursively in a directory, default .
# -------------------
function rmdsstore() {
  find "${@:-.}" -type f -name .DS_Store -delete
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
