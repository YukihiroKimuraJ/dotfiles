# dotfiles

Personal macOS configuration, managed as symlinks.

## What's here

| Path | Symlinked to | What it is |
|------|--------------|------------|
| `home/.zshrc` | `~/.zshrc` | zsh interactive config (PATH, starship init) |
| `home/.zprofile` | `~/.zprofile` | login shell (Homebrew shellenv) |
| `home/.zshenv` | `~/.zshenv` | always-sourced env (Volta) |
| `home/.profile` | `~/.profile` | POSIX shell env (Volta) |
| `home/.gitconfig` | `~/.gitconfig` | git identity + LFS filters |
| `config/starship.toml` | `~/.config/starship.toml` | [Starship](https://starship.rs) prompt |
| `config/karabiner/karabiner.json` | `~/.config/karabiner/karabiner.json` | [Karabiner-Elements](https://karabiner-elements.pqrs.org) key remaps |

## Install on a new machine

```sh
git clone https://github.com/YukihiroKimuraJ/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh            # add --dry-run first to preview
```

`install.sh` is idempotent: re-running it is safe, and any existing real file is
backed up to `<file>.backup-<timestamp>` before being replaced with a symlink.

## Editing

The files in this repo are the originals; `~/.zshrc` etc. are symlinks pointing
here. So edit the files in `~/dotfiles`, then commit and push:

```sh
cd ~/dotfiles
git add -A && git commit -m "tweak prompt" && git push
```

## Related

- **Neovim config** lives in its own repo: https://github.com/YukihiroKimuraJ/nvim-config

## Not included (by design)

Secrets and machine state are intentionally excluded: `~/.ssh`, `~/.aws`,
`~/.config/gh`, `~/.config/github-copilot`, shell history, caches.
