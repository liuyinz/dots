# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
		# If we can't get zplug, it'll be a very sobering shell experience. To at
		# least complete the sourcing of this file, we'll define an always-false
		# returning zplug function.
		if [[ $? != 0 ]]; then
			function zplug() {
				return 1
			}
		fi
	fi
	export ZPLUG_HOME="${ZCACHE}/zplug"
fi

if [[ -d "${ZPLUG_HOME}" ]]; then
	source "${ZPLUG_HOME}/init.zsh"
fi

# Zplug pluggin
zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug 'romkatv/powerlevel10k', as:theme, depth:1
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions', defer:2
zplug 'zsh-users/zsh-history-substring-search', defer:3
zplug "zdharma/fast-syntax-highlighting", defer:3
zplug "lincheney/fzf-tab-completion"
# self
zplug 'liuyinz/zsh-completions'
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
	# printf "Install? [y/N]: "
	# if read -q; then
	# echo
	zplug install
	# fi
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
	bindkey '^I' fzf_completion
	# uncomment enable search for verbose
	# zstyle ':completion:*' fzf-search-display true
fi

source ~/.zsh/option.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/func.sh

# if which starship >/dev/null 2>&1; then
# 	eval "$(starship init zsh)"
# fi

# uncomment the line below to profile
# zprof | less

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
