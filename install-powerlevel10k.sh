#!/bin/zsh
P10K_DIR="${HOME}/.powerlevel10k"
if [[ ! -d "${P10K_DIR}" && ! -L "${P10K_DIR}" ]] ; then
    echo "Yay! Installing powerlevel 10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $P10K_DIR
    echo "source ${P10K_DIR}/powerlevel10k.zsh-theme" >>! ~/.zshrc
else
    echo "Powerlevel 10k already installed"
    echo "If it is not loading, please run  echo source ${P10K_DIR}/powerlevel10k.zsh-theme >>! ~/.zshrc"
fi
cp ~/environment/.p10k.zsh ~/.p10k.zsh
touch ~/.zshrc
if cat ~/.zshrc | grep "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" --quiet; then
  echo '.p10k.zsh already installed in ~/.zshrc'
else
  printf "\n[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh\n" >> ~/.zshrc
  echo 'Added line to ~/.zshrc'
fi
