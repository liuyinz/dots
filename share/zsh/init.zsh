#!/usr/bin/env zsh

# uncomment this and the last line for zprof info
# zmodload zsh/zprof

# use emacs-style keybinds
bindkey -e
bindkey "^V" clear-screen

export ALL_PROXY=http://$HTTP

### Oh-My-Zsh installtion
export ZSH=$CACHE_HOME/oh-my-zsh

if [[ ! -f $ZSH/oh-my-zsh.sh ]]; then
  echo "Installing OhMyZsh/ohmyzsh..."
  command mkdir -p $ZSH
  command git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH &&
    echo "Installation successful." || echo "The clone has failed."
fi

### Oh-My-Zsh Setting

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=3

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$ZSH/custom"

# If $ZSH_CACHE_DIR is already defined
# ZSH_COMPDUMP="$CACHE_HOME/.zcompdump"

# function
plugin_ensure() {
  local repo=https://github.com/$1.git
  local dir=$ZSH_CUSTOM/plugins/${2:-$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')}
  if [ ! -d $dir/.git ]; then
    echo "Installing $repo ..."
    command git clone $repo $dir &&
      echo "Installation successful." ||
      echo "The clone has failed."
  fi
}

plugin_ensure trapd00r/LS_COLORS
plugin_ensure skywind3000/z.lua
plugin_ensure Aloxaf/fzf-tab
plugin_ensure zsh-users/zsh-autosuggestions
plugin_ensure zsh-users/zsh-completions
plugin_ensure zdharma/fast-syntax-highlighting
plugin_ensure TamCore/autoupdate-oh-my-zsh-plugins autoupdate

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  osx
  github
  gitignore
  git-flow-avh
  colored-man-pages
  fzf
  sudo
  vscode
  dash
  # npm
  # custom plugins
  z.lua
  autoupdate
  zsh-completions
  fzf-tab
  zsh-autosuggestions
  fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export ALL_PROXY=

# --------------------------------
# custom setting
# ---------------------------------

# completions
autoload -U compinit && compinit

# LS_COLORS
command -v dircolors >/dev/null && . <(dircolors -b $ZSH_CUSTOM/plugins/LS_COLORS/LS_COLORS 2>/dev/null)

# autosuggestions
bindkey ",," autosuggest-accept
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# autoupdate
ZSH_CUSTOM_AUTOUPDATE_QUIET=true

# --------------------------------
# options
# ---------------------------------

setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt bang_hist
setopt print_exit_value
setopt PROMPT_SUBST
setopt inc_append_history_time
setopt no_inc_append_history
setopt no_share_history
setopt AUTO_PUSHD
# match hidden file
setopt GLOB_DOTS

# hist
export HISTFILE=$CACHE_HOME/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HISTTIMEFORMAT="[%F %T] "

# Automatically update PATH entries
zstyle ':completion:*' rehash true

# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true

source $DOT_DIR/share/zsh/alias.sh
source $DOT_DIR/share/zsh/func.sh

command -v kitty >/dev/null && . <(kitty + complete setup zsh 2>/dev/null)
command -v starship >/dev/null && eval "$(starship init zsh)"
command -v pip3 >/dev/null && eval "$(pip3 completion --zsh)"

command -v fnm >/dev/null && eval "$(fnm env)"

# uncomment the line below to profile
# zprof | less
