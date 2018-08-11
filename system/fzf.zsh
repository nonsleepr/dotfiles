export FZF_DEFAULT_COMMAND='ag -g ""'
SHELL_DIR=$(dirname $(readlink -f $(which fzf)))/../shell
source $SHELL_DIR/completion.zsh
source $SHELL_DIR/key-bindings.zsh
