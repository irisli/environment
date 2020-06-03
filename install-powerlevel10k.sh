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
