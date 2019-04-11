#!/bin/sh

# If not interactive then do nothing
[ -z "$PS1" ] && return

#echo '[ running ~/.bashrc ]'
source /etc/bashrc
source /opt/local/etc/bash_completion
if [ -r ~/.fzf.bash ]; then
	source ~/.fzf.bash
fi

source /opt/local/share/git/git-prompt.sh
#javadir=/System/Library/Frameworks/JavaVM.framework/Libraries

export EDITOR=vi
export SCVIM_DIR=/usr/local/share/scvim
export HSVIM_DIR=/usr/local/share/hsvim

# ---------------- Interactive bash setup --------------------

# fix annoying xterm stty modes
stty ixany imaxbel

# prompts
if [ $VIM ]; then
	PS1='\[\e[1m\][\t \u@\h:\w VIM]\[\e[0m\] '
elif [ $PROLOGCHILD ]; then
	PS1='\[\e[1m\][\t \u@\h:\w SWI]\[\e[0m\] '
else
	# PS1='\[\e[1m\][\t \u@\h:\w]\[\e[0m\] '
	PS1='\[\e[1m\][\t \u@\h:\w$(__git_ps1)]\[\e[0m\] '
	# PS1='\[\e[1m\]\t \u@\h:\w$(__git_ps1) \$\[\e[0m\] '
fi
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

# tolerate spelling mistakes in cd
shopt -s cdspell
# append to history file
shopt -s histappend
export HISTIGNORE="?:ls:bg:fg" # forget all one letter commands
export HISTSIZE=10000

# ls colours
#export CLICOLOR=1
#export LS_COLORS='di=4:'
#export LS_COLORS='no=00:fi=00:di=00;33:ln=04:ex=32:*.sh=32:*.tar=31:*.tgz=31:*.gz=31:*.sit=31:*.jpg=36:*.jpeg=36:*.gif=36:*.psd=36:*.html=35:*.htm=35:*.css=35:'
export LSCOLORS='ExGxfxdxCxDxDxabagebeb'

# many aliases
alias tree="tree -C"
alias cd..="cd .."
#alias ls="gls --color"
alias l="ls -l"
alias la="ls -a"
alias ltr="ls -ltr"
alias less="less -R"
alias du='du -k'
alias df='df -h'
alias top='top -o cpu'
alias mv='mv -i'
alias rm='rm -i'
alias suspend='kill -SIGSTOP'
alias resume='kill -SIGCONT'
alias hexdump="hexdump -C"
alias vi="vim"
alias gv="gv --spartan"
#alias xdvia0l="xdvi -s 36 -paper 1188mmx840mm"
#alias xdvia0p="xdvi -s 42 -paper 840mmx1188mm"
alias matlab="matlab -nosplash -nodesktop -noawt"
alias mpdi='mplayer -framedrop -cache 2000 -vf pp=fd'
alias sftp='rlwrap -c -r sftp'
alias xdiff='open /Developer/Applications/FileMerge.app'
alias telmpc='rlwrap telmpc'
alias fluid='(cd ~/Library/Audio/Sounds/Banks && fluidsynth -a coreaudio -m coremidi -p fluidsynth -f ~/.fluidrc)'
alias killx11='kill $(cat ~/var/run/xinit.pid)'
alias curl-rdf='curl -H "Accept: application/rdf+xml"'
alias a2ps='a2ps -o -'
alias vims='vim -c "$(cat .local.vimrc)"'

alias suspend-btsync='suspend `pidof "Resilio Sync"`'
alias resume-btsync='resume `pidof "Resilio Sync"`'

## Haskell setup
haskell=~/lib/haskell
hlibs=$haskell/algebra:$haskell/util:$haskell/haschorus:$haskell/haskore
alias hugs='hugs +ot -E"vim +%d %s" -98 -P:$hlibs'
alias ghci='ghci -i$hlibs'
alias ocaml='rlwrap -s 5000 -H .ocaml_history ocaml'
alias batteries='rlwrap -s 5000 -H .ocaml_history ocamlfind batteries/ocaml'
alias yap='rlwrap -s 10000 -H .yap_history yap'

alias bbc='MPD_PORT=6601'
alias m5='MPD_HOST=m5'
alias mother='MPD_HOST=mother'
alias xfader='crossfade 6600 6602' # crossfade left to right
alias xfadel='crossfade 6602 6600' # crossfade right to left
alias nbc=~/src/Robotics/nxt/nbc -I=~/src/Robotics/nxt

alias irc4dm='irssi -c irc.freenode.net'
alias eject='diskutil eject'
alias loc8='mdfind -name'
alias oni='OPEN_NI_INSTALL_PATH=/opt/OpenNI DYLD_FALLBACK_LIBRARY_PATH=$OPEN_NI_INSTALL_PATH/usr/lib'

# Dot file viewer
function dv {
	dot -Tps $1 | gv -
}

# Dot file viewer
function nv {
	neato -Tps $1 | gv -
}

alias glinks='google elinks'
alias ggui='google open'

function trash {
	mv "$@" ~/.Trash
}

function inipath {
	echo "Initialising paths for $1."
	echo source "init_$1.sh"
	source "init_$1.sh"
}

alias gtk-current="GTK2_RC_FILES=~/.colorschemes/current/gtkrc2"

if [ $TERM = 'screen.xterm-256color' ]; then
	echo "Changing TERM from screen.xterm-256color to screen-256color"
	export TERM='screen-256color'
fi
