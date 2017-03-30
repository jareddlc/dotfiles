# Path
export PATH=/usr/local/bin:$PATH

# Text editor
export TEXT_EDITOR="atom"

# SSH keys
# source ssh-add ~/.ssh/id_rsa

# Git
source ~/.git-completion.bash
source ~/.git-prompt.sh

# Alias
alias ll="ls -la"
alias ls="ls -Gfh"

# Alias atom
alias atomlist="apm list --installed --bare"

# Alias directories
alias dev="cd ~/Development"
alias temp="cd $(echo $TMPDIR)"

# Alias git
alias gs="git status"
alias gd="git diff"
alias gm="git checkout master"

# Alias profile
alias bash_profile="$TEXT_EDITOR ~/.bash_profile"
alias reload_profile="source ~/.bash_profile"

# Alias system
alias hosts="$TEXT_EDITOR /etc/hosts"
alias flush_dns="sudo killall -HUP mDNSResponder"

# Alias tmux
alias mux="tmux kill-server; tmux; tmux source ~/.tmux.conf"

# Functions
set_text_editor () {
  export TEXT_EDITOR="$1"
}

#Prompt and prompt colors

# Foreground
# 30m - Black
# 31m - Red
# 32m - Green
# 33m - Yellow
# 34m - Blue
# 35m - Purple
# 36m - Cyan
# 37m - White
# 39m - Default

# Background
# 40m - Black
# 41m - Red
# 42m - Green
# 43m - Yellow
# 44m - Blue
# 45m - Purple
# 46m - Cyan
# 47m - White
# 49m - Default

# Font
# 0 - Normal
# 1 - Bold

# \u - user
# \h - hostname short
# \w - directory

# Example: "\[\e[0;32;40m\]\h" Normal;Green foreground; Black background

# FlatUI
_reset="\[\e[0m\]"
_username="\[\e[0;31m\]\u"
_at="\[\e[0;35m\]@"
_hostname="\[\e[0;32m\]\h"
_colon="\[\e[0;35m\]:"
_directory="\[\e[0;33m\]\w"
_git_branch='\[\e[0;34m\]$(__git_ps1 "(%s)")'
_git_branch_list='\[\e[0;34m\]$(__git_ps1_branch_list)'
_git_stash_list='\[\e[0;34m\]$(__git_ps1_stash_list)'
_git_title='$(__git_ps1_json)'
_bang="\[\e[0m\]\$ "

export PS1="$_username$_at$_hostname$_colon$_directory $_git_branch$_bang$_git_title"

# Monokai
# export PS1='\[\e[00;37m\]\u\[\e[0m\]\[\e[00;31m\]@\[\e[0m\]\[\e[00;34m\]\h\[\e[0m\]\[\e[00;31m\]:\[\e[0m\]\[\e[00;32m\]\w\[\e[0m\]\[\e[00;33m\]$(__git_ps1 " (%s)")\[\e[0m\]\$ '

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
