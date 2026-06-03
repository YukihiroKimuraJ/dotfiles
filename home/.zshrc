export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"

if [[ "$TERM" == "xterm-ghostty" ]]; then
  export TERM=xterm-256color
fi
