export CLICOLOR=1
export LSCOLORS=exgxfxDxcxDxDxCxCxHbHb
export GREP_OPTIONS="--exclude=\*.svn\*"
export EDITOR=vim
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Shortcuts
# =========
alias mv="mv -i"
alias cp="cp -i"
alias ls='ls -G'


# MacPorts Installer addition on 2010-08-28_at_00:57:51: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.



export WORKON_HOME=$HOME/.virtualenvs
source /opt/local/Library/Frameworks/Python.framework/Versions/2.6/bin/virtualenvwrapper.sh


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color) color_prompt=yes;;
esac

##################
# Code # Color #
##################
# 00 # Off #
# 30 # Black #
# 31 # Red #
# 32 # Green #
# 33 # Yellow #
# 34 # Blue #
# 35 # Magenta #
# 36 # Cyan #
# 37 # White #
##################

# Dark colors: \[\033[0;??m\]
# Light colors: \[\033[1;??m\]

function color {
    echo "\[\033[$1;$2m\]"
}

c_prompt=`color 0 33`
c_path=`color 0 32`
c_branch=`color 0 31`
c_tag=`color 1 34`
c_off=`color 0 00`

function git_branch {
    #__git_ps1 " %s"
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function git_tag {
    tag=`git describe --exact-match --tags HEAD 2> /dev/null`
    [ -z "$tag" ] && return 1

    echo " $tag"
}

PS1="${c_prompt}[\u@\h ${c_path}\W$c_branch\$(git_branch)$c_tag\$(git_tag)${c_prompt}]${c_off} "

unset color_prompt force_color_prompt
unset c_prompt c_path c_branch c_tag c_off

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
# Load fabfile completion
    . ~/bin/fab_bash_completion
    . ~/bin/vagrant_bash_completion

    # Enable pip completion
    [[ -n `which pip` ]] && eval "`pip completion --bash`"
fi


# Add user bin to the path
[ -d "$HOME/bin" ] && PATH="$PATH:$HOME/bin"
# Add user opt bin to the path
[ -d "$HOME/opt/bin" ] && PATH="$PATH:$HOME/opt/bin"

# Virtualenvs
if [[ -f '/usr/local/bin/virtualenvwrapper.sh' ]]; then
    export WORKON_HOME="$HOME/.virtualenvs"
    source "/usr/local/bin/virtualenvwrapper.sh"
    # Pip options for virtualenv
    export PIP_RESPECT_VIRTUALENV=true
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
fi

# Enable nose rednose plugin for colored output
export NOSE_REDNOSE=1

# ALIASES
# Easy file search
alias ff='~/bin/find-file.sh'
# Remove pyc
alias rmpyc='find -iname "*.pyc" -delete'

# Extra setup
[ -f ~/.bashprofile ] && . ~/.bashprofile

. /opt/local/django_src/trunk/extras/django_bash_completion
