# Text editor
export TEXT_EDITOR="code"

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
alias zprofile="$TEXT_EDITOR $HOME/.zprofile"

# Alias system
alias hosts="$TEXT_EDITOR /etc/hosts"
