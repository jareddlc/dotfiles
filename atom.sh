#!/bin/bash

if [ "$1" = "list" ]; then
  atom_list
elif [ "$1" = "install" ]; then
  atom_install
fi

atom_list() {
  apm list --installed --bare
}

atom_install() {
  apm install activate-power-mode \
    highlight-line \
    highlight-selected \
    linter \
    linter-eslint \
    linter-jshint \
    minimap \
    minimap-bookmarks \
    minimap-cursorline \
    minimap-find-and-replace \
    minimap-git-diff \
    minimap-highlight-selected \
    minimap-linter \
    minimap-selection \
    seti-icons
}
