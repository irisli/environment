#!/bin/sh

# Iris Li's environment for bash

# ENVDEBUG=1

ENVDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PATH=$PATH:$ENVDIR/bin

# common to both sh bash and zsh
source ${ENVDIR}/common.sh

# dependencies
source ${ENVDIR}/git-prompt.sh

# Git autocompletion script
source ${ENVDIR}/git-completion.bash

set -o ignoreeof

# Define some color codes so that we can easily use them
# From https://wiki.archlinux.org/index.php/Color_Bash_Prompt
    # Reset
    Color_Off='\e[0m'       # Text Reset

    # Regular Colors
    Black='\e[0;30m'        # Black
    Red='\e[0;31m'          # Red
    Green='\e[0;32m'        # Green
    Yellow='\e[0;33m'       # Yellow
    Blue='\e[0;34m'         # Blue
    Purple='\e[0;35m'       # Purple
    Cyan='\e[0;36m'         # Cyan
    White='\e[0;37m'        # White

    # Bold
    BBlack='\e[1;30m'       # Black
    BRed='\e[1;31m'         # Red
    BGreen='\e[1;32m'       # Green
    BYellow='\e[1;33m'      # Yellow
    BBlue='\e[1;34m'        # Blue
    BPurple='\e[1;35m'      # Purple
    BCyan='\e[1;36m'        # Cyan
    BWhite='\e[1;37m'       # White

    # Underline
    UBlack='\e[4;30m'       # Black
    URed='\e[4;31m'         # Red
    UGreen='\e[4;32m'       # Green
    UYellow='\e[4;33m'      # Yellow
    UBlue='\e[4;34m'        # Blue
    UPurple='\e[4;35m'      # Purple
    UCyan='\e[4;36m'        # Cyan
    UWhite='\e[4;37m'       # White

    # Background
    On_Black='\e[40m'       # Black
    On_Red='\e[41m'         # Red
    On_Green='\e[42m'       # Green
    On_Yellow='\e[43m'      # Yellow
    On_Blue='\e[44m'        # Blue
    On_Purple='\e[45m'      # Purple
    On_Cyan='\e[46m'        # Cyan
    On_White='\e[47m'       # White

    # High Intensity
    IBlack='\e[0;90m'       # Black
    IRed='\e[0;91m'         # Red
    IGreen='\e[0;92m'       # Green
    IYellow='\e[0;93m'      # Yellow
    IBlue='\e[0;94m'        # Blue
    IPurple='\e[0;95m'      # Purple
    ICyan='\e[0;96m'        # Cyan
    IWhite='\e[0;97m'       # White

    # Bold High Intensity
    BIBlack='\e[1;90m'      # Black
    BIRed='\e[1;91m'        # Red
    BIGreen='\e[1;92m'      # Green
    BIYellow='\e[1;93m'     # Yellow
    BIBlue='\e[1;94m'       # Blue
    BIPurple='\e[1;95m'     # Purple
    BICyan='\e[1;96m'       # Cyan
    BIWhite='\e[1;97m'      # White

    # High Intensity backgrounds
    On_IBlack='\e[0;100m'   # Black
    On_IRed='\e[0;101m'     # Red
    On_IGreen='\e[0;102m'   # Green
    On_IYellow='\e[0;103m'  # Yellow
    On_IBlue='\e[0;104m'    # Blue
    On_IPurple='\e[0;105m'  # Purple
    On_ICyan='\e[0;106m'    # Cyan
    On_IWhite='\e[0;107m'   # White


# Takes the all the letters of whoami and turns it into a number between 0 and 5 so that we can uniquely color/style the username
# Does so by summing up the decimal representation of all the numbers
# and then getting the remainder when dividing by the amount of color options we have
unique_string=$USER$(groups)
unique_sum=$(echo $unique_string | sum | tr -d " ")
unique_num=$(( $unique_sum  % 7 ))

if [ "$unique_num" -eq 0 ]
then
    ucolor1=$Red
    ucolor2=$Yellow
    ucolor3=$Blue
elif [ "$unique_num" -eq 1 ]
then
    ucolor1=$Yellow
    ucolor2=$Blue
    ucolor3=$Purple
elif [ "$unique_num" -eq 2 ]
then
    ucolor1=$Blue
    ucolor2=$Purple
    ucolor3=$Green
elif [ "$unique_num" -eq 3 ]
then
    ucolor1=$Purple
    ucolor2=$Green
    ucolor3=$Cyan
