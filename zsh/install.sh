if [ -f /usr/local/bin/zsh ]; then
  sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
else
  echo "Homebrew ZSH wasn't installed defaulting to MacOS ZSH"
  sudo dscl . -create /Users/$USER UserShell /bin/zsh
fi
