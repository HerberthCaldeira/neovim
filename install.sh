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
  local branch=${2:-}
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
    if [ -n "$branch" ]; then
      git clone --depth=1 --branch "$branch" "https://github.com/$repo" "$dest"
    else
      git clone --depth=1 "https://github.com/$repo" "$dest"
    fi
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
clone "ThePrimeagen/harpoon" "harpoon2"
clone "kdheepak/lazygit.nvim"
clone "lewis6991/gitsigns.nvim"
clone "nvim-lualine/lualine.nvim"
clone "nvim-tree/nvim-web-devicons"
clone "MeanderingProgrammer/render-markdown.nvim"
clone "abidibo/nvim-httpyac"

echo ""
echo "Plugins instalados em $PACK_DIR"
echo "Abra o nvim e rode :helptags ALL"
