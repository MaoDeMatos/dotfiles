if type chezmoi &> /dev/null; then
  eval "$(chezmoi completion zsh)"
fi

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden \
    -g "!**/.git" \
    -g "!**/node_modules/**" \
    -g "!**/venv/**" \
    -g "!**/.venv/**" \'
  export FZF_DEFAULT_OPTS='-m --reverse'
fi

# bun
export BUN_INSTALL="$HOME/.bun"
if [ -d "$BUN_INSTALL" ]; then
  export PATH="$BUN_INSTALL/bin:$PATH"
  # completions
  [ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
fi

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --corepack-enabled --use-on-cd --shell zsh)"
  eval "$(fnm completions --shell zsh)"
fi

##
##
##

alias cls='clear'

##
##
##

# Load local configs/overrides
local_config_path="$HOME/.config/zsh/local.zsh"
[[ -f $local_config_path ]] && source $local_config_path

