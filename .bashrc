export BASH_SILENCE_DEPRECATION_WARNING=1
# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything


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

#source ~/config/.liuzheng_bashrc
#source ~/config/kubectl.bashrc
#Enabling tab-completion
complete -cf sudo

complete -cf man
#export DYLD_FORCE_FLAT_NAMESPACE=1
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
export GOLIB=/opt/gopath
export GOPATH=$GOLIB
export PYTHON_HOME=/Users/liuzheng/Library/Python/3.7
PATH="/usr/bin:$PYTHON_HOME/bin/:$PATH:/Users/liuzheng/workarea/bin"
PATH="$JAVAHOME/bin/:/usr/local/bin/:/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH=$PATH:$GOLIB/bin:/usr/local/go/bin/:/opt/gopath/bin/FlameGraph
#export M2_HOME=/opt/apache-maven

#export NODE_PATH=/usr/local/lib/node_modules 
#export PATH=$PATH:$M2_HOME/bin:/usr/local/texlive/2020/bin/x86_64-darwin
#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export HISTSIZE=
export HISTFILESIZE=

#alias gitpushdevelop="git push origin HEAD:refs/for/develop"


#if [ -f $(brew --prefix)/etc/bash_completion  ]; then
#  . $(brew --prefix)/etc/bash_completion
#fi



###-begin-ng-completion###
#

# ng command completion script
#   This command supports 3 cases.
#   1. (Default case) It prints a common completion initialisation for both Bash and Zsh.
#      It is the result of either calling "ng completion" or "ng completion -a".
#   2. Produce Bash-only completion: "ng completion -b" or "ng completion --bash".
#   3. Produce Zsh-only completion: "ng completion -z" or "ng completion --zsh".
#
# Usage: . <(ng completion --bash) # place it appropriately in .bashrc or
#        . <(ng completion --zsh) # find a spot for it in .zshrc
#
_ng_completion() {
  local cword pword opts

  COMPREPLY=()
  cword=${COMP_WORDS[COMP_CWORD]}
  pword=${COMP_WORDS[COMP_CWORD - 1]}

  case ${pword} in
    ng|help) opts="--version -v b build completion doc e e2e eject g generate get help l lint n new s serve server set t test v version xi18n" ;;
    b|build) opts="--aot --app --base-href --build-optimizer --common-chunk --delete-output-path --deploy-url --environment --extract-css --extract-licenses --i18n-file --i18n-format --locale --named-chunks --output-hashing --output-path --poll --preserve-symlinks --progress --show-circular-dependencies --sourcemaps --stats-json --target --vendor-chunk --verbose --watch -a -aot -bh -buildOptimizer -cc -d -dop -e -ec -extractLicenses -i18nFile -i18nFormat -locale -nc -oh -op -poll -pr -preserveSymlinks -scd -sm -statsJson -t -v -vc -w" ;;
    completion) opts="--all --bash --zsh -a -b -z" ;;
    doc) opts="--search -s" ;;
    e|e2e) opts="--aot --app --base-href --build-optimizer --common-chunk --config --delete-output-path --deploy-url --disable-host-check --element-explorer --environment --extract-css --extract-licenses --hmr --host --i18n-file --i18n-format --live-reload --locale --named-chunks --open --output-hashing --output-path --poll --port --preserve-symlinks --progress --proxy-config --public-host --serve --show-circular-dependencies --sourcemaps --specs --ssl --ssl-cert --ssl-key --target --vendor-chunk --verbose --watch --webdriver-update -H -a -aot -bh -buildOptimizer -c -cc -d -disableHostCheck -dop -e -ec -ee -extractLicenses -hmr -i18nFile -i18nFormat -live-reload-client -locale -lr -nc -o -oh -op -p -pc -poll -pr -preserveSymlinks -s -scd -sm -sp -ssl -sslCert -sslKey -t -v -vc -w -wu" ;;
    eject) opts="--aot --app --base-href --build-optimizer --common-chunk --delete-output-path --deploy-url --environment --extract-css --extract-licenses --force --i18n-file --i18n-format --locale --named-chunks --output-hashing --output-path --poll --preserve-symlinks --progress --show-circular-dependencies --sourcemaps --target --vendor-chunk --verbose --watch -a -aot -bh -buildOptimizer -cc -d -dop -e -ec -extractLicenses -force -i18nFile -i18nFormat -locale -nc -oh -op -poll -pr -preserveSymlinks -scd -sm -t -v -vc -w" ;;
    g|generate) opts="--dry-run --lint-fix --verbose -d -lf -v" ;;
    get) opts="--global -global" ;;
    l|lint) opts="--fix --force --format --type-check -fix -force -t -typeCheck" ;;
    n|new) opts="--directory --dry-run --inline-style --inline-template --link-cli --minimal --prefix --routing --skip-commit --skip-git --skip-install --skip-tests --source-dir --style --verbose -d -dir -is -it -lc -minimal -p -routing -sc -sd -sg -si -st -style -v" ;;
    s|serve|server) opts="--aot --app --base-href --build-optimizer --common-chunk --delete-output-path --deploy-url --disable-host-check --environment --extract-css --extract-licenses --hmr --host --i18n-file --i18n-format --live-reload --locale --named-chunks --open --output-hashing --output-path --poll --port --preserve-symlinks --progress --proxy-config --public-host --show-circular-dependencies --sourcemaps --ssl --ssl-cert --ssl-key --target --vendor-chunk --verbose --watch -H -a -aot -bh -buildOptimizer -cc -d -disableHostCheck -dop -e -ec -extractLicenses -hmr -i18nFile -i18nFormat -live-reload-client -locale -lr -nc -o -oh -op -p -pc -poll -pr -preserveSymlinks -scd -sm -ssl -sslCert -sslKey -t -v -vc -w" ;;
    set) opts="--global -g" ;;
    t|test) opts="--app --browsers --code-coverage --colors --config --environment --log-level --poll --port --progress --reporters --single-run --sourcemaps --watch -a -browsers -c -cc -colors -e -logLevel -poll -port -progress -reporters -sm -sr -w" ;;
    --version|-v|v|version) opts="--verbose -verbose" ;;
    xi18n) opts="--app --i18n-format --locale --out-file --output-path --progress --verbose -a -f -l -of -op -progress -verbose" ;;
    *) opts="" ;;
  esac

  COMPREPLY=( $(compgen -W '${opts}' -- $cword) )

  return 0
}

complete -o default -F _ng_completion ng
###-end-ng-completion###

export PATH="$HOME/.cargo/bin:$PATH"
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

#export LDFLAGS="-L/usr/local/opt/openssl/lib"
#export CPPFLAGS="-I/usr/local/opt/openssl/include"
#export PATH="/usr/local/opt/openssl/bin:$PATH"

#export PATH="/Applications/Electron.app/Contents/MacOS/:$PATH"
#export ELECTRON_MIRROR="https://npm.taobao.org/mirrors/electron/"
#export PATH="/usr/local/Cellar/node/13.2.0/bin/:$PATH"
#export PATH="/usr/local/opt/python@3.8/bin:$PATH"
#export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles
#export PATH="/usr/local/opt/ssh-copy-id/bin:$PATH"
#export GOROOT=/opt/go

export TEXINPUTS=.:/Users/liuzheng/Documents/LaTeX/liuzheng:
export TTFONTS=$TEXINPUTS
export OPENTYPEFONTS=$TEXINPUTS
