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

function gdc() {
  if [[ -z $1 ]] then
    git diff --color --cached | diff-so-fancy
  else
    git diff --color --cached $1 | diff-so-fancy
  fi
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

