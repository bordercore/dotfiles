# shellcheck shell=bash
# ------------------------------------------------------------------------------
# MASTER .BASHRC FILE
#   by F. Jerrell Schivers
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# SOURCE GLOBAL DEFINITIONS
# ------------------------------------------------------------------------------

if [ -f /etc/bashrc ]; then
    # shellcheck disable=SC1091
    source /etc/bashrc
fi

# ------------------------------------------------------------------------------
# INTERACTIVE SHELL CHECK
# ------------------------------------------------------------------------------

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# ------------------------------------------------------------------------------

# Terminal settings
export TERM=xterm-256color

# History settings
export HISTFILESIZE=10000
export HISTTIMEFORMAT='%Y-%b-%d %H:%M:%S '
#export HISTCONTROL=ignoredups

# Editor settings
export VISUAL="emacs -nw --no-desktop"
export EMACS_THEME=doom-outrun-electric

# Git settings
export GIT_EDITOR="emacs --no-desktop"
export GIT_AUTHOR_EMAIL=jerrell@bordercore.com
export GIT_AUTHOR_NAME="F. Jerrell Schivers"

# LESS options
#   --ignore-case: searches in less should not be case-sensitive
#   --tabs=4: set tab stops to be multiples of 4
#   --RAW-CONTROL-CHARS: cause ANSI "color" escape sequences to be output in "raw" form
export LESS="--ignore-case --tabs=4 --RAW-CONTROL-CHARS"

# Support for color man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Java CLASSPATH - append current directory
export CLASSPATH="${CLASSPATH:+$CLASSPATH:}."

# ------------------------------------------------------------------------------
# PATH CONFIGURATION
# ------------------------------------------------------------------------------

# uv binaries are installed here
export PATH="$PATH:$HOME/.local/bin"

# ------------------------------------------------------------------------------
# SHELL OPTIONS
# ------------------------------------------------------------------------------

# Prevent core dumps
ulimit -c 0

# Prevent accidental overwriting of existing files when using > redirection
set -o noclobber

# ------------------------------------------------------------------------------
# TOOL INITIALIZATION
# ------------------------------------------------------------------------------

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Use pyenv to support earlier versions of Python (eg Python 3.12.x)
if command -v pyenv &> /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# Customize ls colors. On macOS we assume coreutils is installed via MacPorts
# to provide 'dircolors' and GNU ls. Place /opt/local/libexec/gnubin in PATH.
if which dircolors > /dev/null && [ -f "$HOME"/.dir_colors ]; then
    eval "$(dircolors -b "$HOME/.dir_colors")"
    alias ls='ls -F --color=auto'
fi

# ------------------------------------------------------------------------------
# ALIASES - File Operations
# ------------------------------------------------------------------------------

alias ccc="rm *~"
alias mv="mv -i"
alias rm="rm -i"

# List files sorted by modification time, long format, human-readable sizes, ignore backups
# Use eza if available (with git status and header), otherwise fall back to ls
if command -v eza >/dev/null 2>&1; then
    # eza options:
    #   --long: long format (detailed listing with permissions, owner, size, date)
    #   --header: show header row with column names
    #   --git: show git status for each file (tracked/ignored/modified)
    #   --sort newest: sort by modification time, newest first
    #   --ignore-glob "*~": ignore backup files (files ending with ~)
    alias rls="eza --long --header --git --sort newest --ignore-glob '*~'"
else
    # ls options:
    #   -l: long format (detailed listing with permissions, owner, size, date)
    #   -r: reverse sort order (reverses the -t time sort, showing oldest files first)
    #   -h: human-readable file sizes (e.g., 1K, 234M, 2.5G instead of bytes)
    #   -B: ignore backup files (files ending with ~)
    #   -t: sort by modification time (newest first by default; combined with -r shows oldest first)
    alias rls="ls -l -r -h -B -t"
fi

alias dls="ls -l | grep \"^d\""
alias l.='ls -d .[[:alnum:]]* 2> /dev/null || echo "No hidden file here..."'

# ------------------------------------------------------------------------------
# ALIASES - Directory Navigation
# ------------------------------------------------------------------------------

alias ..="cd .."
alias ...="cd ../.."

# ------------------------------------------------------------------------------
# ALIASES - Development Tools
# ------------------------------------------------------------------------------

# Emacs
alias e='emacsclient --no-wait --alternate-editor=""'

# Python
alias p3="python3"
alias mp='mypy --config-file "$HOME/mypy.in"'
alias pl='pylint -v --rc-file="$HOME/dev/django/bordercore/pyproject.toml"'
alias pp='python -mjson.tool'  # JSON pretty-printer

# Git
alias cdiff="git -c color.diff.old='red bold' \
    -c color.diff.new='green bold' \
    diff --no-index --word-diff=color"

# ------------------------------------------------------------------------------
# ALIASES - System Utilities
# ------------------------------------------------------------------------------

