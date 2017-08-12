_GUT_SELECTION_HIGHLIGHT='\033[0;31m'
_GUT_SELECTION_RESET='\033[0m'

# Add gut tab completion
_gut_completion() {
  local cur prev commands

  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  commands="fetch pull push reset"

  COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )

  return 0
}
complete -F _gut_completion gut

_gut_help() {
  echo "usage: gut [command]"
  echo ""
  echo "commands:"
  echo ""
  echo "fetch         prompts for git remote, git branch, and performs git fetch"
  echo "pull          prompts for git remote, git branch, and performs git pull"
  echo "push          prompts for git remote, git branch, and performs git push"
  echo "reset         prompts for git hash, and performs git reset --soft"
  echo ""
}

# Gut main function
gut() {
  if [ "$1" = "-h" ]; then
    _gut_help
  elif [ "$1" = "fetch" ]; then
    _gut_fetch
  elif [ "$1" = "pull" ]; then
    _gut_pull
  elif [ "$1" = "push" ]; then
    _gut_push
  elif [ "$1" = "reset" ]; then
    _gut_reset
  else
    echo "Invalid command"
    _gut_help
  fi
}

# Gut functions
_gut_fetch() {
  # Save IFS
  local SAVEIFS=$IFS
  # Change IFS to new line.
  IFS=$'\n'

  # Get git remotes (push)
  local _git_remotes_names=($(__gut_remotes_names))
  local _git_remotes_urls=($(__gut_remotes_urls))
  local _git_remotes=($(__gut_remotes))

  # Get remote
  echo "Select a remote:"
  __gut_select _git_remotes[@]
  local indexRemote=$?

  # Git fetch
  local _git_branch_names=($(git fetch ${_git_remotes_names[$indexRemote]} -v 2>&1 | grep "=" | awk '{ print $5; }')) # awk '{ print $7; }' for name/branch

  # Get branch
  echo "Select a branch:"
  __gut_select _git_branch_names[@]
  local indexBranch=$?

  # Run git command
  git fetch "${_git_remotes_names[$indexRemote]}" "${_git_branch_names[$indexBranch]}"

  # Restore IFS
  IFS=$SAVEIFS
}

_gut_pull() {
  # Save IFS
  local SAVEIFS=$IFS
  # Change IFS to new line.
  IFS=$'\n'

  # Get git remotes (push)
  local _git_remotes_names=($(__gut_remotes_names))
  local _git_remotes_urls=($(__gut_remotes_urls))
  local _git_remotes=($(__gut_remotes))

  # Get remote
  echo "Select a remote:"
  __gut_select _git_remotes[@]
  local indexRemote=$?

  # Get git branch
  local _git_branch_names=($(__gut_branch_names))

  # Get branch
  echo "Select a branch:"
  __gut_select _git_branch_names[@]
  local indexBranch=$?

  # Run git command
  git pull "${_git_remotes_names[$indexRemote]}" "${_git_branch_names[$indexBranch]}"

  # Restore IFS
  IFS=$SAVEIFS
}

_gut_push() {
  # Save IFS
  local SAVEIFS=$IFS
  # Change IFS to new line.
  IFS=$'\n'

  # Get git remotes (push)
  local _git_remotes_names=($(__gut_remotes_names))
  local _git_remotes_urls=($(__gut_remotes_urls))
  local _git_remotes=($(__gut_remotes))

  # Get remote
  echo "Select a remote:"
  __gut_select _git_remotes[@]
  local indexRemote=$?

  # Get git branch
  local _git_branch_names=($(__gut_branch_names))

  # Get branch
  echo "Select a branch:"
  __gut_select _git_branch_names[@]
  local indexBranch=$?

  # Run git command
  git push "${_git_remotes_names[$indexRemote]}" "${_git_branch_names[$indexBranch]}"

  local exitPush=$?

  if [ "$exitPush" != "0" ]; then
    echo "Push failed, force push?"

    local _force=(No Yes)

    __gut_select _force[@]
    local indexForce=$?

    if [ "$indexForce" = "1" ]; then
      git push "${_git_remotes_names[$indexRemote]}" "${_git_branch_names[$indexBranch]}" --force
    fi
  fi

  # Restore IFS
  IFS=$SAVEIFS
}

