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

function colour {
	local colour=${1}
	local code=""

	case $1 in
		"none" )		code="0";;
		"black" )		code="0;30";;
		"blackbold" )	code="1;30";;
		"red" )			code="0;31";;
		"redbold" )		code="1;31";;
		"green" )		code="0;32";;
		"greenbold" )	code="1;32";;
		"yellow" )		code="0;33";;
		"yellowbold" )	code="1;33";;
		"purple" )		code="0;34";;
		"purplebold" )	code="1;34";;
		"magenta" )		code="0;35";;
		"magentabold" )	code="1;35";;
		"cyan" )		code="0;36";;
		"cyanbold" )	code="1;36";;
		"white" )		code="0;37";;
		"whitebold" )	code="1;37";;
		*)
		echo "colour ${1} not found!"
		exit 1
		;;
	esac
	echo "\[\033[${code}m\]"
}

export PS1="┌$(colour "purple")[\d \t] $(colour "greenbold")\u@\h$(colour "white"):$(colour "purplebold")\w$(colour "redbold")\$(__git_ps1)\n$(colour "white")└─›"

alias d='git diff --word-diff $@'
alias s='git status -sb'
alias b='git branch -avv'
alias c='git commit -v $@'
alias co='git checkout'
alias a='git add $@'
alias ai='git add -i'
alias ac='git add .;c $@'
alias si='git stash --keep-index; git stash drop; git stash'

alias lg='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias lga='lg --all'
alias lgb='lg --all --simplify-by-decoration'

alias pr='git pull --rebase'
alias fa='git fetch --all'

alias rs='git reset --hard HEAD'
alias cl='git clean -f'
alias rscl='git reset --hard HEAD && git clean -f'

#git colors
git config --global color.ui auto
git config --global color.branch auto
git config --global color.diff auto
git config --global color.interactive auto
git config --global color.status auto

#USING SUBLIME TEXT FOR REBASE INTERACTIVE
#git config --global sequence.editor "sublime -n -w"

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

#refresh shell
alias reload='source ~/.bash_profile'

#custom dirs added to PATH
PATH=${PATH}:"~/bin"
export PATH
