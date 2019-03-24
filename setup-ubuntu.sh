#!/bin/sh

touch ~/.bashrc

if cat ~/.bashrc | grep "source ~/environment/profile.sh" --quiet; then
  echo 'Already installed in ~/.bashrc'
else
  printf "\nsource ~/environment/profile.sh\n" >> ~/.bashrc
  echo 'Added line to ~/.bashrc'
fi
