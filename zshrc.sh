#!/bin/sh

# Iris Li's environment for bash

# ENVDEBUG=1

ENVDIR="$(dirname "$0")"

PATH=$PATH:$ENVDIR/bin

zstyle ':completion:*:*:git:*' script ${ENVDIR}/.git-completion.zsh
autoload -U compinit && compinit # This is the magic line that gets aliases to work!

set -o ignoreeof

# common to both sh bash and zsh
source ${ENVDIR}/common.sh

export LSCOLORS=ExFxCxDxBxegedabagacad
# Cross-platform ls colors
if ls --help 2>&1 | grep -q -- --color; then
    alias ls='ls --color=auto -F'
else
    alias ls='ls -FG'
fi

alias l="ls  -lGhpFtr" # Most recent first
alias ll="ls -lGhpF"   # "Vanilla" ll
alias la="ls -lGhpFa"  # "Vanilla" ll with hidden files

alias lg="l | grep"
alias llg="ll | grep"
alias lag="la | grep"

# Moving up directories quicker
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias mkdirp="mkdir -p"

# Some programs are missing on the berkeley eecs servers
# We don't use $PATH because we need to check if each program is available
# tar --version > /dev/null 2>&1 || { echo 'no tar'; TAR_MISSING=true; }  > /dev/null 2>&1

# if [ -n "$TAR_MISSING" ] ; then
#     #echo "tar is missing"

#     # This is a 12.04 ubuntu binary
#     alias tar="${ENVDIR}/bin/tar"
# fi

# htop --version > /dev/null 2>&1 || { echo 'no htop'; HTOP_MISSING=true; }  > /dev/null 2>&1

# if [ -n "$HTOP_MISSING" ] ; then
#     # This is a 12.04 ubuntu binary
#     alias htop="${ENVDIR}/bin/htop"
# fi

# BC Calculator default scale to show up to the satoshi (smallest unit of Bitcoin)
export BC_ENV_ARGS=${ENVDIR}/bcrc
alias bc="bc -q" # Don't print out version info and GPL2 license info when loading bc. Can do so with bc -v

# Load the vimrc files. vi loads a naked vim (now sure why I would want that, but it's there for the sake of leaving original commands intact)
alias vimm="vim -u ${ENVDIR}/vim/vimm" #vimm is vim with mouse mode
alias vim="vim -u ${ENVDIR}/vim/vimrc"
alias vi="vim -u ${ENVDIR}/vim/blank"
#export EDITOR='subl -w'
export EDITOR='vim'

alias ic="imgcat"

# Tools for viewing and removing exif data (using exiftool; can be installed through brew)
alias viewexif="exiftool -a -u -g1"
alias removeexif="exiftool -all= "
alias wh="identify -format \"%w, %h\n\""

# Optimize jpeg at 85
alias j85="jpegoptim -m 85"

alias m="source make.sh"
alias r="source run.sh"
alias mr="source make && source run.sh;" # Only run if we compiled successfully

# In case there were more than 1 file to compile/run
alias m2="source make2.sh"
alias r2="source run2.sh"
alias 2mr="source make2.sh && source run2.sh;" # Only run if we compiled successfully
alias mr2="source make.sh && source run2.sh;"  # Only run if we compiled successfully

#More colors
alias grep="grep --color=always"
export CLICOLOR=1

# Get public ip
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# Loops through folders in current directory
forin() {
    for dir in ./*; do
        if [[ -d $dir ]]; then
            (
                echo
                echo "--------------------------------------------------------------------------------$dir"
                cd "$dir"
                ${*:1}
            )
        fi
    done
}

# git commamands simplified
git config --global push.default current
alias g='git status'               # G
alias gs='git status'              # sorry, ghostscript
alias gsr='forin git status'       # git status recursive
alias gcoh='git checkout HEAD -- ' # hard reset a single file
alias gco='git checkout'
alias gcob='git checkout -b' # create branch
alias ga='git add'
alias gap='git add -p'
alias gapu='git add -p -u'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gpom='git pull origin master'
alias gpoh='git push origin HEAD'
alias gpl='git pull --rebase'
alias grb='git rebase'
alias gr='git reset'
alias gbr='git branch'
# Two different ways of coloring. I'll see which one I like more
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glg='git log --date-order --all --graph --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'
alias glg2='git log --date-order --all --graph --name-status --format="%C(green)%H%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'

# make autocomplete work on aliases

# Ansible alias
alias apb="ansible-playbook"

# Update our environment by pulling the git and then returning back to where we were and refresh settings
# Also updates git plugins

# Lastly, lets clear everything
alias c='clear'

# The following code messes up scp sometimes. Maybe I will reactivate it in the future.
# Login colorcode
#colorcode='\e[42;30m'
#NC='\e[0m' # No Color
#echo -e "${colorcode}                 ${NC}\n${colorcode}    $(whoami)    ${NC}\n${colorcode}                 ${NC}"

for f in ${ENVDIR}/extra/*.sh; do
    if [ $f = $ENVDIR'/extra/blank.sh' ]; then
        : #nop
    else
        . $f
    fi
done
