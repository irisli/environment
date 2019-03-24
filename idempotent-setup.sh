
touch ~/.tmux
if cat ~/.tmux | grep "set-window-option -g aggressive-resize on" --quiet; then
  echo 'Tmux aggressive-resize already installed in ~/.tmux'
else
  printf "\nset-window-option -g aggressive-resize on\n" >> ~/.tmux
  echo 'Added tmux aggressive-resize in ~/.tmux'
fi
