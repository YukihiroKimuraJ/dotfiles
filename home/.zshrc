export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"
eval "$(mise activate zsh)"

if [[ "$TERM" == "xterm-ghostty" ]]; then
  export TERM=xterm-256color
fi

# Modern Unix tools
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first'
alias tree='eza --tree --icons'

alias cat='bat'
alias find='fd'
alias grep='rg'
alias du='dust'
alias top='btop'
alias diff='delta'

# granted: 'assume' must be sourced so it can export AWS_* into the current shell
alias assume="source assume"


# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C
# <<< grok installer <<<

# zoxide has to be initialised last. It installs its own completions, so
# anything that runs compinit afterwards — the grok block above does — makes
# `zoxide doctor` warn on every single shell start.
eval "$(zoxide init zsh)"
alias cd='z'
