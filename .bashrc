# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export TERM=xterm-256color

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]
then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# matlab
PATH="/usr/local/Polyspace/R2021a/bin:$PATH"

# Android
# PATH="~/development/android/sdk/platform-tools:$PATH"
# PATH="~/development/android:$PATH"
# PATH="~/development/android/sdk:$PATH"

export ANDROID_SDK_ROOT=/usr/local/android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools 

# Java 
export CLASSPATH=$CLASSPATH:/home/malkhu7anie/Programming/Java/vs_code:.

# Nodejs
VERSION=v10.15.0
DISTRO=linux-x64
export PATH=/usr/local/lib/nodejs/node-v16.13.2-linux-x64/bin:$PATH

# Intel OneAPI Base Toolkit
# source /opt/intel/oneapi/setvars.sh

# Qt
# PATH="/usr/local/Qt/6.2.2/gcc_64/bin:$PATH"
# QTDIR="/usr/loca/Qt/6.2.2/gcc_64/bin"
# export PATH QTDIR

# Doom Emacs
PATH="~/.emacs.d/bin:$PATH"

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"               # $EDITOR opens in terminal
export VISUAL="emacsclient -c -a emacs"      # $VISUAL opens in GUI mode

[ -f "/home/malkhu7anie/.ghcup/env" ] && source "/home/malkhu7anie/.ghcup/env" # ghcup-env

. "$HOME/.cargo/env"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
# source /home/malkhu7anie/Downloads/alacritty/extra/completions/alacritty.bash
alias config='/usr/bin/git --git-dir=/home/malkhu7anie/.cfg/ --work-tree=/home/malkhu7anie'
