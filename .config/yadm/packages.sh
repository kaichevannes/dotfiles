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
if command -v brew >/dev/null; then
  brew update
  # Basics
  brew install gcc fzf xclip
  # Neovim
  brew install neovim ripgrep tree-sitter node npm luarocks
  # LSPs
  brew install lua-language-server shellcheck bash-language-server
  # Extras
  brew install yazi dos2unix
fi
