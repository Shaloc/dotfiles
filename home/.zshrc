export ZSH="$HOME/.oh-my-zsh"


SPACESHIP_TIME_SHOW=true
SPACESHIP_CHAR_SYMBOL="❯ "
ZSH_THEME="spaceship"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
)

source $ZSH/oh-my-zsh.sh

# User configuration

eval "$(/opt/homebrew/bin/brew shellenv)"

alias s="kitty +kitten ssh"
alias icat="kitty +kitten icat"
alias trans="kitty +kitten transfer"
alias recv="kitty +kitten transfer --direction=receive"

function proxy() {
  export https_proxy=http://127.0.0.1:6152
  export http_proxy=http://127.0.0.1:6152
  export all_proxy=socks5://127.0.0.1:6153
}

function unproxy() {
  export https_proxy=""
  export http_proxy=""
  export all_proxy=""
}

# ~/r/i for my projects
function i() {
    cd ~/r/i/$1
}

# ~/r/f for forks and references
function f() {
    cd ~/r/f/$1
}

# ~/r/r for reproductions or documentation
function r() {
    cd ~/r/r/$1
}

function bi() {
    brew install $1
}

function dir() {
    mkdir $1 && cd $1
}

function glp() {
  git --no-pager log -$1
}

function gd() {
  if [[ -z $1 ]] then
    git diff --color | diff-so-fancy
  else
    git diff --color $1 | diff-so-fancy
  fi
}

function gdc() {
  if [[ -z $1 ]] then
    git diff --color --cached | diff-so-fancy
  else
    git diff --color --cached $1 | diff-so-fancy
  fi
}

export KEYID=0x640E4B5501739027

secret () {
        output=~/"${1}".$(date +%s).enc
        gpg --encrypt --armor --output ${output} -r ${KEYID}  "${1}" && echo "${1} -> ${output}"
}

reveal () {
        output=$(echo "${1}" | rev | cut -c16- | rev)
        gpg --decrypt --output ${output} "${1}" && echo "${1} -> ${output}"
}

export PATH="/opt/homebrew/opt/python@3.8/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv" 
export PATH="$PYENV_ROOT/bin:$PATH" 
eval "$(pyenv init --path)" 
eval "$(pyenv init -)"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export GOPATH="/Users/shaloc/go"
export GOBIN="/Users/shaloc/go/bin"
export PATH=${GOBIN}:$PATH
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

