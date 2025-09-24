# Dotfiles

This documentation contains everything related to the setup & management of these dotfiles, now with [`chezmoi`](https://www.chezmoi.io/).

## Install new machine

Setup SSH keys.

Install:

- `chezmoi` (dotfiles management)
- `zsh starship`

Run

```sh
chezmoi init git@github.com:MaoDeMatos/dotfiles.git
```

## Manual steps

> [!NOTE]
> WIP. Need to script this with `chezmoi`.

```sh
git clone https://github.com/Skylor-Tang/auto-venv.git ~/.oh-my-zsh/custom/plugins/auto-venv
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
```
