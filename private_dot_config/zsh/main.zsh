# Bun
export BUN_INSTALL="/home/mao/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# Bun completions
[ -s "/home/mao/.bun/_bun" ] && source "/home/mao/.bun/_bun"

# if type rg &> /dev/null; then
#   export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!**/.git"'
#   export FZF_DEFAULT_OPTS='-m --reverse'
# fi

# Show system info
if [[ $- == *i* ]]; then
  fastfetch
fi

# custom aliases
alias sf='fastfetch'
