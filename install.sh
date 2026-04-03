#!/bin/bash
set -e

PACK_DIR="$HOME/.config/nvim/pack/plugins/start"
UPDATE=false

for arg in "$@"; do
  case $arg in
    --update) UPDATE=true ;;
  esac
done

mkdir -p "$PACK_DIR"

clone() {
  local repo=$1
  local name
  name=$(basename "$repo")
  local dest="$PACK_DIR/$name"

  if [ -d "$dest" ]; then
    if $UPDATE; then
      echo "Updating $name..."
      git -C "$dest" pull --ff-only
    else
      echo "$name already installed, skipping"
    fi
  else
    echo "Installing $name..."
    git clone --depth=1 "https://github.com/$repo" "$dest"
  fi
}

clone "folke/tokyonight.nvim"
clone "nvim-treesitter/nvim-treesitter"
clone "hrsh7th/nvim-cmp"
clone "hrsh7th/cmp-nvim-lsp"
clone "hrsh7th/cmp-buffer"
clone "hrsh7th/cmp-path"
clone "L3MON4D3/LuaSnip"
clone "saadparwaiz1/cmp_luasnip"
clone "nvim-lua/plenary.nvim"
clone "nvim-telescope/telescope.nvim"
clone "folke/which-key.nvim"

echo ""
echo "Plugins instalados em $PACK_DIR"
echo "Abra o nvim e rode :helptags ALL"