_gut_reset() {
  # Save IFS
  local SAVEIFS=$IFS
  # Change IFS to new line.
  IFS=$'\n'

  # Git format placeholders
  # %h: abbreviated commit hash
  # %s: subject
  # %cd: committer date
  # %an: author name

  # Get git commits
  local _git_commits_names=($(__gut_log_names))
  local _git_commits_hashes=($(__gut_log_hashes))

  # Get commit
  echo "Select a commit:"
  __gut_select _git_commits_names[@]
  local indexCommit=$?

  # Run git command
  git reset --soft ${_git_commits_hashes[$indexCommit]}
}

# Gut helper functions
__gut_branch_names() {
  local _git_branch_names=$(git branch | awk '{ $1=$1; print }' | tr -d "* ")
  echo "$_git_branch_names"
}

__gut_branch_remote() {
  if [ -z "$1" ]; then
    echo "invalid parameter passed: __gut_branch_remote"
    return -1
  fi

  local _git_braches_all=$(git branch -a | grep "$1" | tr -d "* " | awk -F / '{ print $3; }')
  echo "$_git_braches_all"

  # local _git_branchs=$(__gut_branch_remote ${_git_remotes_names[$indexRemote]})
  # echo "$_git_branchs"
}

__gut_log_names() {
  local _git_commits_names=$(git log -n 25 --pretty=format:'%h - %s (%cd) <%an>')
  echo "$_git_commits_names"
}

__gut_log_hashes() {
  local _git_commits_hashes=$(git log -n 25 --pretty=format:'%h')
  echo "$_git_commits_hashes"
}

__gut_remotes_names() {
  local _git_remotes_names=($(git remote -v | grep push | awk '{ print $1; }'))
  echo "$_git_remotes_names"
}

__gut_remotes_urls() {
  local _git_remotes_urls=($(git remote -v | grep push | awk '{ print $2; }'))
  echo "$_git_remotes_urls"
}

__gut_remotes() {
  local _git_remotes=($(git remote -v | grep push | awk '{ print $1,  "(" $2 ")" }'))
  echo "$_git_remotes"
}

# Gut selection functions
__gut_echo() {
  # Get arguments
  declare -a array=("${!1}")

  # Iterate over array
  for k in "${!array[@]}"; do
    if [ "$2" -eq "$k" ]; then
      # Clear line
      #echo -en "\033[K"
      # Print
      echo -en "$_GUT_SELECTION_HIGHLIGHT${array[$k]} \n \r"
    else
      # Clear line
      #echo -en "\033[K"
      # Print
      echo -en "$_GUT_SELECTION_RESET${array[$k]} \n \r"
    fi
  done

  # Clear formatting
  echo -en "$_GUT_SELECTION_RESET"
}

__gut_clear() {
  # Get arguments
  declare -a array=("${!1}")

  # Iterate over array
  for k in "${!array[@]}"; do
    # Clear line
    #echo -en "\033[K"
    # Move cursor up
    echo -en "\033[1A"
  done
}

__gut_select() {
  # Get arguments
  declare -a array=("${!1}")
  # echo ${array[@]} # List array contents
  # echo "${#array[@]}" # List size of array

  # Set mix/max
  let i=0;
  let min=0;
  let max="${#array[@]} - 1"

  # Turn cursor off
  echo -en "\033[?25l"

  while true
  do
    # User input logic
    if [ "$input" = "A" ]; then
      if [ "$i" -gt "$min" ]; then
        (( i -= 1 ))
      fi
    fi
    if [ "$input" = "B" ]; then
      if [ "$i" -lt "$max" ]; then
        (( i += 1 ))
      fi
    fi

    # Echo list
    __gut_echo array[@] $i

    # Read input
    read -r -sn1 input

    # Read selection (This is after the read to prevent early termination)
    if [ "$input" = "" ]; then
      _GUT_SELECTION_INDEX=$i
      _GUT_SELECTION_TEXT="${array[$i]}"

      break
    fi

    # Reset cursor
    __gut_clear array[@]
  done

  # Turn cursor on
  echo -en "\033[?25h"

  return $i
}