elif [ "$unique_num" -eq 4 ]
then
    ucolor1=$Green
    ucolor2=$Cyan
    ucolor3=$Red
elif [ "$unique_num" -eq 5 ]
then
    ucolor1=$Cyan
    ucolor2=$Red
    ucolor3=$Yellow
else # 6
    ucolor1=$Green
    ucolor2=$Blue
    ucolor3=$Purple
fi


# main prompt
PS1="\[$ucolor1\]\u\[$Black\]@\[$ucolor2\]\h\[$Black\]:\[$ucolor3\]\w\[$Color_Off\] \[\e[4;37m\]\$(__git_ps1)\[$Color_Off\] "

# Python interactive prompt coloring (DELETED LOL)


export LSCOLORS=ExFxCxDxBxegedabagacad
# Check if ls uses the --color argument
# ls -G --color > /dev/null 2>&1 || { echo 'ls -G --color failed'; NO_LS_COLORS=true; }  > /dev/null 2>&1

# if [ -n "$NO_LS_COLORS" ] ; then
#     # We have defined that we want colors in ls (for some reason, some Berkeley eecs Solaris terminals don't support this :( ))
#     # No colors
#     alias l="ll -tr"
#     alias ll="ls -lhpF"
#     alias la="ls -lhpFa"
# else
    # ls is just a naked normal ls. I like to leave original commands untouched just in case
    alias l="ls  -lGhpFtr" # Most recent first
    alias ll="ls -lGhpF" # "Vanilla" ll
    alias la="ls -lGhpFa" # "Vanilla" ll with hidden files
# fi

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
alias mr2="source make.sh && source run2.sh;" # Only run if we compiled successfully

#More colors
alias grep="grep --color=always"
export CLICOLOR=1

# Get public ip
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"


# Loops through folders in current directory
forin() {
  for dir in ./*; do
    if [[ -d $dir ]]; then
      (echo;echo "--------------------------------------------------------------------------------$dir"; cd "$dir";${*:1} )
    fi
  done
}

# git commamands simplified
git config --global push.default simple
alias g='git status' # G
alias gs='git status' # sorry, ghostscript
alias gsr='forin git status' # git status recursive
alias gcoh='git checkout HEAD -- ' # hard reset a single file
alias gco='git checkout'
__git_complete gco _git_checkout
alias gcob='git checkout -b' # create branch
alias ga='git add'
__git_complete ga _git_add
alias gap='git add -p'
__git_complete gap _git_add
alias gapu='git add -p -u'
__git_complete gapu _git_add
alias gd='git diff'
__git_complete gd _git_diff
alias gdc='git diff --cached'
__git_complete gd _git_diff
alias gc='git commit'
__git_complete gc _git_commit
alias gcm='git commit -m'
__git_complete gcm _git_commit
alias gca='git commit --amend'
__git_complete gcm _git_commit
alias gpom='git pull origin master'
alias gpoh='git push origin HEAD'
alias gpl='git pull --rebase'
__git_complete gpl _git_pull
alias grb='git rebase'
__git_complete grb _git_rebase
alias gr='git reset'
__git_complete gr _git_reset
alias gbr='git branch'
__git_complete gbr _git_branch
# Two different ways of coloring. I'll see which one I like more
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glg='git log --date-order --all --graph --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'
alias glg2='git log --date-order --all --graph --name-status --format="%C(green)%H%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'

# make autocomplete work on aliases
__git_complete g __git_main

# Ansible alias
alias apb="ansible-playbook"


# Update our environment by pulling the git and then returning back to where we were and refresh settings
# Also updates git plugins
# alias update-env="lastdir=$(pwd);cd ${ENVDIR}/; git pull origin master;git submodule init;git submodule update;cd $lastdir;lastdir='';source ${ENVDIR}/bashrc.bash"

# Lastly, lets clear everything
alias c='clear'

# The following code messes up scp sometimes. Maybe I will reactivate it in the future.
# Login colorcode
#colorcode='\e[42;30m'
#NC='\e[0m' # No Color
#echo -e "${colorcode}                 ${NC}\n${colorcode}    $(whoami)    ${NC}\n${colorcode}                 ${NC}"

for f in ${ENVDIR}/extra/*.sh; do
    if [ $f = $ENVDIR'/extra/blank.sh' ];
    then
        : #nop
    else
        . $f
    fi
done
