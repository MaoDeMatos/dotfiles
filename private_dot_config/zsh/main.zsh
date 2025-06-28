# When installing nvim with pre-built archives
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# Golang
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# Rust
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"
[ -s "$HOME/.local/bin/env" ] && \. "$HOME/.local/bin/env"

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Pyton
# uv & uvx completions
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# Bun
export BUN_INSTALL="/home/mao/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# Bun completions
[ -s "/home/mao/.bun/_bun" ] && source "/home/mao/.bun/_bun"

# if type rg &> /dev/null; then
#   export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!**/.git"'
#   export FZF_DEFAULT_OPTS='-m --reverse'
# fi

# Chezmoi completion
source ~/.config/zsh/chezmoi-cmp.zsh

# custom aliases
alias cdp='cd ~/projects'
