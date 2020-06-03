#!/bin/sh

touch ~/.zshrc

if cat ~/.zshrc | grep "source ~/environment/zshrc.sh" --quiet; then
  echo 'Already installed in ~/.zshrc'
else
  printf "\nsource ~/environment/zshrc.sh\n" >> ~/.zshrc
  echo 'Added line to ~/.zshrc'
fi
