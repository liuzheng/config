#===================zsh========================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM=$CONFIG_PATH/oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git docker docker-compose zsh-completions zsh-autosuggestions zsh-syntax-highlighting)
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source $CONFIG_PATH/oh-my-zsh/.p10k.zsh
source $ZSH/oh-my-zsh.sh
#===================path=======================
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH:/opt/gopath/bin/"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH=$PATH:$HOME/workarea/bin
export CDPATH=.:~:$HOME/gitproject

#===================LaTeX=======================
export PATH=$PATH:/Library/TeX/texbin
export TEXINPUTS=.:$CONFIG_PATH/LaTeX/LaTeX-template/:
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
#[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

#===================kubectl=======================
source <(kubectl completion zsh)

