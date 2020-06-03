#!/usr/bin/env bash

case "$(uname -s)" in

Darwin)
  echo 'Mac OS X'
  if [ -n "$ZSH_VERSION" ]; then
    # assume Zsh
    sudo chmod -R 755 /usr/local/share/zsh/site-functions
    sudo chmod -R 755 /usr/local/share/zsh
    ./install-powerlevel10k.sh
    cp ~/environment/.p10k.zsh ~/.p10k.zsh
  elif [ -n "$BASH_VERSION" ]; then
    # assume Bash
    ./setup-zsh.sh
    echo "Please start zsh and run terraform again using the command: source terraform.sh"
  fi

  if [ -n "$($SHELL -c 'echo $ZSH_VERSION')" ]; then
    # assume Zsh
    sudo chmod -R 755 /usr/local/share/zsh/site-functions
    sudo chmod -R 755 /usr/local/share/zsh
    ./install-powerlevel10k.sh

  elif [ -n "$($SHELL -c 'echo $BASH_VERSION')" ]; then
    # assume Bash
    echo "Bash!"
  else
    # assume something else
    echo "Unable to detect shell"
  fi
  ;;
Linux)
  echo 'Linux'
  sudo apt remove landscape-client landscape-common
  sudo touch /etc/motd
  # sudo chmod -x /etc/update-motd.d/10-help-text || :
  # sudo chmod -x /etc/update-motd.d/51-cloudguest || :
  if [ -n "$ZSH_VERSION" ]; then
    # assume Zsh
    ./install-powerlevel10k.sh
    cp ~/environment/.p10k.zsh ~/.p10k.zsh
    sed -i 's/    # public_ip             # public IP address/    public_ip             # public IP address/g' ~/.p10k.zsh

    # Change color to ubuntu orangered with white foreground
    sed -i 's/  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=232/  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=7/g' ~/.p10k.zsh
    sed -i 's/  typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=7/  typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=202/g' ~/.p10k.zsh
  elif [ -n "$BASH_VERSION" ]; then
    # assume Bash

    sudo apt update
    sudo apt install zsh
    # Change your shell to zsh
    sudo vi /etc/passwd

    ./setup-zsh.sh
    zsh ./terraform.sh
    echo "Please start zsh and run terraform again using the command: source terraform.sh"
  fi
  ;;
CYGWIN* | MINGW32* | MSYS* | MINGW*)
  echo 'MS Windows'
  ;;

# Add here more strings to compare
# See correspondence table at the bottom of this answer

*)
  echo 'Other OS'
  ;;
esac
