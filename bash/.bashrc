# Master .bashrc file
#   by F. Jerrell Schivers
#
# TODO: Split this up into .bash_functions, .bash_aliases, and .bash_prompt.  Then:
#   if [ -f ~/.bash_functions ]; then
#      . ~/.bash_functions
#  fi


# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups

# We want the 256 color mode of xterm.  Among other things, tmux takes advantage of this.
export TERM=xterm-256color

# Set the maximum number of lines kept in history
export HISTFILESIZE=10000

# Add a timestamp for history
export HISTTIMEFORMAT='%Y-%b-%d %H:%M:%S '

# Set the default editor
export VISUAL="emacs -nw --no-desktop"

# Set my Emacs theme
export EMACS_THEME=doom-outrun-electric

# Setup GIT environment
export GIT_EDITOR="emacs --no-desktop"
export GIT_AUTHOR_EMAIL=jerrell@bordercore.com
export GIT_AUTHOR_NAME='F. Jerrell Schivers'

# LESS options
#
#   Searches in less should not be case-sensitive.
#   Set tab stops to be multiples of 4.
#   Cause ANSI "color" escape sequences to be output in "raw" form
export LESS="--ignore-case --tabs=4 --RAW-CONTROL-CHARS"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Point nethack to my personal config file
#export NETHACKOPTIONS="@/usr/lib/games/nethackdir/config/nethackrc-jerrell"

export CLASSPATH=$CLASSPATH:.

# Options for the ack grep replacement
export ACK_OPTIONS="--ignore-case --ignore-dir=$WWW/docs --ignore-dir=$WWW/rdf --ignore-dir=$WWW/yui"

# Create an alias for emacsclient, starting (and connecting to) an Emacs daemon if one already isn't running
alias e='emacsclient --no-wait --alternate-editor=""'

# Set up misc aliases
alias ccc="rm *~"
alias dls="ls -l | grep \"^d\""
alias f="find . |grep "
alias grep="grep --directories=skip --color=auto"
alias mp="mypy --config-file $HOME/mypy.ini"
alias mv="mv -i"
alias pl="pylint --load-plugins pylint_django --django-settings-module=config.settings.dev"
alias pp='python -mjson.tool'  # JSON pretty-printer
alias rls="ls -l -r -h -B -t"
alias rm="rm -i"
alias sniff="sudo tethereal -n -l"
alias tf='tail -f'
alias tw='tmux rename-window'

alias html2md="xclip -o -selection clipboard -t text/html \
      | pandoc -r html-native_divs-native_spans \
      --filter $HOME/.pandoc_filter.py \
      -w markdown-raw_html-link_attributes-header_attributes-smart-smart-tex_math_dollars \
      | awk '{gsub(/\xc2\xa0/,\" \"); print}' \
      | xclip -i -selection clipboard"

# Mac-specific stuff here
if [ `uname` == "Darwin" ]; then

    # Inspired by https://stackoverflow.com/questions/17217450/how-to-get-html-data-out-of-of-the-os-x-pasteboard-clipboard

    alias html2md="swift $HOME/bin/pbpaste.swift \
          | pandoc -r html-native_divs-native_spans \
          --filter $HOME/.pandoc_filter.py \
          -w markdown-raw_html-link_attributes-header_attributes-smart \
          | awk '{gsub(/\xc2\xa0/,\" \"); print}' \
          | pbcopy"

    # Required for building some packages using Catalina
    export CPATH=`xcrun --show-sdk-path`/usr/include

    # Set the LESSOPEN variable to use lesspipe, if installed
    less_output=$(lesspipe.sh 2> /dev/null)
    if [ $? -eq 0 ] ; then
        eval "$less_output"
    fi

fi

# Customize ls colors.  On OS X we assume the coreutils package has been installed
#  via MacPorts to provide 'dircolors' and the GNU ls.  You must also place
#  /opt/local/libexec/gnubin at the front of your PATH
if which dircolors > /dev/null && [ -f $HOME/.dir_colors ]; then
   eval `dircolors $HOME/.dir_colors`
   alias ls='ls -F --color=auto'
fi

# Directory navigation aliases
alias ..='cd ..'
alias ...='cd ../..'

# usefull alias to browse your filesystem for heavy usage quickly
alias ducks='find . -maxdepth 1 -mindepth 1 -print0  | xargs -0 -n1 du -ks | sort -rn | head -16 | cut -f2 | xargs -I {} du -hs {}'

# Look for dot files
alias l.='ls -d .[[:alnum:]]* 2> /dev/null || echo "No hidden file here..."'

# Prevent core dumps
ulimit -c 0

set noclobber

if [ -f $HOME/.prompt ]; then
   source $HOME/.prompt
   set_prompt
fi

# Support for color man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

function dis {

    export DISPLAY=$1:0.0

}

findclass () {

    find . -name "*.jar" | while read file; do echo "Processing ${file}"; jar -tvf $file | grep -i "$1.class"; done

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

es () {
    if [ ! -z $1 ] ; then
        curl -s -XGET "http://$ELASTICSEARCH_ENDPOINT:9200/bordercore/_search?pretty=true&q=uuid:$1"
    else
        echo "Please specify the uuid"
    fi
}

#
# Source your location or host specific .bashrc file here
#
for f in $HOME/.bashrc-*; do

    ## Check if the glob gets expanded to existing files.
    ## If not, f here will be exactly the pattern above
    ## and the exists test will evaluate to false.
    [ -e "$f" ] && . "$f"

    ## Break after the first match
    break

done

# Remove duplicate PATH entries
# https://www.linuxjournal.com/content/removing-duplicate-path-entries-reboot
PATH=$(n= IFS=':'; for e in $PATH; do [[ :$n == *:$e:* ]] || n+=$e:; done; echo "${n:0: -1}")
