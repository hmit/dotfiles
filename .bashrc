
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source global definitions
[ -r /etc/bashrc ] && . /etc/bashrc

# disable START/STOP signal to the terminal. Especially useful when using screen, tmux, byobu
stty -ixon

export BYOBU_DISTRO=Ubuntu
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE='ls:bg:fg:history'
export HISTSIZE=10000
export HISTFILESIZE=200000

shopt -s histappend      # append to the history file, don't overwrite it
shopt -s dotglob         # include hidden files when expanding filename patterns [from SO]
shopt -s checkwinsize    # check window size after each command; update LINES and COLUMNS
shopt -s expand_aliases  # aliases are expanded; default for most interactive shells
shopt -s cmdhist         # try to save multi-line commands in a single file

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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
[ -r "$HOME/.uberrc" ] && . "$HOME/.uberrc"

export PATH="$HOME/bin:/usr/local/opt/emacs/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"
export PYTHONPATH=$PYTHONPATH:$ROOT/python:$ROOT/python/stubs:.
export AWS_CONFIG_FILE=$HOME/.s3cfg

export GOPATH=$ROOT/go
export GOROOT=/usr/lib/go

if [ "$TERM" = "dumb" ] ; then
    export PS1="[\u@\h] [\w] > "
    unset GREP_OPTIONS
else
    PS1="\[\033[01;37m\][\[\033[01;31m\]\u\[\033[01;37m\]@\[\033[01;32m\]\h\[\033[01;37m\]] [\[\033[01;34m\]\w\[\033[01;37m\]]\$ \[\033[00m\]"
fi

export PROMPT_COMMAND="history -a; history -c; history -r;"

[ -r "$HOME/.aliases" ] && . "$HOME/.aliases"
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
[ -r "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"

[ -r /etc/bash_completion ] && . /etc/bash_completion     # bash completion
[ -r "$HOME/.byobu/prompt" ] && . "$HOME/.byobu/prompt"   # byobu-prompt#
[ -r "$HOME/.`hostname`rc" ] && . "$HOME/.`hostname`rc"   # load any host specific file if it exists

function oneline {
    local bname
    bname=`git rev-parse --abbrev-ref HEAD`
    if [ ! -z $1 ]
    then
	bname=$1
    fi
    echo "for branch $bname"
    git log --oneline $bname | head -n 15
}

function shortlog {
    local bname
    bname=`git rev-parse --abbrev-ref HEAD`
    if [ ! -z $1 ]; then
	bname=$1
    fi
    echo "for branch $bname"
    git log --pretty=format:"%h   %<(15,trunc)%aE %<(15,trunc)%ar %s" $bname | head -n 15
}
export EDITOR='emacs'
export LESS='-imj5$R'
export GREP_OPTIONS='-inR --color=always'

# copied from http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
export MARKPATH=$HOME/.marks
function jump {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
_completemarks() {
    command=find
    if hash gfind 2>/dev/null; then
	command=gfind
    fi
    local curw=${COMP_WORDS[COMP_CWORD]}
    local wordlist=$($command $MARKPATH -type l -printf "%f\n")
    COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
    return 0
}

complete -F _completemarks jump unmark
export ANDROID_HOME=/Users/harshit/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH
alias venv="virtualenv env"
alias activate="source env/bin/activate"
