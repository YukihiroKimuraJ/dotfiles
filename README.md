# dotfiles

Personal macOS configuration, managed as symlinks.

## What's here

| Path | Symlinked to | What it is |
|------|--------------|------------|
| `home/.zshrc` | `~/.zshrc` | zsh interactive config (PATH, starship init) |
| `home/.zprofile` | `~/.zprofile` | login shell (Homebrew shellenv) |
| `home/.zshenv` | `~/.zshenv` | always-sourced env (Volta) |
| `home/.profile` | `~/.profile` | POSIX shell env (Volta) |
| `home/.gitconfig` | `~/.gitconfig` | default noreply identity + email guard |
| `home/.gitconfig-oss` | `~/.gitconfig-oss` | real identity for repositories under `~/oss/` |
| `home/.git-hooks/pre-push` | global hook | blocks private email addresses before push |
| `home/.npmrc` | `~/.npmrc` | npm/pnpm registry (Takumi Guard) + 7-day release cooldown |
| `config/starship.toml` | `~/.config/starship.toml` | [Starship](https://starship.rs) prompt |
| `config/gitleaks/gitleaks.toml` | `~/.config/gitleaks/gitleaks.toml` | [gitleaks](https://github.com/gitleaks/gitleaks) rules used by the global pre-commit hook |
| `config/karabiner/karabiner.json` | `~/.config/karabiner/karabiner.json` | [Karabiner-Elements](https://karabiner-elements.pqrs.org) key remaps |
| `macos/Library/Preferences/pnpm/config.yaml` | `~/Library/Preferences/pnpm/config.yaml` | pnpm's 7-day release cooldown (`minimumReleaseAge`) |

Three layouts map to three destinations:

| Directory | Destination | Use for |
|-----------|-------------|---------|
| `home/` | `~/<file>` | dotfiles directly in the home directory |
| `config/` | `~/.config/<path>` | tools that read `~/.config` |
| `macos/` | `~/<path>` | macOS-only paths that fit neither, e.g. `~/Library/Preferences` |

`macos/` exists because some tools ignore `~/.config` on macOS unless
`XDG_CONFIG_HOME` is set. pnpm is one: its global config lives in
`~/Library/Preferences/pnpm/config.yaml`, not the `~/.config/pnpm/config.yaml`
the documentation shows. Confirm a tool's real path with its own CLI
(`pnpm config get globalconfig`) before adding it here.

## Install on a new machine

```sh
git clone https://github.com/YukihiroKimuraJ/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh            # add --dry-run first to preview
```

`install.sh` is idempotent: re-running it is safe, and any existing real file is
backed up to `<file>.backup-<timestamp>` before being replaced with a symlink.

The private address blocked by the Git hook is deliberately kept outside this
public repository. Configure it once per machine:

```sh
cp ~/dotfiles/examples/gitconfig-private ~/.gitconfig-private
chmod 600 ~/.gitconfig-private
$EDITOR ~/.gitconfig-private  # replace the placeholder email
```

Normal repositories use the GitHub noreply identity. Repositories cloned under
`~/oss/` use the reachable address in `~/.gitconfig-oss`. Check the effective
identity before committing with `git whoami`.

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
`~/.gitconfig-private`, `~/.config/gh`, `~/.config/github-copilot`, shell
history, caches.
