## Setup
### Basic Flow
1. Install wezterm
2. Make sure zsh is the default shell
3. Install yadm
4. yadm clone

**Note: As of March 2025, wezterm nightly is required for yazi to work. This is because it uses a more recent version of ConPTY which handles how terminal inputs are passed to the shell.**

### Windows
```
(Elevated Powershell) $ winget install wez.wezterm 
(Elevated Powershell) $ wsl.exe --install
         (WSL Ubuntu) $ cd ~
         (WSL Ubuntu) $ sudo apt update && sudo apt install -y zsh yadm 
         (WSL Ubuntu) $ chsh -s $(which zsh)
         (WSL Ubuntu) $ yadm clone https://github.com/kaichevannes/dotfiles.git
```
## Adding LSPs
1. Find an [LSP Implementation](https://microsoft.github.io/language-server-protocol/implementors/servers/) for the language
2. Find a default config from [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md)
3. Add the default config to .config/nvim/lsp (remember filename)
4. Add the config (remembered filename) to enabled lsps in the config in .config/nvim/lua/config/lsp.lua

## Keybindings
### LSP
- `i_<C-x><C-o>` `conte`**x**`tual` **o**`ptions`
- `i_<C-S>     ` **s**`ignature` `help`
- `<C-]>       ` `go-to-definition`
- `grn         ` **g**`lobal` **r**`e`**n**`ame`
- `gra         ` **g**`lobal` **r**`ecommended` **a**`ctions`
- `grr         ` **g**`lobal` **r**`efe`**r**`ences`
- `gri         ` **g**`lobal` **r**`eveal` **i**`mplementations`
- `gO          ` **g**`lobal` **O**`utline`
