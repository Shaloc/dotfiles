#!/bin/bash

# Install XCode cli tools
echo "Installing commandline tools..."
xcode-select --install

# Install homebrew and configure to tsinghua source
export HOMEBREW_INSTALL_FROM_API=1
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install
/bin/bash brew-install/install.sh
rm -rf brew-install
test -r ~/.zprofile && echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
echo 'export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"' >> ~/.zprofile
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

# Install softwares
brew tap koekeishiya/formulae
brew install --cask kitty
brew install yabai
brew install skhd
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install btop
brew install lazygit
brew install neofetch
brew install jq
brew install neovim
brew install wget

# Setup keys
# Reference: https://github.com/drduh/YubiKey-Guide
KEYID=0x640E4B5501739027
brew install gnupg yubikey-personalization hopenpgp-tools ykman pinentry-mac
mkdir -p ~/.gnupg && cd ~/.gnupg ; wget https://raw.githubusercontent.com/drduh/config/master/gpg.conf
chmod 600 gpg.conf
gpg --recv ${KEYID}
gpg --edit-key ${KEYID} trust quit # enter 5, enter y
curl -s https://raw.githubusercontent.com/drduh/config/master/gpg-agent.conf | sed -e '/pinentry-curses/d' | sed -e 's/#pinentry-program\ \/opt\/homebrew\/bin\/pinentry-mac/pinentry-program\ \/opt\/homebrew\/bin\/pinentry-mac/g' > gpg-agent.conf
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
ssh-add -L

cd ~/





