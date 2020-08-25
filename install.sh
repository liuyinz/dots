#!/usr/bin/env bash

function require_brew() {
	echo "brew $1 $2"
	brew list $1 >/dev/null 2>&1 | true
	if [[ ${PIPESTATUS[0]} != 0 ]]; then
		echo "brew install $1 $2"
		brew install $1 $2
		if [[ $? != 0 ]]; then
			echo "failed to install $1! aborting..."
			# exit -1
		fi
	fi
}

echo "ensuring build/install tools are available"
if ! xcode-select --print-path &>/dev/null; then
	# Prompt user to install the XCode Command Line Tools
	xcode-select --install &>/dev/null
	# Wait until the XCode Command Line Tools are installed
	until xcode-select --print-path &>/dev/null; do
		sleep 5
	done
	print_result $? ' XCode Command Line Tools Installed'
	# Prompt user to agree to the terms of the Xcode license
	# https://github.com/alrra/dotfiles/issues/10
	sudo xcodebuild -license
	print_result $? 'Agree with the XCode Command Line Tools licence'
fi

# ###########################################################
# install homebrew (CLI Packages)
# ###########################################################

echo "checking homebrew..."
brew_installed_p=$(which brew) 2>&1 >/dev/null
if [[ $? != 0 ]]; then
	echo "installing homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	if [[ $? != 0 ]]; then
		echo "unable to install homebrew, script $0 abort!"
		exit 2
	fi
fi

# replace repo&&core with Tsinghua source
echo "replace repo&&core with Tsinghua source"
git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
# update homebrew
echo "updating homebrew..."
brew update
echo "homebrew updated"
echo "upgrading brew packages..."
brew upgrade
echo "brews upgraded"

# install bonclay
require_brew talal/tap/bonclay
bonclay_installed_p=$(which bonclay) 2>&1 >/dev/null
if [[ $? == 0 ]]; then
	echo "sync dots"
	bonclay sync bonclay.yaml
	echo "sync done"
fi

# zsh setup
require_brew zsh
# set zsh as the user login shell
CURRENTSHELL=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')
if [[ "$CURRENTSHELL" != "/usr/local/bin/zsh" ]]; then
	echo "setting newer homebrew zsh (/usr/local/bin/zsh) as your shell (password required)"
	# sudo bash -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
	# chsh -s /usr/local/bin/zsh
	sudo dscl . -change /Users/$USER UserShell $SHELL /usr/local/bin/zsh >/dev/null 2>&1
fi

echo "setup npm&&node"
nvm install node
npm install -g npmrc
npmrc default

echo "tap homebrew/bundle"
brew tap homebrew/bundle
echo "bundle install Brewfile"
brew bundle install

# Just to avoid a potential bug
# mkdir -p ~/Library/Caches/Homebrew/Formula
# brew doctor

# # ###########################################################
# echo "rust setup"
# # ###########################################################
# echo "Install rust"
# curl https://sh.rustup.rs -sSf | sh
# rustup install nightly
# rustup default nightly
# rustup component add rls-preview --toolchain nightly
# rustup component add rust-analysis --toolchain nightly
# rustup component add rust-src --toolchain nightly
# cargo install rustsym racer

# # ###########################################################
# echo "mysql setup"
# # ###########################################################
# echo "Install Mysql"
# brew install mysql
# brew services start mysql
# mysql_secure_installation
# echo

# ###########################################################
# echo " Install Develop Tools"
# ###########################################################
# require_brew curl
# require_brew wget
# require_brew ripgrep
# require_brew bat
# require_brew findutils
# require_brew make
# brew install --HEAD universal-ctags/universal-ctags/universal-ctags
# require_brew gnutls
# require_brew tmux
# require_brew autojump
# require_brew grip
# require_brew fzf
# /usr/local/opt/fzf/install

# action "link tmux conf"
# ln -s $HOME/.dotfiles/tmux/.tmux.conf $HOME/.tmux.conf
# echo

# action "Install tpm"
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# echo "when you open tmux,you must type prefix {default: Ctrl+space } + I to install tmux plugins"

# require_brew node
# require_brew yarn

# echo "Install create-react-app"
# npm install -g create-react-app
# echo

# echo "Install yabai and skhd"
# brew install yabai --HEAD
# brew install koekeishiya/formulae/skhd
# ln -s "${HOME}/.dotfiles/yabai/yabairc" "${HOME}/.yabairc"
# ln -s "${HOME}/.dotfiles/yabai/skhdrc" "${HOME}/.skhdrc"
# brew services start skhd
# brew services start koekeishiya/formulae/yabai

