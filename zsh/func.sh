#!/usr/bin/env bash

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
			pip3 install --upgrade "$prog"
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
			pip3 install --upgrade "$prog"
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
	inst=$(brew search | eval "fzf ${FZF_DEFAULT_OPTS} \
        --exact --header='[brew:install]'")

	if [[ $inst ]]; then
		for prog in $(echo "$inst"); do
			brew install "$prog"
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
			brew cask install "$prog"
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
	uninst=$(brew cask list | eval "fzf ${FZF_DEFAULT_OPTS} \
        --header='[brew cask:uninstall]'")

	if [[ $uninst ]]; then
		for prog in $(echo "$uninst"); do
			brew cask uninstall "$prog"
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

# Remove cache
# -------------------
zr() {
	rm -f ~/.cache/zsh/.zcompdump
	rm -f ~/.cache/zsh/.zcompdump.zwc
	# zplug clear
}

# Additional
# Emacs vterm-mode setting
function vterm_printf() {
	if [ -n "$TMUX" ]; then
		# Tell tmux to pass the escape sequences through
		# (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
		printf "\ePtmux;\e\e]%s\007\e\\" "$1"
	elif [ "${TERM%%-*}" = "screen" ]; then
		# GNU screen (screen, screen-256color, screen-256color-bce)
		printf "\eP\e]%s\007\e\\" "$1"
	else
		printf "\e]%s\e\\" "$1"
	fi
}
