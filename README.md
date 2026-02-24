# Dotfiles

This documentation contains everything related to the setup & management of these dotfiles, now with [`chezmoi`](https://www.chezmoi.io/).

## Install new machine

Setup SSH keys.

Install `zsh` & `chezmoi` and then, pull this repo with:

```sh
chezmoi init git@github.com:MaoDeMatos/dotfiles.git
```

## Manual steps

> [!NOTE]
> WIP. Need to script this with `chezmoi`.

```sh
# git clone https://github.com/Skylor-Tang/auto-venv.git ~/.oh-my-zsh/custom/plugins/auto-venv # Deprecated for `uv`
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
```

### (optional)

- [`starship`](https://starship.rs/install.sh)
