# Prompt (Debian)
#source /usr/local/bin/git-completion.sh

# Prompt (OS X + homebrew)
#source /usr/local/etc/bash_completion.d/git-completion.bash

# Next 2 files can be downloaded from git repo:
# https://github.com/git/git/tree/master/contrib/completion

# Set git autocompletion
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
    . /usr/local/git/contrib/completion/git-completion.bash
fi

# and PS1 integration
if [ -f /usr/local/git/contrib/completion/git-prompt.sh ]; then
    . /usr/local/git/contrib/completion/git-prompt.sh
fi

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

#default ps1
#export PS1="\u@\h:\[\e[1;32m\]\w\[\033[1;31m\]\$(__git_ps1)\[\033[00m\] $ "

#custom ps1
export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[1;31m\]\$(__git_ps1)\[\033[00m\] $ "

alias d='git diff --word-diff $@'
alias s='git status -sb'
alias b='git branch -avv'
alias c='git commit -v $@'
alias co='git checkout'
alias a='git add $@'
alias ai='git add -i'
alias ac='git add .;c $@'
alias lg='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias lgb='lg --all --simplify-by-decoration'
alias po='git pull origin $@'

#git colors
git config --global color.ui auto
git config --global color.branch auto
git config --global color.diff auto
git config --global color.interactive auto
git config --global color.status auto

#git merge conflictstyle
git config --global merge.conflictstyle diff3

__define_git_completion () {
eval "
    _git_$2_shortcut () {
        COMP_LINE=\"git $2\${COMP_LINE#$1}\"
        let COMP_POINT+=$((4+${#2}-${#1}))
        COMP_WORDS=(git $2 \"\${COMP_WORDS[@]:1}\")
        let COMP_CWORD+=1

        local cur words cword prev
        _get_comp_words_by_ref -n =: cur words cword prev
        _git_$2
    }
"
}

__git_shortcut () {
    type _git_$2_shortcut &>/dev/null || __define_git_completion $1 $2
    alias $1="git $2 $3"
    complete -o default -o nospace -F _git_$2_shortcut $1
}

__git_shortcut  a    add
__git_shortcut  b    branch
__git_shortcut  ba   branch -a
__git_shortcut  co   checkout
__git_shortcut  c   commit -v
__git_shortcut  d    diff

#custom aliases
alias ll='ls -alhG'
alias ls='ls -G'
alias test='node_modules/ngServer/bin/ngServer.js test'

#custom dirs added to PATH
PATH=${PATH}:"~/bin"
export PATH
