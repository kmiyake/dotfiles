#!/bin/sh

for FILE in '.vimrc' '.zshrc' '.tmux.conf'
do
  if [ -f $HOME/$FILE ]; then
    echo "$HOME/$FILE already exists. Skipping."
  else
    echo "Linking $HOME/$FILE"
    ln -s $PWD/$FILE $HOME/$FILE
  fi
done

NVIM_DIR="$HOME/.config/nvim"

if [ -d $NVIM_DIR ]; then
  echo "$NVIM_DIR already exists. Skipping."
else
  echo "Creating $NVIM_DIR"
  mkdir -p $NVIM_DIR
fi

if [ -f $NVIM_DIR/init.vim ]; then
  echo "$NVIM_DIR/init.vim already exists. Skipping."
else
  echo "Linking $NVIM_DIR/init.vim"
  ln -s $PWD/.config/nvim/init.vim $NVIM_DIR/init.vim
fi
