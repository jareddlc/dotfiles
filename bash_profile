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
alias gb="git branch"
alias gd="git diff"
alias gl="git log  --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs="git status"
alias gcm="git checkout master"
alias gcb="git checkout -b"
alias gfu="git fetch upstream"
alias gpum="git pull upstream master"

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
F_BLACK='\[\e[0;30m\]'
F_RED='\[\e[0;31m\]'
F_GREEN='\[\e[0;32m\]'
F_YELLOW='\[\e[0;33m\]'
F_BLUE='\[\e[0;34m\]'
F_PURPLE='\[\e[0;35m\]'
F_CYAN='\[\e[0;36m\]'
F_WHITE='\[\e[0;37m\]'
F_DEFAULT='\[\e[0;39m\]'

# Background
B_BLACK='\[\e[0;40m\]'
B_RED='\[\e[0;41m\]'
B_GREEN='\[\e[0;42m\]'
B_YELLOW='\[\e[0;43m\]'
B_BLUE='\[\e[0;44m\]'
B_YELLOW='\[\e[0;45m\]'
B_CYAN='\[\e[0;46m\]'
B_WHITE='\[\e[0;47m\]'
B_DEFAULT='\[\e[0;49m\]'

# Reset
F_RESET="\[\e[0m\]"

# Text attributes
# 0 - All attributes off
# 1 - Bold
# 4 - Underscore (on monochrome display adapter only)
# 5 - Blink on
# 7 - Reverse video on
# 8 - Concealed on

# \u - user
# \h - hostname short
# \w - directory

# Example: "\[\e[0;32;40m\]\h" Normal;Green foreground; Black background

# FlatUI
_username="$F_RED\u"
_at="$F_YELLOW@"
_hostname="$F_GREEN\h"
_colon="$F_PURPLE:"
_directory="$F_YELLOW\w"
_git_branch='\[\e[0;34m\]$(__git_ps1 "(%s)")'
_git_branch_list='\[\e[0;34m\]$(__git_ps1_branch_list)'
_git_stash_list='\[\e[0;34m\]$(__git_ps1_stash_list)'
_bang="$F_RESET\$ "

export PS1="$_username$_at$_hostname$_colon$_directory $_git_branch$_bang"

# Save current PROMPT_COMMAND
if [[ ${PROMPT_COMMAND} != *"__git_ps1_json"* ]]; then
  _PROMPT_COMMAND=$PROMPT_COMMAND
fi
# Runs after command is entered
PROMPT_COMMAND="__git_ps1_json; $_PROMPT_COMMAND"

# Monokai
# export PS1='\[\e[00;37m\]\u\[\e[0m\]\[\e[00;31m\]@\[\e[0m\]\[\e[00;34m\]\h\[\e[0m\]\[\e[00;31m\]:\[\e[0m\]\[\e[00;32m\]\w\[\e[0m\]\[\e[00;33m\]$(__git_ps1 " (%s)")\[\e[0m\]\$ '

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
