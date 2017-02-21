# terminal-themes
Themes for terminal

move .git scripts to folder and source them in ~/.bash_profile:

```
cp .git-completion.bash ~/
cp .git-prompt.sh ~/
cp .tmux.conf ~/

cp bash_profile ~/
```

tmux

```
brew install tmux
```

Docker GUI

```
# install hombrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install socat

socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
docker run -it -e DISPLAY=<IP>:0 --name spotify jess/spotify
```

atom.io

```
apm install activate-power-mode \
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
```