# Gut KV
__gut_save() {
  local filePath=$1
  local key=$2
  local value=$3

  # Check for provided file path
  if [ "$filePath" = "" ]; then
    echo "No save file path provided"
    return 1;
  fi

  if [ "$key" = "" ]; then
    echo "No key provided"
    return 1;
  fi

  if [ "$value" = "" ]; then
    echo "No value provided"
    return 1;
  fi

  # Encode key and value
  local encodedKey=$(echo "$key" | base64)
  local encodedValue=$(echo "$value" | base64)
  local store="$encodedKey:$encodedValue"

  # Check if file exists
  local action=">"
  if [ ! -e "$filePath" ]; then
    # File does not exist, store
    echo ${store} >> ${filePath}
    return 0
  fi

  # Check if key exists
  local found=$(grep "$encodedKey:" "$filePath")
  local foundLine=$(awk "/"$encodedKey:"/{ print NR; exit }" "$filePath")
  if [ "$found" ]; then
    # Update current key
    local awkC="{ if (NR == "$foundLine") print \""$store"\"; else print \$0}"
    awk "$awkC" "$filePath" > "$filePath".swap
    cat "$filePath".swap > "$filePath"
    rm "$filePath".swap
  else
    # Key does not exist, append
    echo ${store} >> ${filePath}
  fi
}

__gut_get() {
  local filePath=$1
  local key=$2

  # Check for provided file path
  if [ "$filePath" = "" ]; then
    echo "No save file path provided"
    return 1;
  fi

  if [ "$key" = "" ]; then
    echo "No key provided"
    return 1;
  fi

  # Check if file exists
  local action=">"
  if [ ! -e "$filePath" ]; then
    # File does not exist, store
    echo "File does not exist"
    return 1
  fi
  # Encode key
  local encodedKey=$(echo "$key" | base64)

  # Check if key exists
  local found=$(grep "$encodedKey:" "$filePath")
  local foundLine=$(awk "/"$encodedKey:"/{ print \$0; exit }" "$filePath")
  if [ "$found" ]; then
    # Get key and decode it
    local encodedValue=$(echo "$foundLine" | awk -F':' "{ print \$2 }")
    local value=$(echo "$encodedValue" | base64 -D)
    echo $value
  fi
}

# Gut PS1
__gut_ps1_branch_list() {
	local output="$(git branch --list 2>/dev/null | wc -l | sed 's/^ *//')"

	if [ -z "$output" ]; then
		return $exit
	fi

	if [ "$output" = "0" ]; then
		return $exit
	fi

	echo "$output"
}

__gut_ps1_stash_list() {
	local output="$(git stash list 2>/dev/null | wc -l | sed 's/^ *//')"

	if [ -z "$output" ]; then
		return $exit
	fi

	echo "$output"
}

__gut_ps1_changes() {
  local changes=$(git status 2>/dev/null)
  local staged="Changes to be committed"
  local unstaged="Changes not staged for commit"
  local untracked="Untracked files"

  if [[ $changes == *$staged* ]]; then
    echo -n "^"
  fi

  if [[ $changes == *$unstaged* ]]; then
    echo -n "*"
  fi

  if [[ $changes == *$untracked* ]]; then
    echo -n "+"
  fi
}

__gut_ps1_json() {
	local current_branch=$(__git_ps1 "(%s)" | tr -d "(" | tr -d ")")
	local branch_list=$(__git_ps1_branch_list)
	local stash_list=$(__git_ps1_stash_list)

	if [ -z "$current_branch" ]; then
		echo -n -e "\033]0;\007"
		return
	fi

	local text="{current: $current_branch, branches: $branch_list, stash: $stash_list}"
	echo -n -e "\033]0;$text\007"
}
