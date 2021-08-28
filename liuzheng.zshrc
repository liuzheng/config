#===================path=======================
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH:/opt/gopath/bin/"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH=$PATH:/Users/liuzheng/workarea/bin
export CDPATH=.:~:$HOME/gitproject
export TEXINPUTS=.:/Users/liuzheng/Documents/LaTeX/liuzheng/:
export TTFONTS=$TEXINPUTS
export OPENTYPEFONTS=$TEXINPUTS

#===================alias=======================
# ls
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -Al'
#alias ls='ls -FHG'
alias lx='ls -lXB'
alias lk='ls -lSr'
alias lc='ls -lcr'
alias lu='ls -lur'
alias lr='ls -lR'
alias lt='ls -ltr'
alias lm='ls -al |more'
alias dit="docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t"

# hand wrong
alias vf='cd'
alias xs='cd'
alias ks='ls'
alias kk='ll'
alias moew='more'

# df
alias dfh='df -h'

# make
alias mk="make"
alias mki="make install"

# clc
alias clc="clear"
alias lcl="clear"

# cd
alias c="cd"
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias cd....="cd ../../../.."

# git
alias gitc='git clone'
alias gpom='git push origin master'
alias gitp='git pull'
alias gita='git add'
alias gitaa='git add -u'
alias gitA='git add -A'
alias gitm='git commit'
alias gitM='git commit -m'
alias gits='git status'

# grep
alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'
alias vime='/opt/vim/bin/vim'

#===================function=======================
x(){
  ls *.tex|xargs xelatex
}
# find text in the file
function ffi()
{
grep -D skip -nRe "$1" .
}
function ff() { find . -type f -iname '*'$*'*' -ls ; }

#===================nvm=======================
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
#===================autojump=======================
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

#===================kubectl=======================
source <(kubectl completion zsh)
