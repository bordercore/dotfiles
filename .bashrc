# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PATH=$PATH:/home/jerrell/bin:/usr/games:/usr/sbin:/sbin
export PATH=$PATH:$HOME/bin
export MANPATH=$MANPATH:/var/qmail/man
export VISUAL="emacs -nw"
export history=100

# Use emacs for git commit log messages
export GIT_EDITOR=emacs

# Searches in less should not be case-sensitive
export LESS="--ignore-case"

export GREP_OPTIONS="--directories=skip --color=always"

# This lets 'less' view certain binary files
eval $(lesspipe)

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

export CVSROOT=/home/cvs
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

function alert {

    sleep $1; play /usr/share/sounds/gnibbles/bonus.wav

}

#if test $COLORTERM
#then
#    . /home/jerrell/.bashprompt/bashthemes/nergal
#else
#    export PS1="[\h \u \w] "
#fi

#/usr/games/fortune

if [ -f /usr/local/etc/jerrell.sh ];then
    . /usr/local/etc/jerrell.sh
fi
