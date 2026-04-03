#!/bin/bash
set -e

PACK_DIR="$HOME/.config/nvim/pack/plugins/start"
mkdir -p "$PACK_DIR"

clone() {
  local repo=$1
  local name
  name=$(basename "$repo")
  if [ ! -d "$PACK_DIR/$name" ]; then
    echo "Installing $name..."
    git clone --depth=1 "https://github.com/$repo" "$PACK_DIR/$name"
  else
    echo "$name already installed, skipping"
  fi
}

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
