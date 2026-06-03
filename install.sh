#!/usr/bin/env bash
#
# install.sh — symlink dotfiles into place.
#
# Safe to run repeatedly. If a target already exists and is NOT already the
# correct symlink, it is backed up to <file>.backup-<timestamp> before linking.
#
# Usage:
#   ./install.sh           # create the symlinks
#   ./install.sh --dry-run # print what would happen, change nothing

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=1

link() {
  local src="$1" dest="$2"

  # Already linked correctly? Nothing to do.
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo "ok   $dest -> $src"
    return
  fi

  if (( DRY_RUN )); then
    echo "PLAN link $dest -> $src"
    return
  fi

  mkdir -p "$(dirname "$dest")"

  # Back up an existing real file or wrong symlink.
  if [[ -e "$dest" || -L "$dest" ]]; then
    mv "$dest" "${dest}.backup-${TIMESTAMP}"
    echo "back ${dest} -> ${dest}.backup-${TIMESTAMP}"
  fi

  ln -s "$src" "$dest"
  echo "link $dest -> $src"
}

# Home dotfiles: home/<file> -> ~/<file>
for f in "$DOTFILES_DIR"/home/.*; do
  name="$(basename "$f")"
  [[ "$name" == "." || "$name" == ".." ]] && continue
  link "$f" "$HOME/$name"
done

# ~/.config files: config/<path> -> ~/.config/<path>
while IFS= read -r -d '' f; do
  rel="${f#"$DOTFILES_DIR"/config/}"
  link "$f" "$HOME/.config/$rel"
done < <(find "$DOTFILES_DIR/config" -type f -print0)

echo
echo "Done. Open a new shell (or 'source ~/.zshrc') to pick up changes."
