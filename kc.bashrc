# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Useful aliases
alias update='sudo apt update && sudo apt upgrade -y'
alias install='sudo apt install'
alias remove='sudo apt remove'
alias cls='clear'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias home='cd ~'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Improved directory navigation
function mkcd() { mkdir -p "$1" && cd "$1"; }

# Enhanced grep
alias grep='grep --color=auto'

# Quick edit of .bashrc
alias eb='nano ~/.bashrc'

# Reload .bashrcclear
alias reload='source ~/.bashrc'

# Show disk usage in human-readable format
alias df='df -h'

# Show directory size
alias du='du -sh'

# IP address lookup
alias myip='curl http://ipecho.net/plain; echo'

# Create a Python virtual environment
alias venv='python3 -m venv ./venv'
alias activate='source ./venv/bin/activate'

# WSL specific: Open current directory in Windows Explorer
alias explore='explorer.exe .'


# Electron WSL no GPU rendering
export LIBGL_ALWAYS_SOFTWARE=1

# Add color to man pages
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline


# Enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi



# Function to extract various archive formats
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# Modify your set_prompt function to include a reset at the end
export TERM="xterm-256color"

set_prompt() {
    GREEN='\[\e[0;32m\]'
    GRAY='\[\e[0;38;5;245m\]'
    RED='\[\e[0;31m\]'
    BLACK='\[\e[0;30m\]'
    BOLD='\[\e[1m\]'
    RESET='\[\e[0m\]'

    if [[ -n "$VIRTUAL_ENV" ]]; then
        VENV_NAME=$(basename "$VIRTUAL_ENV")
        VENV_PROMPT="${BLACK}(${VENV_NAME})${RESET} "
    else
        VENV_PROMPT=""
    fi

    PS1="${VENV_PROMPT}${BOLD}${GREEN}\u@\h${RESET}:${GRAY}\w${RESET} $(exit_status)\n${GREEN}└─\$ ${RESET}"
}

exit_status() {
    EXIT_STATUS=$?
    if [[ $EXIT_STATUS -eq 0 ]]; then
        echo -e "${GREEN}✔${RESET}"
    else
        echo -e "${RED}✘${RESET}"
    fi
}

PROMPT_COMMAND=set_prompt

# Welcome message
display_welcome() {
    GREEN=$(tput setaf 2)
    BLUE=$(tput setaf 4)
    BLACK=$(tput setaf 0)
    BOLD=$(tput bold)
    RESET=$(tput sgr0)

    HOSTNAME=$(hostname)
    USER=$(whoami)
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

    # Get CPU information
    CPU=$(lscpu | grep 'Model name' | cut -d ':' -f 2 | xargs)

    # Get GPU information
    GPU=$(lspci | grep -i 'vga\|3d\|2d' | cut -d ':' -f 3 | xargs)

    # Get RAM information
    RAM=$(free -h | awk '/^Mem:/ {print $2}')

    echo -e "${BLUE}${BOLD}+------------------------------------------+${RESET}"
    echo -e " "
    echo -e " ${GREEN}${BOLD}    In the realm of ideas, there are${RESET} "
    echo -e " ${GREEN}${BOLD}        no limits, only endless${RESET} "
    echo -e " ${GREEN}${BOLD}             possibilities.${RESET} "
    echo -e " "
    echo -e " ${BLACK}${BOLD}Hostname:${RESET}  $HOSTNAME "
    echo -e " ${BLACK}${BOLD}User:${RESET}      $USER "
    echo -e " ${BLACK}${BOLD}Date:${RESET}      $TIMESTAMP "
    echo -e " ${BLACK}${BOLD}CPU:${RESET}       $CPU "
    echo -e " "
    echo -e " ${GREEN}${BOLD}       (c) Profitelligence, LLC      ${RESET} "
    echo -e " "
    echo -e "${BLUE}${BOLD}+------------------------------------------+${RESET}"
    echo
}

display_welcome


# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
