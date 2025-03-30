## Setup
### Basic Flow
1. Install wezterm
2. Make sure zsh is the default shell
3. Install yadm
4. yadm clone
- (Think about how to do auto DankMono font)

**Note: As of March 2025, wezterm nightly is required for yazi to work on WSL. This is because the Windows version uses a more recent version of ConPTY which handles how terminal inputs are passed to the shell.**

### Windows
```
(Elevated Powershell) $ winget install wez.wezterm 
(Elevated Powershell) $ wsl.exe --install
         (WSL Ubuntu) $ cd ~
         (WSL Ubuntu) $ sudo apt update && sudo apt install -y zsh yadm 
         (WSL Ubuntu) $ chsh -s $(which zsh)
         (WSL Ubuntu) $ yadm clone https://github.com/kaichevannes/dotfiles.git
```
## Pushing new config
Remember to track new config files.
```
yadm add ~/.config/*
yadm push
```

## Adding LSPs
1. Find an [LSP Implementation](https://microsoft.github.io/language-server-protocol/implementors/servers/) for the language
2. Find a default config from [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md)
3. Add the default config using require'lspconfig' to .config/nvim/lsp (remember filename)
4. Enable the lsp (remembered filename) to enabled lsps in the config in .config/nvim/lua/config/lsp.lua

## Keybindings
Bindings here are not system defaults not explicitly defined in the config.
### LSP
- `i_<C-x><C-o>` `conte`**x**`tual` **o**`ptions`
- `i_<C-S>     ` **s**`ignature` `help`
- `i_C<-n>     ` **n**`ext` `suggestion`
- `<C-]>       ` `go-to-definition`
- `grn         ` **g**`lobal` **r**`e`**n**`ame`
- `gra         ` **g**`lobal` **r**`ecommended` **a**`ctions`
- `grr         ` **g**`lobal` **r**`efe`**r**`ences`
- `gri         ` **g**`lobal` **r**`eveal` **i**`mplementations`
- `gO          ` **g**`lobal` **O**`utline`
