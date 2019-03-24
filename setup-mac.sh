#!/bin/sh

touch ~/.bash_profile

if cat ~/.bash_profile | grep "source ~/environment/profile.sh" --quiet; then
  echo 'Already installed in ~/.bash_profile'
else
  printf "\nsource ~/environment/profile.sh\n" >> ~/.bash_profile
  echo 'Added line to ~/.bash_profile'
fi
