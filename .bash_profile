# Path
export PATH=/usr/local/bin:$PATH

# Text editor
export TEXT_EDITOR="atom"

# SSH keys
# source ssh-add ~/.ssh/id_rsa

# Git
source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh

# Gut
source $HOME/gut.sh

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
alias reload_profile="source $HOME/.bash_profile"

# Alias system
alias hosts="$TEXT_EDITOR /etc/hosts"
alias flush_dns="sudo killall -HUP mDNSResponder"
alias get_ip="ipconfig getifaddr en0"

# Alias tmux
alias mux="tmux kill-server; tmux; tmux source ~/.tmux.conf"

# Functions
set_text_editor () {
  export TEXT_EDITOR="$1"
}

# Prompt and colors
_username="$_GUT_PS1_F_RED\u"
_at="$_GUT_PS1_F_YELLOW@"
_hostname="$_GUT_PS1_F_GREEN\h"
_colon="$_GUT_PS1_F_PURPLE:"
_directory="$_GUT_PS1_F_YELLOW\w"
_git_branch="$_GUT_PS1_F_BLUE"'$(__git_ps1 "(%s)")'
_git_status_short="$_GUT_PS1_F_PURPLE"'$(_gut_status_short)'
_bang="$_GUT_PS1_RESET\$ "

export PS1="$_username$_at$_hostname$_colon$_directory $_git_branch$_git_status_short$_bang"

# Save current PROMPT_COMMAND
if [[ ${PROMPT_COMMAND} != *"_gut_title_json"* ]]; then
  _PROMPT_COMMAND=$PROMPT_COMMAND
fi
# Runs after command is entered
PROMPT_COMMAND="_gut_title_json; $_PROMPT_COMMAND"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
