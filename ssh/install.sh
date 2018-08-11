#! /usr/bin/env bash
set -e

if [ -f $HOME/.ssh/config ]; then
  echo "$HOME/.ssh/config already exists. Exiting."
  #exit 1
fi

echo "Include config.d/*" > $HOME/.ssh/config
mkdir -p $HOME/.ssh/config.d
