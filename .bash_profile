# Path
export PATH=/usr/local/bin:$PATH

# Alias
alias ll="ls -la"
alias ls="ls -Gfh"

# Alias directories
alias dev="cd $HOME/Development"
alias temp="cd $(echo $TMPDIR)"

# Alias Git
alias gd="git diff"
alias gl="git log  --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs="git status"

# Alias profile
alias bash_profile="$TEXT_EDITOR $HOME/.bash_profile"

# Alias system
alias hosts="$TEXT_EDITOR /etc/hosts"

# Git
source $HOME/.git-completion.sh
source $HOME/.git-prompt.sh

# Text editor
export TEXT_EDITOR="code"

# Prompt and colors
# Foreground
PS1_F_BLACK='\[\e[0;30m\]'
PS1_F_RED='\[\e[0;31m\]'
PS1_F_GREEN='\[\e[0;32m\]'
PS1_F_YELLOW='\[\e[0;33m\]'
PS1_F_BLUE='\[\e[0;34m\]'
PS1_F_PURPLE='\[\e[0;35m\]'
PS1_F_CYAN='\[\e[0;36m\]'
PS1_F_WHITE='\[\e[0;37m\]'
PS1_F_DEFAULT='\[\e[0;39m\]'

# Background
PS1_B_BLACK='\[\e[0;40m\]'
PS1_B_RED='\[\e[0;41m\]'
PS1_B_GREEN='\[\e[0;42m\]'
PS1_B_YELLOW='\[\e[0;43m\]'
PS1_B_BLUE='\[\e[0;44m\]'
PS1_B_PURPLE='\[\e[0;45m\]'
PS1_B_CYAN='\[\e[0;46m\]'
PS1_B_WHITE='\[\e[0;47m\]'
PS1_B_DEFAULT='\[\e[0;49m\]'

PS1_RESET='\[\e[0m\]'

_username="$PS1_F_RED\u"
_at="$PS1_F_YELLOW@"
_hostname="$PS1_F_GREEN\h"
_colon="$PS1_F_PURPLE:"
_directory="$PS1_F_YELLOW\w"
_git_branch="$PS1_F_BLUE"'$(__git_ps1 "(%s)")'
_git_status_short="$PS1_F_PURPLE"'$(_git_status)'
_bang="$PS1_RESET\$ "

export PS1="$_username$_at$_hostname$_colon$_directory $_git_branch$_git_status_short$_bang"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

_git_status () {
  local changes=$(git status 2>/dev/null)
  local staged="Changes to be committed"
  local unstaged="Changes not staged for commit"
  local untracked="Untracked files"

  # Check if output string contains keywords
  if [[ ${changes} == *${staged}* ]]; then
    echo -n "^"
  fi

  if [[ ${changes} == *${unstaged}* ]]; then
    echo -n "*"
  fi

  if [[ ${changes} == *${untracked}* ]]; then
    echo -n "+"
  fi
}
