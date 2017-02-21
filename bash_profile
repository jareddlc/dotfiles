# Path
export PATH=/usr/local/bin:$PATH

# SSH keys
#source ssh-add ~/.ssh/id_rsa

# Git
source ~/.git-completion.bash
source ~/.git-prompt.sh

# Alias
alias ll="ls -la"
alias ls="ls -Gfh"
alias bashprofile="atom ~/.bash_profile"
alias hosts="atom /etc/hosts"
alias mux="tmux kill-server; tmux; tmux source ~/.tmux.conf"

#Prompt and prompt colors
# 30m - Black
# 31m - Red
# 32m - Green
# 33m - Yellow
# 34m - Blue
# 35m - Purple
# 36m - Cyan
# 37m - White
# 0 - Normal
# 1 - Bold

# FlatUI
export PS1='\[\e[00;31m\]\u\[\e[0m\]\[\e[00;35m\]@\[\e[0m\]\[\e[00;32m\]\h\[\e[0m\]\[\e[00;35m\]:\[\e[0m\]\[\e[00;33m\]\w\[\e[0m\]\[\e[00;34m\]$(__git_ps1 " (%s)")\[\e[0m\]\$ '

# Monokai
# export PS1='\[\e[00;37m\]\u\[\e[0m\]\[\e[00;31m\]@\[\e[0m\]\[\e[00;34m\]\h\[\e[0m\]\[\e[00;31m\]:\[\e[0m\]\[\e[00;32m\]\w\[\e[0m\]\[\e[00;33m\]$(__git_ps1 " (%s)")\[\e[0m\]\$ '

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
