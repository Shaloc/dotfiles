export ZSH="/home/shaloc/.oh-my-zsh"

ZSH_THEME="spaceship"

# fix for wsl
# export SPACESHIP_BATTERY_SHOW=false

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
)

source $ZSH/oh-my-zsh.sh

# export PATH=$PATH:/usr/local/go/bin

# proxy only for wsl
function wslproxy() {
    export hostip=$(cat /etc/resolv.conf |grep -oP '(?<=nameserver\ ).*')
    export HTTP_PROXY="http://${hostip}:7890"
    export HTTPS_PROXY="http://${hostip}:7890"
}

function unproxy() {
    export HTTP_PROXY=
    export HTTPS_PROXY=
}

# ~/i for my projects
function i() {
    cd ~/i/$1
}

# ~/f for forked projects/install tmp
function f() {
    cd ~/f/$1
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

function clonei() {
    i && git clone "$@"
}

function clonef() {
    f && git clone "$@"
}

function serve() {
    if [[ -z $1 ]] then
        live-server dist
    else
        live-server $1
    fi
}