# if [[ $UserLocation =~ 1 ]]; then
# 	echo "Config npm use taobao"
# 	npm config set registry https://registry.npm.taobao.org
# fi

# echo "Install Eslint"
# npm install -g eslint

# read -r -p "Are you a gopher? [y|N] " response
# if [[ $response =~ ( y|yes|Y ) ]]; then
# 	require_brew golang
# 	mkdir -p ~/workspace
# 	# for chinese user use proxy to get golang package which on google server
# 	export GO111MODULE="on"
# 	export GOPATH="$HOME/workspace"
# 	if [[ $UserLocation =~ 1 ]]; then
# 		export GOPROXY=https://goproxy.io
# 	fi
# 	go get golang.org/x/tools/gopls@latest
# 	go get -u github.com/go-delve/delve/cmd/dlv
# else
# 	echo "skipped"
# fi

# read -r -p "Are you a vimer? [y|N] " response
# if [[ $response =~ (y|yes|Y) ]]; then
# 	# Install neovim and thinkvim config
# 	echo "Install neovim"
# 	require_brew neovim
# 	echo "Configruation thinkvim"
# 	git clone --depth=1 https://github.com/hardcoreplayers/thinkvim ~/.config/nvim
# 	echo
# 	ln -s ~/.dotfiles/thinkvim ~/.thinkvim.d
# else
# 	echo "skipped"
# fi

read -r -p "Are you a emacser? [y|N] " response
if [[ $response =~ (y|yes|Y) ]]; then
	brew install gpg
	brew install ripgrep
	brew install grip
	brew install aspell
	echo "Install Emacs27"
	brew tap d12frosted/emacs-plus
	brew install emacs-plus --HEAD --with-emacs-27-branch --with-xwidgets --without-spacemacs-icon --with-jansson

	# symlink to /usr/local/bin/emacs,enable emacsclient.. if multiversion installed
	# brew link emacs-plus

	# symlink to /Applications/Emacs.app
	ln -s /usr/local/opt/emacs-plus/Emacs.app /Applications

	echo "Configruation Emacs"
	git clone https://github.com/liuyinz/.emacs.d ~/.emacs.d
	echo "Installing Lsp for emacs lsp-mode"
	npm install -g vscode-html-languageserver-bin
	npm install -g vscode-css-languageserver-bin
	npm i -g bash-language-server
	npm i -g typescript
	npm i -g prettier
	npm i -g typescript-language-server
else
	echo "skipped"
fi

# # echo

# # ###########################################################
# echo " Install Gui Applications"
# # ###########################################################

# read -r -p "Do you want install iterm2? [y|N] " response
# if [[ $response =~ (y|yes|Y) ]]; then
# 	require_cask iterm2
# else
# 	echo "skipped"
# fi
# echo "Configuration iterm2 settings"
# open "$HOME/.dotfiles/iterm2/itermcolors/gruvbox-dark.itermcolors"
# echo
# defaults write com.googlecode.iterm2 "Normal Font" -string "Monaco"
# echo
# echo "reading iterm settings"
# defaults read -app iTerm >/dev/null 2>&1
# echo

# read -r -p "Do you want install google-chrome? [y|N] " response
# if [[ $response =~ (y|yes|Y) ]]; then
# 	require_cask google-chrome
# else
# 	echo "skipped"
# fi

# read -r -p "Do you want install vscode? [y|N] " response
# if [[ $response =~ (y|yes|Y) ]]; then
# 	require_cask visual-studio-code
# else
# 	echo "skipped"
# fi

# read -r -p "Do you want install postman? [y|N] " response
# if [[ $response =~ (y|yes|Y) ]]; then
# 	require_cask postman
# else
# 	echo "skipped"
# fi

# if [[ $UserLocation =~ 1 ]]; then
# 	read -r -p "Do you want install QQ? [y|N] " qqresponse
# 	if [[ $qqresponse =~ (y|yes|Y) ]]; then
# 		require_cask qq
# 	else
# 		echo "skipped"
# 	fi
# 	read -r -p "Do you want install wechat? [y|N] " wxresponse
# 	if [[ $wxresponse =~ (y|yes|Y) ]]; then
# 		require_cask wechat
# 	else
# 		echo "skipped"
# 	fi
# fi

# brew update && brew upgrade && brew cleanup

echo "All done"
