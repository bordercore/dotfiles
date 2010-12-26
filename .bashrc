# Master .bashrc file
#   by F. Jerrell Schivers
#
# TODO: Split this up into .bash_functions, .bash_aliases, and .bash_prompt.  Then:
#   if [ -f ~/.bash_functions ]; then
#      . ~/.bash_functions
#  fi

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups

# Set the maximum number of lines kept in history
export HISTFILESIZE=1000

# Add a timestamp for history
export HISTTIMEFORMAT='%Y-%b-%d %H:%M:%S '

# Set the default editor
export VISUAL="emacs -nw"

# Use emacs for git commit log messages
export GIT_EDITOR=emacs

# Searches in less should not be case-sensitive
export LESS="--ignore-case"

export GREP_OPTIONS="--directories=skip --color=always"

# define color to additional file types
export LS_COLORS=$LS_COLORS:"*.gif=01;35":"*.jpg=01;35":"*.png=01;35":

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

#setup color ls
#eval `dircolors /etc/DIR_COLORS.xterm`

# Point nethack to my personal config file
#export NETHACKOPTIONS="@/usr/lib/games/nethackdir/config/nethackrc-jerrell"

# Set the default DN for LDAP operations
export LDAPBINDDN="cn=Manager,dc=bordercore,dc=com"

export CLASSPATH=/usr/share/java/xerces-1.4.4.jar
export CLASSPATH=$CLASSPATH:/usr/share/java/gnumail.jar
export CLASSPATH=$CLASSPATH:/usr/share/java/activation.jar
export CLASSPATH=$CLASSPATH:/usr/share/java/inetlib.jar
export CLASSPATH=$CLASSPATH:.

export WWW=/home/www/htdocs/bordercore

# Options for the ack grep replacement
export ACK_OPTIONS="--ignore-dir=$WWW/docs --ignore-dir=$WWW/rdf --ignore-dir=$WWW/yui"

export PGDATABASE=bordercore
export PGHOST=localhost
export PGUSER=bordercore

# Set up the aliases
alias rm="rm -i"
alias ls="ls -F --color=tty"
alias ccc="rm *~"
alias rls="ls -l -r -h -B --sort=time"
alias dls="ls -l | grep \"^d\""
alias sniff="sudo tethereal -n -l"
alias f="find . |grep "
alias tf='tail -f'

# Directory navigation aliases
alias ..='cd ..'
alias ...='cd ../..'

# Ignore whitespace when using the svn diff command
alias svndiff='svn diff --diff-cmd diff -x -uw'

# usefull alias to browse your filesystem for heavy usage quickly
alias ducks='find . -maxdepth 1 -mindepth 1 -print0  | xargs -0 -n1 du -ks | sort -rn | head -16 | cut -f2 | xargs -i du -hs {}'

if [ -e ~/.fetchmail.pid ];
then
    alias checkmail="kill -SIGUSR1 `cat ~/.fetchmail.pid | cut -f 1 -d \" \"`"
fi

# Prevent core dumps
ulimit -c 0

set noclobber

source $HOME/.prompt
set_prompt

function dis {

    export DISPLAY=$1:0.0

}

extract () {
    if [ -f $1 ] ; then
	case $1 in
	    *.tar.bz2)  tar xjf $1    ;;
            *.tar.gz)   tar xzf $1    ;;
            *.bz2)      bunzip2 $1    ;;
            *.rar)      rar x $1      ;;
            *.gz)       gunzip $1     ;;
            *.tar)      tar xf $1     ;;
            *.tbz2)     tar xjf $1    ;;
            *.tgz)      tar xzf $1    ;;
            *.zip)      unzip $1      ;;
            *.Z)        uncompress $1 ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
         esac
    else
        echo "'$1' is not a valid file"
    fi
}

psgrep () {
    if [ ! -z $1 ] ; then
	echo "Grepping for processes matching $1..."
	ps aux | grep $1 | grep -v grep
	else
	echo "!! Need name to grep for"
	fi
}

#then
#    . /home/jerrell/.bashprompt/bashthemes/nergal
#else
#    export PS1="[\h \u \w] "
#fi

#/usr/games/fortune

if [ -f /usr/local/etc/jerrell.sh ];then
    . /usr/local/etc/jerrell.sh
fi

# Wumpus specific stuff here
export PATH=$PATH:/home/jerrell/bin:/usr/games:/usr/sbin:/sbin
export PATH=$PATH:$HOME/bin
