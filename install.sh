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

# DAP (debugger)
clone "mfussenegger/nvim-dap"
clone "igorlfs/nvim-dap-view"
clone "leoluz/nvim-dap-go"

# PHP debug adapter (Xdebug) — baixa o .vsix do GitHub e extrai
PHP_DAP_DIR="$HOME/.local/share/nvim/dap/php-debug"
install_php_dap() {
  echo "Installing php-debug-adapter..."
  local vsix
  vsix=$(curl -s https://api.github.com/repos/xdebug/vscode-php-debug/releases/latest \
    | grep '"browser_download_url"' | grep '\.vsix' | cut -d'"' -f4)
  mkdir -p "$PHP_DAP_DIR"
  curl -L "$vsix" -o /tmp/php-debug.vsix
  unzip -o /tmp/php-debug.vsix -d "$PHP_DAP_DIR" > /dev/null
  rm /tmp/php-debug.vsix
  echo "php-debug-adapter installed"
}

if [ ! -f "$PHP_DAP_DIR/extension/out/phpDebug.js" ]; then
  install_php_dap
else
  if $UPDATE; then
    install_php_dap
  else
    echo "php-debug-adapter already installed, skipping"
  fi
fi

# Neotest + adapters
clone "nvim-neotest/nvim-nio"
clone "nvim-neotest/neotest"
clone "nvim-neotest/neotest-go"
clone "nvim-neotest/neotest-plenary"
clone "nvim-neotest/neotest-jest"
clone "marilari88/neotest-vitest"
clone "olimorris/neotest-phpunit"
clone "V13Axel/neotest-pest"

echo ""
echo "Plugins instalados em $PACK_DIR"
echo "Abra o nvim e rode :helptags ALL"
