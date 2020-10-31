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
zplug 'romkatv/powerlevel10k', as:theme, depth:1
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

source ~/.zsh/option.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/func.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# uncomment the line below to profile
# zprof | less
