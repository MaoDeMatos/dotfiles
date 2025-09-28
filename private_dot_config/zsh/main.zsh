for file in $HOME/.config/zsh/autoload/*.zsh; do
  source "$file"
done

# if type rg &> /dev/null; then
#   export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!**/.git"'
#   export FZF_DEFAULT_OPTS='-m --reverse'
# fi

