# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
fi
if [ -x ./thor/thor ]; then
  . ./thor/thor 
  alias t='thor'
  alias tl='thor -l'
  alias ta='thor -a'
  alias td='thor -r'
fi

source ~/config/.liuzheng_bashrc
source ~/config/kubectl.bashrc
#Enabling tab-completion
complete -cf sudo

complete -cf man
#export DYLD_FORCE_FLAT_NAMESPACE=1
export F_HOME=/Users/liuzheng/gitproject/kinomajs
export XS_HOME=$F_HOME/xs
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
[ -f ~/.bashrc_docker ] && . ~/.bashrc_docker
export JAVAHOME=/opt/java
export GOLIB=/opt/gopath
export GOPATH=$GOLIB:/Users/i317280/goproject/jumpserver
export GOROOT=/opt/go
PATH="$JAVAHOME/bin/:/usr/local/bin/:/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH=$PATH:$GOLIB/bin:$GOROOT/bin:/opt/gopath/bin/FlameGraph
export M2_HOME=/opt/apache-maven-3.3.9

export NODE_PATH=/usr/local/lib/node_modules 
export PATH=$PATH:$M2_HOME/bin
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export HISTSIZE=
export HISTFILESIZE=

alias gitpushdevelop="git push origin HEAD:refs/for/develop"


if [ -f $(brew --prefix)/etc/bash_completion  ]; then
  . $(brew --prefix)/etc/bash_completion
fi