alias f="find . |grep "
alias grep="grep --directories=skip --color=auto"
alias sniff="sudo tethereal -n -l"
alias tf='tail -f'
alias tw='tmux rename-window'
alias vlc="vlc -q"

# Show disk usage for items in current directory, sorted by size
alias ducks='find . -maxdepth 1 -mindepth 1 -print0  | xargs -0 -n1 du -ks | sort -rn | head -16 | cut -f2 | xargs -I {} du -hs {}'

# ------------------------------------------------------------------------------
# FUNCTIONS
# ------------------------------------------------------------------------------

# Run a command and copy both stdout and stderr to the clipboard
#   Usage: clipall some_command [args...]
function clipall () {
    "$@" 2>&1 | xclip -selection clipboard
    echo "[stdout+stderr copied to clipboard]"
}

# Convert HTML from clipboard to Markdown (Linux version, macOS override below)
html2md() {
    xclip -o -selection clipboard -t text/html \
      | pandoc -r html-native_divs-native_spans \
      --filter "$HOME/.pandoc_filter.py" \
      -w markdown-raw_html-link_attributes-header_attributes-smart-smart-tex_math_dollars \
      | awk '{gsub(/\xc2\xa0/," "); print}' \
      | xclip -i -selection clipboard
}

# Set DISPLAY environment variable
function dis {
    export DISPLAY=$1:0.0
}

# Search for a class in JAR files
findclass () {
    [[ -z "$1" ]] && { echo "Usage: findclass CLASSNAME" >&2; return 1; }

    find . -name "*.jar" -exec sh -c '
        classname="$1"
        shift
        for file do
            echo "Processing $file"
            jar -tf "$file" | grep -Fi "${classname}.class"
        done
    ' sh "$1" {} +
}

# Extract various archive formats
extract () {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)  tar xjf "$1"    ;;
            *.tar.gz)   tar xzf "$1"    ;;
            *.bz2)      bunzip2 "$1"    ;;
            *.rar)      rar x "$1"      ;;
            *.gz)       gunzip "$1"     ;;
            *.tar)      tar xf "$1"     ;;
            *.tbz2)     tar xjf "$1"    ;;
            *.tgz)      tar xzf "$1"    ;;
            *.zip)      unzip "$1"      ;;
            *.Z)        uncompress "$1" ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Search for processes by name
psgrep () {
    if [ -n "$1" ] ; then
        echo "Grepping for processes matching $1..."
        # shellcheck disable=SC2009
        ps aux | grep "$1" | grep -v grep
    else
        echo "!! Need name to grep for"
    fi
}

# Query Elasticsearch by UUID
es () {
    if [ -n "$1" ] ; then
        curl -s -XGET "$ELASTICSEARCH_ENDPOINT:9200/bordercore/_search?pretty=true&q=uuid:$1"
    else
        echo "Please specify the uuid"
    fi
}

# ------------------------------------------------------------------------------
# PLATFORM-SPECIFIC (macOS)
# ------------------------------------------------------------------------------

if [ "$(uname)" == "Darwin" ]; then

    # Convert HTML from clipboard to Markdown (macOS version)
    # https://stackoverflow.com/questions/17217450/how-to-get-html-data-out-of-of-the-os-x-pasteboard-clipboard
    html2md() {
        swift "$HOME/bin/pbpaste.swift" \
          | pandoc -r html-native_divs-native_spans \
          --filter "$HOME/.pandoc_filter.py" \
          -w markdown-raw_html-link_attributes-header_attributes-smart \
          | awk '{gsub(/\xc2\xa0/," "); print}' \
          | pbcopy
    }

    # Set the LESSOPEN variable to use lesspipe, if installed
    if less_output=$(lesspipe.sh 2>/dev/null); then
        eval "$less_output"
    fi

fi

# ------------------------------------------------------------------------------
# PROMPT CONFIGURATION
# ------------------------------------------------------------------------------

if [ -f "$HOME"/.prompt ]; then
    # shellcheck disable=SC1091
    source "$HOME"/.prompt
    set_prompt
fi

# ------------------------------------------------------------------------------
# HOST-SPECIFIC CONFIGURATION
# ------------------------------------------------------------------------------

# Source location or host specific .bashrc file (e.g., .bashrc-work, .bashrc-home)
for f in "$HOME"/.bashrc-*; do
    # Check if the glob gets expanded to existing files.
    # If not, f here will be exactly the pattern above
    # and the exists test will evaluate to false.
    # shellcheck disable=SC1090
    [ -e "$f" ] && source "$f"

    # Break after the first match
    break
done

# ------------------------------------------------------------------------------
# CLEANUP
# ------------------------------------------------------------------------------

# Remove duplicate PATH entries
# https://www.linuxjournal.com/content/removing-duplicate-path-entries-reboot
PATH=$(
    n=''
    IFS=':'
    for e in $PATH; do
        [[ :$n == *:$e:* ]] || n+=$e:
    done
    echo "${n:0:-1}"
)
