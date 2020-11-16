#!/usr/bin/env zsh

# uncomment this and the last line for zprof info
# zmodload zsh/zprof

# use emacs-style keybinds
bindkey -e

# Zplug Start
# -----------------------

# zplug configruation
if [[ ! -d "${ZPLUG_HOME}" ]]; then
	if [[ ! -d "${ZCACHE}/zplug" ]]; then
		git clone https://github.com/zplug/zplug "${ZCACHE}/zplug"
		if [[ $? != 0 ]]; then
			function zplug() {
				return 1
			}
		fi
	fi
	export ZPLUG_HOME="${ZCACHE}/zplug"
fi

[[ -d "${ZPLUG_HOME}" ]] && source "${ZPLUG_HOME}/init.zsh"

# Zplug pluggin
zplug "zplug/zplug", hook-build:"zplug --self-manage"
# zplug 'romkatv/powerlevel10k', as:theme, depth:1
zplug 'zsh-users/zsh-autosuggestions'
zplug 'liuyinz/zsh-completions', defer:2
zplug "zdharma/fast-syntax-highlighting", defer:3
zplug "lincheney/fzf-tab-completion"
# tool
zplug "skywind3000/z.lua"
zplug "plugins/osx", from:oh-my-zsh
# zplug "plugins/gnu-utils", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/fzf", from:oh-my-zsh
zplug "plugins/vscode", from:oh-my-zsh
zplug "plugins/dash", from:oh-my-zsh
# git
zplug "plugins/github", from:oh-my-zsh
zplug "plugins/gitignore", from:oh-my-zsh
# rust
zplug "plugins/rust", from:oh-my-zsh
zplug "plugins/rustup", from:oh-my-zsh
zplug "plugins/cargo", from:oh-my-zsh
# nvm
zplug "lukechilds/zsh-nvm" #install nvm
zplug "plugins/nvm", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
# python
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/pylint", from:oh-my-zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
	zplug install
fi

# Zplug load  --verbose
zplug load

# plug setting
# -----------------------
if zplug check 'zsh-users/zsh-autosuggestions'; then
	ZSH_AUTOSUGGEST_USE_ASYNC=1
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
	bindkey ",," autosuggest-accept
fi

if zplug check 'lincheney/fzf-tab-completion'; then
	source "${ZPLUG_REPOS}/lincheney/fzf-tab-completion/zsh/fzf-zsh-completion.sh"
	# zstyle ':completion:*' fzf-search-display true
fi

# options
# -----------------------
# hist
export HISTFILE="${ZCACHE}/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HISTTIMEFORMAT="[%F %T] "

setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

setopt HIST_FIND_NO_DUPS
# setopt HIST_IGNORE_ALL_DUPS

setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt bang_hist
setopt print_exit_value
setopt hist_verify
setopt PROMPT_SUBST
# setopt   no_hist_save_by_copy
setopt inc_append_history_time
setopt no_inc_append_history
setopt no_share_history
setopt AUTO_PUSHD

# setopt autolist
# setopt automenu
# setopt auto
# setopt LIST_PACKED
# setopt AUTO_PARAM_SLASH


# zstyle ':completion:incremental:*'  menu select=2 search
# zstyle :incremental stop-keys $'[\e\C-b\C-f\C-n\C-p\C-u-\C-x]'
# remove whether display xxx lines?
zstyle ':completion:*' list-prompt   ''
zstyle ':completion:*' select-prompt ''
zstyle ':completion:*' list-colors ''
# Group results by category
zstyle ':completion:*' group-name ''
# Automatically update PATH entries
zstyle ':completion:*' rehash true
# Don't try parent path completion if the directories exist
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' accet-exact '*(N)'
# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true
# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending
# zstyle ':completion:*:*:*:default' menu yes select search
zstyle ':completion:*' verbose true
# case insensetive
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' use-cache 1
zstyle ':completion:*' cache-path $ZCACHE
# menu if nb items > 2
zstyle ':completion:*' menu select=2 search
# zstyle ':completion:*' menu select=2
# Always use menu selection for `cd -`
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
# Nicer format for completion messages
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:corrections' format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings' format '%F{202}%BSorry, no matches for: %F{214}%d%b'
# Prettier completion for processes
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,args -w -w"
zstyle ':completion:*' single-ignored show

typeset -U PATH

autoload -Uz compinit
() {
  setopt extendedglob local_options
  local zcd=${ZCACHE}/.zcompdump
  local zcdl=${ZCACHE}/.zcompdump(N.m+1)
  local zcdc="$zcd.zwc"
  if [[ -f "$zcdl" ]]; then
    compinit -i -d "$zcd"
    { rm -f "$zcdc" && zcompile "$zcd" } &!
  else
    compinit -C -d "$zcd"
    { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
  fi
}
source ~/.zsh/alias.sh
source ~/.zsh/func.sh

# Kitty
autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

eval "$(starship init zsh)"
# uncomment the line below to profile
# zprof | less
