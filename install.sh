#!/bin/bash
GRE="\033[0;32m"
YEL="\033[0;33m"
DEF="\033[0;39m"
RES="\033[0m"

GIT_COMPLETION=".git-completion.bash"
GIT_PROMPT=".git-prompt.sh"
TMUX=".tmux.conf"
BASH_PROFILE=".bash_profile"

install() {
  local fileName=$1

  if [ ! -e "$HOME/$fileName" ]; then
    echo -e "${GRE}Installing: ${YEL}${fileName}${DEF}"
    cp "${fileName}" "${HOME}/${fileName}"
  else
    echo -e "${GRE}File found: ${YEL}${HOME}/${fileName}${DEF}"
    echo -e "${YEL}Not overriding${DEF}"
  fi
}

install "${GIT_COMPLETION}"
install "${GIT_PROMPT}"
install "${TMUX}"
install "${BASH_PROFILE}"
