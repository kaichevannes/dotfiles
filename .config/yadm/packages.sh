#!/bin/bash

# Install homebrow if it isn't already installed.
if ! command -v brew >/dev/null 2>&1; then
  # Requirements when on linux
  if command -v apt >/dev/null 2>&1; then
    sudo apt update && sudo apt install build-essential procps curl file git
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy base-devel procps-ng curl file git
  elif command -v yum >/dev/null 2>&1; then
    sudo yum groupinstall 'Development Tools'
    sudo yum update && sudo yum install procps-ng curl file git
  fi
  
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  export PATH="/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin:$PATH"
  eval "$(brew shellenv)"
fi

# Install packages
if command -v brew >/dev/null 2>&1; then
  brew update
  # Basics
  brew install gcc fzf xclip
  # Neovim
  brew install neovim ripgrep tree-sitter node npm luarocks
  # LSPs
  brew install lua-language-server shellcheck bash-language-server llvm gopls \
      vscode-langservers-extracted python-lsp-server typescript-language-server \
      marksman yaml-language-server
  # Extras
  brew install yazi dos2unix
fi

# Node specific packages
if ! npm list -g --depth=0 | grep "@styled/typescript-styled-plugin"; then
npm install -g @styled/typescript-styled-plugin
fi

# Install rust
if ! command -v cargo >/dev/null 2>&1; then
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  source "$HOME/.cargo/env"
fi

# Install cargo packages
if ! command -v taplo >/dev/null 2>&1; then
  cargo install --features lsp --locked taplo-cli
fi
