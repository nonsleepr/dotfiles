if hash brew 2>/dev/null; then
  SHELL_DIR=$(brew --prefix)/opt/fzf/shell
  source $SHELL_DIR/completion.zsh
  source $SHELL_DIR/key-bindings.zsh
elif [ -d "/usr/share/doc/fzf/examples/" ]; then
  source /usr/share/doc/fzf/examples/completion.zsh
  source /usr/share/doc/fzf/examples/key-bindings.zsh
else
  FZF_DIR=$(dirname $(command -v fzf))/../share/fzf
  source $FZF_DIR/completion.zsh
  source $FZF_DIR/key-bindings.zsh
fi
