# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

plugins=(git, wd, git-extras)

source $ZSH/oh-my-zsh.sh
export EDITOR='emacs'
export ALTERNATE_EDITOR='emacs'
export CHEFTEMP='/Users/tritenour/chef/templates'
export JAMTEMP='/Users/tritenour/codejam/templates'
export DOW='/Users/tritenour/Downloads'

export LOG='/var/log'

# User configuration

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"

#Git Helpers
alias gs="git status"
alias omz="emacs -nw ~/.zshrc && source ~/.zshrc"
alias e="emacs -nw"
alias ec="emacs -nw ~/.emacs"
alias ga="git add"
alias gb="git branches"
alias gd="git diff"
alias gp="git sync"
alias gc="git commit"
alias gch="git checkout"
alias gdc="git diff --cached"
alias gg="git grep"
alias glo="git log"
alias gsl="git stash list"
alias gl="git pull"
alias gsc="git stash clear"
alias gsu="git stash;
           git pull --rebase;
           git stash apply"
alias note="emacs -nw ~/.note"
alias m="meteor"

#Jump between repos
alias courier_api="cd ~/git/courier-api-fork; workon ebn-api"
alias dash="cd ~/git/dash; workon ebn-dash"
alias consumer_api="cd ~/git/consumer-api; workon ebn-api"
alias dispatch="cd ~/git/dispatcher-tests/v2; workon ebncdsvc-test"
alias scotty="cd ~/git/scotty"

#Pipe output
alias pipestage="pipe stage1"
alias pipeprod="pipe prod1"

#Helper Functions

pipe() {
    #$1 -- hostname to route to
    #$2 -- local port #
    #$3 -- remote port #
    ssh -L ${2:-16432}:\localhost:${3:-6432} $1
}

build() {
    ssh buildbox "~/make-manifest.sh $1"
}

regex() {
    gawk 'match($0,/'$1'/, ary) {print ary['${2:-'0'}']}';
}

makechef() {
    mkdir ${1:-a} &&
    cd ${1:-a} &&
    cp $CHEFTEMP/base.${2:-scala} ${1:-a}.${2:-scala} &&
    touch in &&
    e ${1:-a}.${2:-scala} in
}

makejam() {
    mkdir ${1:-a} &&
    cd ${1:-a} &&
    cp $JAMTEMP/base.${2:-py} ${1:-a}.${2:-py} &&
    touch in &&
    e ${1:-a}.${2:-py} in
}

openlog() {
    ssh ${2:-stage2} "sudo tail -n 100 $1" | sed -e "s/#012/\n/g"
}

dumpschema() {
    ssh ${2:-stage1} "sudo su postgres; pg_dump -s eventsdb" | cat
}

lmatch() {
    gg $1 | awk -F${2:-":"} '{print $1}'
}

# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh
