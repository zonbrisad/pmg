#!/bin/bash
# ---------------------------------------------------------------------------
#
# PERSONAL $HOME/.bashrc FILE for bash-3.0 (or later)
# By Peter Malmberg
#

#
#  See for instance:
#  http://tldp.org/LDP/abs/html/index.html
#  http://www.caliban.org/bash
#  http://www.shelldorado.com/scripts/categories.html
#  http://www.dotfiles.org
#
# ---------------------------------------------------------------------------

# Display commands as they are executed
#set -o xtrace
# Display shell input lines as they are read
#set -v

# Exit script when a command fails. Append ||true if error is expected
#set -o errexit # || true
# Exit script when undeclared variable is used
#set -o nounset

# Host specific vars --------------------------------------------------------

HOSTNAME=$(hostname)
OS=$(uname -s)

# Paths ---------------------------------------------------------------------

export LD_LIBRARY_PATH=/usr/local/lib

# Application settings ------------------------------------------------------
export SVN_EDITOR=jed

# Needed for gdb
export SHELL=/bin/bash

# Host specific setting -----------------------------------------------------

HOSTNAME=$(hostname)

# Host: fileserver ----------------------------------------------------------

host_lstation() {
	# Starship prompt
	if bpHasCmd starship; then
		eval "$(starship init bash)"
	fi
}

host_lliten() {
	# Starship prompt
	if bpHasCmd starship; then
		eval "$(starship init bash)"
	fi
}

host_rpexp() {
	:
}

host_fileserver() {
	alias lef='cd ~/Projekt/LEF'
	#	alias mp='cd ~/Projekt/makeplates'
	#	alias bp='cd ~/Projekt/bashplates'
	alias b='cd /storage/backup/fileserver'
	alias b0='cd /storage/backup/fileserver/daily_0/storage/home/pmg'
	alias b1='cd /storage/backup/fileserver/daily_1/storage/home/pmg'
	alias b2='cd /storage/backup/fileserver/daily_2/storage/home/pmg'
	alias b3='cd /storage/backup/fileserver/daily_3/storage/home/pmg'
	alias b4='cd /storage/backup/fileserver/daily_4/storage/home/pmg'
	alias b5='cd /storage/backup/fileserver/daily_5/storage/home/pmg'

	# Load bashplate settings
	#  source ~/Tester/bashplates/bp_init
}

# Host: ustation ------------------------------------------------------------
host_ustation() {

	alias lef='cd ~/Projekt/LEF'

	# PyQt5 example and demos
	alias pqe='cd /usr/share/doc/pyqt5-examples/examples'
}

#---------------------------------------------------------------------
# bashrc personal functions
#---------------------------------------------------------------------

bpInstall() { ## Install a package
	bpAssertRoot
	dpkg -i "$1"
	apt-get install -f
}

#---------------------------------------------------------------------
# bashrc settings
#---------------------------------------------------------------------
bpInitSettings() {

	echo
}

#---------------------------------------------------------------------
# Signal traps
#---------------------------------------------------------------------

function bpExit() { # Function to run
	return 1
}

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

FLAG_BLUE="\x1b[48;5;20m"
FLAG_YELLOW="\x1b[48;5;226m"

flag() {
	echo -e "${FLAG_BLUE}        ${FLAG_YELLOW}  ${FLAG_BLUE}               ${E_END}"
	echo -e "${FLAG_BLUE}        ${FLAG_YELLOW}  ${FLAG_BLUE}               ${E_END}"
	echo -e "${FLAG_BLUE}        ${FLAG_YELLOW}  ${FLAG_BLUE}               ${E_END}"
	echo -e "${FLAG_YELLOW}                         ${E_END}"
	echo -e "${FLAG_BLUE}        ${FLAG_YELLOW}  ${FLAG_BLUE}               ${E_END}"
	echo -e "${FLAG_BLUE}        ${FLAG_YELLOW}  ${FLAG_BLUE}               ${E_END}"
	echo -e "${FLAG_BLUE}        ${FLAG_YELLOW}  ${FLAG_BLUE}               ${E_END}"
}

take() { ##D Create directory and enter it
	mkdir -p "$1"
	cd "$1"
}

get_xserver() {
	case $TERM in
	xterm | xterm-256color)
		XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(')
		# Ane-Pieter Wieringa suggests the following alternative:
		#  I_AM=$(who am i)
		#  SERVER=${I_AM#*(}
		#  SERVER=${SERVER%*)}
		XSERVER=${XSERVER%%:*}
		;;
	aterm | rxvt)
		# Find some code that works here. ...
		;;
	esac
}

bpInitDisplay() { ##D Init DISPLAY variable

	if [ -z "${DISPLAY:=""}" ]; then
		get_xserver
		echo "XSERVER = $XSERVER"
		if [[ -z ${XSERVER} || ${XSERVER} == $(hostname) || ${XSERVER} == "unix" ]]; then
			DISPLAY=":0.0" # Display on local host.
		else
			DISPLAY=${XSERVER}:0.0 # Display on remote host.
		fi
	fi

	export DISPLAY
}

# Some settings -------------------------------------------------------------

#set -o nounset     # These  two options are useful for debugging.
#set -o xtrace
alias debug="set -o nounset; set -o xtrace"
alias debugoff="set +o nounset; set +o xtrace"

ulimit -S -c 0 # Don't want coredumps.
set -o notify
set -o noclobber
#set -o ignoreeof

# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob # Necessary for programmable completion.

# Disable options:
shopt -u mailwarn
unset MAILCHECK # Don't want my shell to warn me of incoming mail.

#---------------------------------------------------------------------
# System functions and settings
#---------------------------------------------------------------------

#---------------------------------------------------------------------
# ANSI escape codes
#---------------------------------------------------------------------

# ANSI foreground colors codes
#
E_BLACK=$'\e[38:5:0m'       # Black
E_RED=$'\e[38:5:1m'         # Red
E_GREEN=$'\e[38:5:2m'       # Green
E_YELLOW=$'\e[38:5:3m'      # Yellow
E_BLUE=$'\e[38:5:4m'        # Blue
E_MAGENTA=$'\e[38:5:5m'     # Magenta
E_CYAN=$'\e[38:5:6m'        # Cyan
E_GRAY=$'\e[38:5:7m'        # Gray
E_DARKGRAY=$'\e[38:5:8m'    # Dark Gray
E_BR_RED=$'\e[38:5:9m'      # Bright Red
E_BR_GREEN=$'\e[38:5:10m'   # Bright Green
E_BR_YELLOW=$'\e[38:5:11m'  # Bright Yellow
E_BR_BLUE=$'\e[38:5:12m'    # Bright Blue
E_BR_MAGENTA=$'\e[38:5:13m' # Bright Magenta
E_BR_CYAN=$'\e[38:5:14m'    # Bright Cyan
E_WHITE=$'\e[38:5:15m'      # White

# ANSI background color codes
#
E_BG_BLACK=$'\e[48;5;0m'       # Black
E_BG_RED=$'\e[48;5;1m'         # Red
E_BG_GREEN=$'\e[48;5;2m'       # Green
E_BG_YELLOW=$'\e[48;5;3m'      # Yellow
E_BG_BLUE=$'\e[48;5;4m'        # Blue
E_BG_MAGENTA=$'\e[48;5;5m'     # Magenta
E_BG_CYAN=$'\e[48;5;6m'        # Cyan
E_BG_GRAY=$'\e[48;5;7m'        # Gray
E_BG_DARK_GRAY=$'\e[48;5;8m'   # Dark gray
E_BG_BR_RED=$'\e[48;5;9m'      # Bright Red
E_BG_BR_GREEN=$'\e[48;5;10m'   # Bright Green
E_BG_BR_YELLOW=$'\e[48;5;11m'  # Bright Yellow
E_BG_BR_BLUE=$'\e[48;5;12m'    # Bright Blue
E_BG_BR_MAGENTA=$'\e[48;5;13m' # Bright Magenta
E_BG_BR_CYAN=$'\e[48;5;14m'    # Bright Cyan
E_BG_WHITE=$'\e[48;5;15m'      # White

# ANSI underline color codes
#
# Not in standard. implemented in Kitty, VTE, mintty, etc.
#
E_UL_BLACK=$'\e[58;5;0m'       # Black
E_UL_RED=$'\e[58;5;1m'         # Red
E_UL_GREEN=$'\e[58;5;2m'       # Green
E_UL_YELLOW=$'\e[58;5;3m'      # Yellow
E_UL_BLUE=$'\e[58;5;4m'        # Blue
E_UL_MAGENTA=$'\e[58;5;5m'     # Magenta
E_UL_CYAN=$'\e[58;5;6m'        # Cyan
E_UL_GRAY=$'\e[58;5;7m'        # Gray
E_UL_DARKGRAY=$'\e[58;5;8m'    # Dark Gray
E_UL_BR_RED=$'\e[58;5;9m'      # Bright Red
E_UL_BR_GREEN=$'\e[58;5;10m'   # Bright Green
E_UL_BR_YELLOW=$'\e[58;5;11m'  # Bright Yellow
E_UL_BR_BLUE=$'\e[58;5;12m'    # Bright Blue
E_UL_BR_MAGENTA=$'\e[58;5;13m' # Bright Magenta
E_UL_BR_CYAN=$'\e[58;5;14m'    # Bright Cyan
E_UL_WHITE=$'\e[58;5;15m'      # White

# ANSI Text attributes
E_BOLD=$'\e[1m'               # Bold text
E_DIM=$'\e[2m'                # Dim(low intensity) text
E_ITALIC=$'\e[3m'             # Italic text
E_UNDERLINE=$'\e[4m'          # Underlined text
E_UNDERLINE_DOUBLE=$'\e[4:2m' # Double underline (limited support)
E_UNDERLINE_CURLY=$'\e[4:3m'  # Curly underline (limited support)
E_UNDERLINE_DOT=$'\e[4:4m'    # Dotted underline (limited support)
E_UNDERLINE_DASH=$'\e[4:5m'   # Dashed underline (limited support)
E_BLINK=$'\e[5m'              # Blinking text
E_RAPID_BLINK=$'\e[6m'        # Rapid blink (Limited support)
E_REVERSE=$'\e[7m'            # Reverse color
E_CROSSED=$'\e[9m'            # Crossed over text
E_FRAKTUR=$'\e[20m'           # Gothic (limited support)
E_FRAMED=$'\e[51m'            # Framed (limited support)
E_OVERLINED=$'\e[53m'         # Overlined text
E_SUPERSCRIPT=$'\e[73m'       # Superscript text (limited support)
E_SUBSCRIPT=$'\e[74m'         # Subscript text (limited support)

# ANSI cursor operations
#
E_RETURN=$'\e[F'  # Move cursor to begining of line
E_UP=$'\e[A'      # Move cursor one line up
E_DOWN=$'\e[B'    # Move cursor one line down
E_FORWARD=$'\e[C' # Move cursor forward
E_BACK=$'\e[D'    # Move cursor backward
E_HIDE=$'\e[?25l' # Hide cursor
E_SHOW=$'\e[?25h' # Show cursor

E_RESET=$'\e[0m' # Clear Attributes

# Default Bashplate colortheme
BP_C_OK="${E_BR_GREEN}"
BP_C_INFO="${E_BR_CYAN}"
BP_C_DEBUG="${E_BG_GREEN}${E_WHITE}"
BP_C_WARNING="${E_BR_YELLOW}"
BP_C_ERROR="${E_BR_RED}"
BP_C_CRITICAL="${E_BG_RED}${E_WHITE}"
BP_C_LINE="${E_DARKGRAY}"
BP_C_LINETEXT="${E_YELLOW}"
BP_C_DESCRIPTION="${E_CYAN}"
BP_C_KEY="${E_BR_MAGENTA}"

BP_C_FILENAME="${E_BR_CYAN}"
BP_C_PATH="${E_CYAN}"
BP_C_URL_SCHEME="${E_DARKGRAY}"
# BP_C_URL_USER=""
# BP_C_URL_HOST=""
BP_C_TIME="${E_BR_MAGENTA}"
BP_C_DATE="${E_MAGENTA}"

# Shellscript colorize colors
BP_C_RESERVED="${E_RED}"
BP_C_COMMENT="${E_CYAN}"
BP_C_STRING="${E_GREEN}"
BP_C_VAR="${E_BR_YELLOW}"

# Exit codes
#
BP_OK=0 # successful termination

# Exit codes
#
BP_E_OK=0 # successful termination

ALERT=${BWhite}${On_Red} # Bold White on red background

# Logging ---------------------------------------------------------

##CN- IHELP Log functions

#
# Function logging to file
#
# Arg1 String to log to file
#
bpLog() { ##D Log to file command
	# check for LOGFILE variable
	if [ -n "$LOGFILE" ]; then
		ts=$(date +"%Y-%m-%d %H:%M:%S")
		bpFilterEscape "$ts $1" >>"${LOGFILE}"
	fi
}

bpLogOk() { ##D Log Ok message to file
	bpLog "[ Ok ] $1"
}

bpLogInfo() { ##D Log Info message to file
	bpLog "[Info] $1"
}

bpLogDebug() { ##I Log Info message to file
	bpLog "[Debg] $1"
}

bpLogWarning() { ##D Log Warning message to file
	bpLog "[Warn] $1"
}

bpLogError() { ##D Log Error message to file
	bpLog "[Erro] $1"
}

bpLogCritical() { ##D Log Critical message to file
	bpLog "[Crit] $1"
}

##CN- IHELP Message

bpOk() { ##D Success message
	if [ -n "$LOG_OK" ]; then
		bpLogOk "$1"
	fi
	echo -e "[${BP_C_OK}Ok${E_END}] $1"
}

bpInfo() { ##D Info message
	if [ -n "$LOG_INFO" ]; then
		bpLogInfo "$1"
	fi
	echo -e "[${BP_C_INFO}Info${E_END}]  $1"
}

bpWarning() { ##D Warning message
	if [ -n "$LOG_WARNING" ]; then
		bpLogWarning "$1"
	fi
	echo -e "[${BP_C_WARNING}Warning${E_END}] $1"
}

bpError() { ##D Error message
	if [ -n "$LOG_ERROR" ]; then
		bpLogError "$1"
	fi
	echo -e "[${BP_C_ERROR}Error${E_END}] $1"
}

bpCritical() { ##D Critical error message
	if [ -n "$LOG_CRITICAL" ]; then
		bpLogCritical "$1"
	fi
	echo -e "[${BP_C_CRITICAL}Critical${E_END}] $1"
	bpExit
}

##-

# Formating
#
BP_KEY_LENGTH=24
BP_LEFT_MARGIN=3
BP_RIGHT_MARGIN=3

#---------------------------------------------------------------------
# Bashplate internal functions
#---------------------------------------------------------------------

##C- IHELP Printing functions

#
# $1 text to be printed
# $2 text color
# $3 line color
# $4 middle character
# $5 line character
#
bpPrintLineGeneric() { ##I Print text with adjusted line after with selectable colors
	len1="${#1}"
	len4="${#4}"

	echo -en "${2}${1}${4}${3}"
	l=$((BP_COLUMNS - len1 - len4))
	seq -s"${5}" "${l}" | tr -d '[:digit:]'
	echo -en "${E_RESET}"
}

#
# $1 text to be printed
# $2 text color
# $3 line color
#
bpTextLineC() { ##I Print text with adjusted line after with selectable colors
	bpPrintLineGeneric "$1" "$2" "$3" " " "-"
}

bpPrintLine() { ##I Print text with line
	if [ "${#1}" -eq 0 ]; then
		bpPrintLineGeneric "" "" "${BP_C_LINE}" "" "-"
	else
		bpPrintLineGeneric "$1" "${BP_C_LINETEXT}" "${BP_C_LINE}" " " "-"
	fi
}

#
# $1 key color
# $2 description color
# $3 key
# $4 description
# $5 key length override (optional)
#
bpPrintDescGeneric() { # Generic key/description printout function
	KEY_COLOR="$1"
	DESC_COLOR="$2"
	KEY="$3"
	DESC="$4"
	if [ -n "$5" ]; then
		KL="$5"
	else
		KL=${BP_KEY_LENGTH}
	fi

	if ((${#4} == 0)); then
		printf "${1}  %-${KL}.${KL}s${E_RESET} ${2}%s${E_RESET}\n" "$3" ""
	fi

	len=${#}
	a=$(("${BP_COLUMNS}" - "$KL" - "$BP_RIGHT_MARGIN"))
	#LINES=$(fmt -s -w"${a}" <<<"$4")
	LINES=$(fold -w"${a}" <<<"$DESC")
	IFS=$'\n'
	L1=0
	for line in ${LINES}; do
		if [ "${L1}" -eq 0 ]; then               # First line
			if ((${#KEY} > "$BP_KEY_LENGTH")); then # Oversized key
				printf "${KEY_COLOR}  %-${KL}s${E_RESET}\n" "$KEY"
				printf "${KEY_COLOR}  %-${KL}.${KL}s${E_RESET} ${DESC_COLOR}%s${E_RESET}\n" "" "$line"
			else # Normal key
				printf "${KEY_COLOR}  %-${KL}.${KL}s${E_RESET} ${DESC_COLOR}%s${E_RESET}\n" "$KEY" "$line"
			fi
			L1=1
		else # Rest of the lines
			printf "${KEY_COLOR}  %-${KL}.${KL}s${E_RESET} ${DESC_COLOR}%s${E_RESET}\n" "" "$line"
		fi
	done
}

#
# $1 key
# $2 description
# $3 (optional) left alignment
#
bpPrintDesc() { ##I Print key description
	bpPrintDescGeneric "${BP_C_KEY}" "${BP_C_DESCRIPTION}" "$1" "$2" "$3"
}

bpPrintDescAlt() {
	bpPrintDescGeneric "${E_DARKGRAY}" "${BP_C_DESCRIPTION}" "$1" "$2"
}

#
# $1 variablename
# $2 alternative key text (optional)
# $3 alternative value text (optional)
#
bpPrintVar() { ##I Print variable value and description
	VAR="$1"

	if [ -n "$2" ]; then
		KEY=${2}
	else
		KEY="${VAR}"
	fi

	if [ "${!VAR}" ]; then
		if [ -n "$3" ]; then
			VAL=${3}
		else
			VAL="${!VAR}"
		fi

		bpPrintDesc "${KEY}" "${VAL}"
	else
		bpPrintDesc "${KEY}" "${BP_C_ERROR}N/A"
	fi
}

# Colorize string with filename
#
# $1 string with filename to colorize
# ret colorized string
#
bpColorizeFile() { ##D Colorize string with filename
	if [ -n "$1" ]; then
		echo "${BP_C_PATH}$(dirname "$1")/${BP_C_FILENAME}$(basename "$1")${E_END}"
	fi
}

# Various  ---------------------------------------------------------

##CN- IHELP Assert

bpAssertRoot() { ##D Assert that user is root
	if [ "$(whoami)" != root ]; then
		bpError "Must be root to use this command."
		bpExit "1"
	fi
}

bpReload() { ## Reload .bashrc
	source ${HOME}/.bashrc
}

#-------------------------------------------------------------
# Shell Prompt - for many examples, see:
#       http://www.debian-administration.org/articles/205
#       http://www.askapache.com/linux/bash-power-prompt.html
#       http://tldp.org/HOWTO/Bash-Prompt-HOWTO
#       https://github.com/nojhan/liquidprompt
#-------------------------------------------------------------
# Current Format: [TIME USER@HOST PWD] >
# TIME:
#    Green     == machine load is low
#    Orange    == machine load is medium
#    Red       == machine load is high
#    ALERT     == machine load is very high
# USER:
#    Cyan      == normal user
#    Orange    == SU to user
#    Red       == root
# HOST:
#    Cyan      == local session
#    Green     == secured remote connection (via ssh)
#    Red       == unsecured remote connection
# PWD:
#    Green     == more than 10% free disk space
#    Orange    == less than 10% free disk space
#    ALERT     == less than 5% free disk space
#    Red       == current user does not have write privileges
#    Cyan      == current filesystem is size zero (like /proc)
# >:
#    White     == no background or suspended jobs in this shell
#    Cyan      == at least one background job in this shell
#    Orange    == at least one suspended job in this shell
#
#    Command is added to the history file each time you hit enter,
#    so it's available to all shells (using 'history -a').

# Test connection type:
if [ -n "${SSH_CONNECTION}" ]; then
	CNX=${Green} # Connected on remote machine, via ssh (good).
elif [[ "${DISPLAY%%:0*}" != "" ]]; then
	CNX=${ALERT} # Connected on remote machine, not via ssh (bad).
else
	CNX=${BCyan} # Connected on local machine.
fi

# Test user type:
#if [[ ${USER} == "root" ]]; then
#  SU=${Red}           # User is root.
#elif [[ ${USER} != $(logname) ]]; then
#  SU=${BRed}          # User is not login user.
#else
#  SU=${BCyan}         # User is normal (well ... most of us are).
#fi

# Returns a color indicating system load.
function load_color() {
	local SYSLOAD=$(load)
	if [ ${SYSLOAD} -gt ${XLOAD} ]; then
		echo -en ${ALERT}
	elif [ ${SYSLOAD} -gt ${MLOAD} ]; then
		echo -en ${Red}
	elif [ ${SYSLOAD} -gt ${SLOAD} ]; then
		echo -en ${BRed}
	else
		echo -en ${Green}
	fi
}

# Returns a color according to free disk space in $PWD.
function disk_color() {
	if [ ! -w "${PWD}" ]; then
		echo -en ${Red}
		# No 'write' privilege in the current directory.
	elif [ -s "${PWD}" ]; then
		local used=$(command df -P "$PWD" |
			awk 'END {print $5} {sub(/%/,"")}')
		if [ ${used} -gt 95 ]; then
			echo -en ${ALERT} # Disk almost full (>95%).
		elif [ ${used} -gt 90 ]; then
			echo -en ${BRed} # Free disk space almost gone.
		else
			echo -en ${Green} # Free disk space is ok.
		fi
	else
		echo -en ${Cyan}
	# Current directory is size '0' (like /proc, /sys etc).
	fi
}

# Returns a color according to running/suspended jobs.
function job_color() {
	if [ $(jobs -s | wc -l) -gt "0" ]; then
		echo -en ${BRed}
	elif [ $(jobs -r | wc -l) -gt "0" ]; then
		echo -en ${BCyan}
	fi
}

# Adds some text in the terminal frame (if applicable).

# Now we construct the prompt.
PROMPT_COMMAND="history -a"
case ${TERM} in
*term | rxvt | linux | xterm-256color)
	# Time of day (with load info):
	#PS1="\[\$(load_color)\][\A\[${NC}\] "
	#		PS1="\${load_color}["
	# User@Host (with connection type info):
	#		PS1=${PS1}"\[\${SU}\]\u\[\${NC}\]@\[\${CNX}\]\h\[\${NC}\]"
	# PWD (with 'disk space' info):
	#		PS1=${PS1}"\[\${disk_color}\] \W]\[\${NC}\] "
	# Prompt (with 'job' info):
	#		PS1=${PS1}"\[\${job_color}\]>\[\${NC}\] "
	# Set title of current xterm:
	#		PS1=${PS1}"\[\e]0;[\u@\h]\w\a\]"

	# Time of day (with load info):
	#PS1="\[\$(load_color)\][\A\[${NC}\] "
	PS1="\${load_color}["
	# User@Host (with connection type info):
	PS1=${PS1}"\[${SU}\]\u\[${NC}\]@\[${CNX}\]\h\[${NC}\]"
	# PWD (with 'disk space' info):
	PS1=${PS1}"\[\${disk_color}\] \W]\[${NC}\] "
	# Prompt (with 'job' info):
	PS1=${PS1}"\[\${job_color}\]>\[${NC}\] "
	# Set title of current xterm:
	PS1=${PS1}"\[\e]0;[\u@\h]\w\a\]"
	;;
*)
	PS1="(\A \u@\h \W) > " # --> PS1="(\A \u@\h \w) > "
	# --> Shows full pathname of current dir.
	;;
esac

export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTIGNORE="&:bg:fg:ll:h"
export HISTTIMEFORMAT="$(echo -e ${BCyan})[%d/%m%H:%M:%S]$(echo -e ${NC}) "
export HISTCONTROL=ignoredups
export HOSTFILE=$HOME/.hosts # Put a list of remote hosts in ~/.hosts

#============================================================
#
#  ALIASES AND FUNCTIONS
#
#  Arguably, some functions defined here are quite big.
#  If you want to make this file smaller, these functions can
#+ be converted into scripts and removed from here.
#
#============================================================

# Personal Aliases ----------------------------------------------------------

alias lsblk='lsblk --output NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT,UUID'

# Install aliases
alias sui='sudo apt install'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

alias which='type -a'
alias grep='grep --color=auto'
alias du='du -kh' # Makes a more readable output.
alias df='df -kTh'

# If available use batcat instead of cat
if type batcat &>/dev/null; then
	alias cat='batcat --decorations never'
else
	alias cat='cat'
fi

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias ..='cd ..'
alias j='jobs -l'
alias h='history'
alias eb='bpEdit ~/.bashrc'

# The 'ls' family -----------------------------------------------------------

# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color'
alias lx='ls -lXB'  #  Sort by extension.
alias lk='ls -lSr'  #  Sort by size, biggest last.
alias lt='ls -ltr'  #  Sort by date, most recent last.
alias lc='ls -ltcr' #  Sort by/show change time,most recent last.
alias lu='ls -ltur' #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias lm='ll |more'     #  Pipe through 'more'
alias lr='ll -R'        #  Recursive ls.
alias la='ll -A'        #  Show hidden files.
alias tree='tree -Csuh' #  Nice alternative to 'recursive ls' ...

# Git aliases ---------------------------------------------------------------
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit -a'
alias gd='git diff'
alias gl='git log --all --graph --format=oneline'
alias gh='git hist'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gi='pmgp gi'

alias got='git '
alias get='git '

# Tailoring 'less' ----------------------------------------------------------

alias more='less'
export PAGER=less
export LESSCHARSET='latin1'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
# Use this if lesspipe.sh exists.
export LESS='-i -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#-------------------------------------------------------------
# Spelling typos - highly personnal and keyboard-dependent :-)
#-------------------------------------------------------------

alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'

#-------------------------------------------------------------
# A few fun ones
#-------------------------------------------------------------

# Adds some text in the terminal frame (if applicable).

function xtitle() {
	case "$TERM" in
	*term* | rxvt)
		echo -en "\e]0;$*\a"
		;;
	*) ;;
	esac
}

# Aliases that use xtitle
alias top='xtitle Processes on $HOST && top'
alias make='xtitle Making $(basename $PWD) ; make'

# .. and functions
function man() {
	for i; do
		xtitle The $(basename $1 | tr -d .[:digit:]) manual
		command man -a "$i"
	done
}

# File & strings related functions: -----------------------------------------

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'"${1:-}"'*' \
	-exec "${2:-file}" {} \;; }

#  Find a pattern in a set of files and highlight them:
#+ (needs a recent version of egrep).
function fstr() {
	OPTIND=1
	local mycase=""
	local usage="fstr: find string in files. Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
	while getopts :it opt; do
		case "$opt" in
		i) mycase="-i " ;;
		*)
			echo "$usage"
			return
			;;
		esac
	done
	shift $(($OPTIND - 1))
	if [ "$#" -lt 1 ]; then
		echo "$usage"
		return
	fi
	find . -type f -name "${2:-*}" -print0 |
		xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more

}

function swap() { # Swap 2 filenames around, if they exist (from Uzi's bashrc).
	local TMPFILE=tmp.$$

	[ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
	[ ! -e "$1" ] && echo "swap: $1 does not exist" && return 1
	[ ! -e "$2" ] && echo "swap: $2 does not exist" && return 1

	mv "$1" $TMPFILE
	mv "$2" "$1"
	mv $TMPFILE "$2"
}

function extract() { # Handy Extract Program
	if [ -f "$1" ]; then
		case "$1" in
		*.tar.bz2) tar xvjf "$1" ;;
		*.tar.gz) tar xvzf "$1" ;;
		*.bz2) bunzip2 "$1" ;;
		*.rar) unrar x "$1" ;;
		*.gz) gunzip "$1" ;;
		*.tar) tar xvf "$1" ;;
		*.tbz2) tar xvjf "$1" ;;
		*.tgz) tar xvzf "$1" ;;
		*.zip) unzip "$1" ;;
		*.Z) uncompress "$1" ;;
		*.7z) 7z x "$1" ;;
		*) echo "'$1' cannot be extracted via >extract<" ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz" "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1"; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@"; }

#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------

function my_ps() { ps "$@" -u "$USER" -o pid,%cpu,%mem,bsdtime,command; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var="${1:-".*"}"; }

function killps() {          # kill by process name
	local pid pname sig="-TERM" # default signal
	if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
		echo "Usage: killps [-SIGNAL] pattern"
		return
	fi
	if [ $# = 2 ]; then sig=$1; fi
	for pid in $(my_ps | awk '!/awk/ && $0~pat { print $1 }' pat=${!#}); do
		pname=$(my_ps | awk '$1~var { print $5 }' var="$pid")
		if ask "Kill process $pid <$pname> with signal $sig?"; then
			kill "$sig" "$pid"
		fi
	done
}

function bpIp() { # Get IP adress on ethernet.
	ip addr show $(ip route | awk '/default/ { print $5 }') | grep "inet" | head -n 1 | awk '/inet/ {print $2}' | cut -d'/' -f1
}

bpIpInfo() { ##D List all default IP adresses
	read -d "\n" -r -a INTERFACES <<<$(ip route | awk '/default/ { print $5 "\n" $7 }')
	IFS=$'\n'
	LEN=${#INTERFACES[@]}
	i=0
	while [ $i -lt "$LEN" ]; do
		INTERFACE=${INTERFACES[$i]}
		((i++))
		LINK=${INTERFACES[$i]}
		((i++))
		IP=$(ip addr show "${INTERFACE}" | grep "inet" | head -n 1 | awk '/inet/ {print $2}' | cut -d'/' -f1)
		MAC=$(ip addr show "${INTERFACE}" | grep "link/ether" | awk '{print $2}')

		echo "$IP $INTERFACE $LINK $MAC"
	done
}

bpCPU() { # Print CPU info
	lscpu | grep "Model name" | awk '{ print $3" "$4" "$5" "$6" "$7" "$8" "$9 }'
}

function ii() { # Get current host related info.
	echo
	flag
	#	bpLine
	echo
	bpPrintInfo "Hostname:" "$HOSTNAME $NC"
	bpPrintInfo "Username:" "$USER"
	bpPrintInfo "Current date:" "$(date)"
	IFS=$'\n'
	for IP in $(bpIpInfo); do
		bpPrintInfo "IP addr" "$IP"
	done
	bpPrintInfo "Machine Uptime:" "$(uptime -p)"
	bpPrintInfo "Machine Type:" "$(bpCPU)"
	#	bpLine
	#	bpPrintInfo "Disk space:" ""
	#	bpLine
}

function loginInfo() {

	#  echo -e "${BCyan}This is BASH ${BRed}${BASH_VERSION%.*}${BCyan} - DISPLAY on ${BRed}$DISPLAY${NC}\n"
	ii

	if [ -x /usr/games/fortune ]; then
		/usr/games/fortune -s # Makes our day a bit more fun.... :-)
		bpLine
	fi

}

function ask() { # See 'killps' for example of use.
	echo -n "$@" '[y/n] '
	read ans
	case "$ans" in
	y* | Y*) return 0 ;;
	*) return 1 ;;
	esac
}

function corename() { # Get name of app that created a corefile.
	for file; do
		echo -n "$file" :
		gdb --core="$file" --batch | head -1
	done
}

#=========================================================================
#
#  PROGRAMMABLE COMPLETION SECTION
#  Most are taken from the bash 2.05 documentation and from Ian McDonald's
# 'Bash completion' package (http://www.caliban.org/bash/#completion)
#  You will in fact need bash more recent then 3.0 for some features.
#
#  Note that most linux distributions now provide many completions
# 'out of the box' - however, you might need to make your own one day,
#  so I kept those here as examples.
#=========================================================================

if [ "${BASH_VERSION%.*}" \< "3.0" ]; then
	echo "You will need to upgrade to version 3.0 for full \
	programmable completion features"
	return
fi

shopt -s extglob # Necessary.

complete -A hostname rsh rcp telnet rlogin ftp ping disk
complete -A export printenv
complete -A variable export local readonly unset
complete -A enabled builtin
complete -A alias alias unalias
complete -A function function
complete -A user su mail finger

complete -A helptopic help # Currently same as builtins.
complete -A shopt shopt
complete -A stopped -P '%' bg
complete -A job -P '%' fg jobs disown

complete -A directory mkdir rmdir
complete -A directory -o default cd

# Compression
complete -f -o default -X '*.+(zip|ZIP)' zip
complete -f -o default -X '!*.+(zip|ZIP)' unzip
complete -f -o default -X '*.+(z|Z)' compress
complete -f -o default -X '!*.+(z|Z)' uncompress
complete -f -o default -X '*.+(gz|GZ)' gzip
complete -f -o default -X '!*.+(gz|GZ)' gunzip
complete -f -o default -X '*.+(bz2|BZ2)' bzip2
complete -f -o default -X '!*.+(bz2|BZ2)' bunzip2
complete -f -o default -X '!*.+(zip|ZIP|z|Z|gz|GZ|bz2|BZ2)' extract

# Documents - Postscript,pdf,dvi.....
complete -f -o default -X '!*.+(ps|PS)' gs ghostview ps2pdf ps2ascii
complete -f -o default -X \
	'!*.+(dvi|DVI)' dvips dvipdf xdvi dviselect dvitype
complete -f -o default -X '!*.+(pdf|PDF)' acroread pdf2ps
complete -f -o default -X '!*.@(@(?(e)ps|?(E)PS|pdf|PDF)?\
(.gz|.GZ|.bz2|.BZ2|.Z))' gv ggv
complete -f -o default -X '!*.texi*' makeinfo texi2dvi texi2html texi2pdf
complete -f -o default -X '!*.tex' tex latex slitex
complete -f -o default -X '!*.lyx' lyx
complete -f -o default -X '!*.+(htm*|HTM*)' lynx html2ps
complete -f -o default -X \
	'!*.+(doc|DOC|xls|XLS|ppt|PPT|sx?|SX?|csv|CSV|od?|OD?|ott|OTT)' soffice

# Multimedia
complete -f -o default -X \
	'!*.+(gif|GIF|jp*g|JP*G|bmp|BMP|xpm|XPM|png|PNG)' xv gimp ee gqview
complete -f -o default -X '!*.+(mp3|MP3)' mpg123 mpg321
complete -f -o default -X '!*.+(ogg|OGG)' ogg123
complete -f -o default -X \
	'!*.@(mp[23]|MP[23]|ogg|OGG|wav|WAV|pls|\
m3u|xm|mod|s[3t]m|it|mtm|ult|flac)' xmms
complete -f -o default -X '!*.@(mp?(e)g|MP?(E)G|wma|avi|AVI|\
asf|vob|VOB|bin|dat|vcd|ps|pes|fli|viv|rm|ram|yuv|mov|MOV|qt|\
QT|wmv|mp3|MP3|ogg|OGG|ogm|OGM|mp4|MP4|wav|WAV|asx|ASX)' xine

complete -f -o default -X '!*.pl' perl perl5

#  This is a 'universal' completion function - it works when commands have
#+ a so-called 'long options' mode , ie: 'ls --all' instead of 'ls -a'
#  Needs the '-o' option of grep
#+ (try the commented-out version if not available).

#  First, remove '=' from completion word separators
#+ (this will allow completions like 'ls --color=auto' to work correctly).

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}

_get_longopts() {
	#$1 --help | sed  -e '/--/!d' -e 's/.*--\([^[:space:].,]*\).*/--\1/'| \
	#grep ^"$2" |sort -u ;
	$1 --help | grep -o -e "--[^[:space:].,]*" | grep -e "$2" | sort -u
}

_longopts() {
	local cur
	cur=${COMP_WORDS[COMP_CWORD]}

	case "${cur:-*}" in
	-*) ;;
	*) return ;;
	esac

	case "$1" in
	\~*) eval cmd="$1" ;;
	*) cmd="$1" ;;
	esac
	COMPREPLY=($(_get_longopts ${1} ${cur}))
}
complete -o default -F _longopts configure bash
complete -o default -F _longopts wget id info a2ps ls recode

_tar() {
	local cur ext regex tar untar

	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}

	# If we want an option, return the possible long options.
	case "$cur" in
	-*)
		COMPREPLY=($(_get_longopts $1 $cur))
		return 0
		;;
	esac

	if [ "$COMP_CWORD" -eq 1 ]; then
		COMPREPLY=($(compgen -W 'c t x u r d A' -- $cur))
		return 0
	fi

	case "${COMP_WORDS[1]}" in
	?(-)c*f)
		COMPREPLY=($(compgen -f $cur))
		return 0
		;;
	+([^Izjy])f)
		ext='tar'
		regex=$ext
		;;
	*z*f)
		ext='tar.gz'
		regex='t\(ar\.\)\(gz\|Z\)'
		;;
	*[Ijy]*f)
		ext='t?(ar.)bz?(2)'
		regex='t\(ar\.\)bz2\?'
		;;
	*)
		COMPREPLY=($(compgen -f $cur))
		return 0
		;;

	esac

	if [[ "$COMP_LINE" == tar*.$ext' '* ]]; then
		# Complete on files in tar file.
		#
		# Get name of tar file from command line.
		tar=$(echo "$COMP_LINE" |
			sed -e 's|^.* \([^ ]*'$regex'\) .*$|\1|')
		# Devise how to untar and list it.
		untar=t${COMP_WORDS[1]//[^Izjyf]/}

		COMPREPLY=($(compgen -W "$(echo $(tar $untar $tar \
			2>/dev/null))" -- "$cur"))
		return 0

	else
		# File completion on relevant files.
		COMPREPLY=($(compgen -G $cur\*.$ext))

	fi

	return 0

}

complete -F _tar -o default tar

_make() {
	local mdef makef makef_dir="." makef_inc gcmd cur prev i
	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}
	prev=${COMP_WORDS[COMP_CWORD - 1]}
	case "$prev" in
	-*f)
		COMPREPLY=($(compgen -f $cur))
		return 0
		;;
	esac
	case "$cur" in
	-*)
		COMPREPLY=($(_get_longopts $1 $cur))
		return 0
		;;
	esac

	# ... make reads
	#          GNUmakefile,
	#     then makefile
	#     then Makefile ...
	if [ -f ${makef_dir}/GNUmakefile ]; then
		makef=${makef_dir}/GNUmakefile
	elif [ -f ${makef_dir}/makefile ]; then
		makef=${makef_dir}/makefile
	elif [ -f ${makef_dir}/Makefile ]; then
		makef=${makef_dir}/Makefile
	else
		makef=${makef_dir}/*.mk
		# Local convention.
	fi

	#  Before we scan for targets, see if a Makefile name was
	#+ specified with -f.
	for ((i = 0; i < ${#COMP_WORDS[@]}; i++)); do
		if [[ ${COMP_WORDS[i]} == -f ]]; then
			# eval for tilde expansion
			eval makef=${COMP_WORDS[i + 1]}
			break

		fi
	done
	[ ! -f $makef ] && return 0

	# Deal with included Makefiles.
	makef_inc=$(grep -E '^-?include' $makef |
		sed -e "s,^.* ,"$makef_dir"/,")
	for file in $makef_inc; do
		[ -f $file ] && makef="$makef $file"
	done

	#  If we have a partial word to complete, restrict completions
	#+ to matches of that word.
	if [ -n "$cur" ]; then gcmd='grep "^$cur"'; else gcmd=cat; fi

	COMPREPLY=($(awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ \
	  {split($1,A,/ /);for(i in A)print A[i]}' \
		$makef 2>/dev/null | eval $gcmd))

}

complete -F _make -X '+($*|*.[cho])' make gmake pmake

_killall() {
	local cur prev
	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}

	#  Get a list of processes
	#+ (the first sed evaluation
	#+ takes care of swapped out processes, the second
	#+ takes care of getting the basename of the process).
	COMPREPLY=($(ps -u $USER -o comm |
		sed -e '1,1d' -e 's#[]\[]##g' -e 's#^.*/##' |
		awk '{if ($0 ~ /^'$cur'/) print $0}'))

	return 0
}

complete -F _killall killall killps

loginInfo

#
# $1 command to check
#
bpHasCmd() { ##I Check if command is available
	if [ -x "$(command -v "${1}")" ]; then
		return 0
	else
		return 1
	fi
}

#
# $1 command to execute
#
bpRun() { ##I Execute command
	if bpHasCmd "${1}"; then
		"$@"
		return $?
	else
		bpError "Could not execute $1, command does not exist!"
		return 1
	fi
}

#
# $1 file to open in editor
# $2 override editor (optional)
#
bpEdit() { ##I Open file in editor set by BP_EDIT variable

	if [ -n "$2" ]; then
		bpRun "$2" "$1"
		return 0
	fi

	if [ -n "$BP_EDITOR" ]; then
		bpRun "${BP_EDITOR}" "${1}"
	else
		bpError "BP_EDITOR variable not set, can't open file ${1}"
	fi
}

printCommand() {
	help_line=$1
	help_command=$(echo "$help_line" | sed -s 's/(.*//')
	help_info=$(echo "$help_line" | sed -s 's/^.*'"$2"'//')
	bpPrintInfo "$help_command" "$help_info"
}

printCondCommand() {
	help_line="$1"
	C=$(echo "$1" | sed -s 's/^.*##C//' | awk '{print $1}')
	eval "D=\$$C"
	if [ -n "$D" ]; then
		help_command=$(echo "$help_line" | sed -s 's/(.*//')
		help_info=$(echo "$help_line" | sed -s 's/^.*'"$C"'//')
		bpPrintInfo "$help_command" "$help_info"
	fi
}

printCondCommandV() {
	help_line="$1"
	C=$(echo "$1" | sed -s 's/^.*##CV//' | awk '{print $1}')

	eval "D=\$$C"

	help_command=$(echo "$help_line" | sed -s 's/(.*//')
	help_info=$(echo "$help_line" | sed -s 's/^.*'"$C"'//')

	if [ -n "$D" ]; then
		bpPrintInfo "$help_command" "$help_info"
	else
		bpPrintInfoAlt "$help_command" "$help_info"
	fi
}

printCondLine() {
	help_line="$1"
	C=$(echo "$1" | sed -s 's/^.*##C-//' | awk '{print $1}')
	eval "D=\$$C"
	if [ -n "$D" ]; then
		bpLine
	fi
}

printNamedLine() {
	name=$(echo "$1" | sed -e 's/^.*##N-//' -e 's/^[ \t]*//')
	bpTextLine "$name"
}

help() { ## Print this help information
	echo "$USAGE"
	echo -e "$DESC"
	echo
	IFS=$'\n'
	SC="$1"
	F=~/.bashrc
	help_lines=$(grep -h '##' "${F}" | grep -v -e 'grep' -e '##D' -e '##V' -e '\*##C' -e '\*##C-' -e '\"##' -e '##N-//' -e 'help_line' -e 'printLine')
	for help_line in ${help_lines}; do
		case "$help_line" in
		*"##-"*) bpLine ;;
			#    *"##C-"*)  printCondLine       "$help_line" ;;
			#		*"##N-"*)  printNamedLine      "$help_line" ;;
			#		*"##CN-"*) printCondNamedLine  "$help_line" ;;
			#		*"##CV"*)  printCondCommandV    "$help_line" ;;
			#		*"##C"*)   printCondCommand    "$help_line" ;;
		*"##"*) printCommand "$help_line" '##' ;;
		*) ;;
		esac
	done
}

#---------------------------------------------------------------------
# Initiate internal variables
#---------------------------------------------------------------------

##V Directory where script is located
BPSCRIPTPATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

##V Name of script
#echo $0
#BPSCRIPTNAME=$(basename "$0")

##V Number of arguments given to script
BPARGUMENTS=$#

##V Current date
BPDATE=$(date +"%Y-%m-%d")

##V Current time
BPTIME=$(date +"%H:%M:%S")

##V Number of columns in terminal
BPCOLUMNS=$(tput cols)

##V Number of lines in terminal
BPLINES=$(tput lines)

##V Settings directory
BP_SETTINGS_DIR=~/.config/bashplates

##V Settings file
BP_SETTINGS_FILE=${BP_SETTINGS_DIR}/bashplates.conf

##V System Path's
BP_SETTINGS_PATHS="${BP_SETTINGS_DIR}/path"

##V Links to modules
BP_SETTINGS_MODULES="${BP_SETTINGS_DIR}/modules"

#---------------------------------------------------------------------
# Setup signal traps
#---------------------------------------------------------------------

trap bpExit EXIT

#---------------------------------------------------------------------
# Start
#---------------------------------------------------------------------

# Source global definitions (if any)

if [ -f /etc/bashrc ]; then
	. /etc/bashrc # --> Read /etc/bashrc, if present.
fi

# Initiate bashplate settings
bpInitSettings

# If bashplates settings directory exist load settings/paths/modules
if [ -e "$BP_SETTINGS_DIR" ]; then

	# Load bashplate settings
	if [ -f "$BP_SETTINGS_FILE" ]; then
		source ${BP_SETTINGS_FILE}
	fi

	# Add bashplates PATH's
	if [ -e "$BP_SETTINGS_PATHS" ]; then
		for p in $(find ${BP_SETTINGS_PATHS} -type l); do
			l=$(readlink "${p}")
			if [ -e "${l}" ]; then
				PATH="${PATH}:${l}"
				bpOk "Adding path:  $l"
			else
				bpError "Path  $(bpColorizeFile "$l") does not exist!"
			fi
		done
		export PATH
	fi

	# Run bashplates module scripts
	if [ -e "$BP_SETTINGS_MODULES" ]; then
		for m in $(find ${BP_SETTINGS_MODULES} -type l); do
			l=$(readlink "${m}")
			if [ -e "${l}" ]; then
				source "$l"
				bpOk "Loaded module $(bpColorizeFile "$l")"
			else
				bpError "Failed to load module $(bpColorizeFile "$l")"
			fi
		done
	fi
fi

bpInitDisplay

# Call host specific function if existing
if [ "$(type -t host_"${HOSTNAME}")" == "function" ]; then
	host_"${HOSTNAME}"
fi
