## Basic Flow
1. Install wezterm
2. Make sure zsh is the default shell
3. Install yadm
4. yadm clone

**Note: As of March 2025, wezterm nightly is required for yazi to work. This is because it uses a more recent version of ConPTY which handles how terminal inputs are passed to the shell.**

## Windows
```
(Elevated Powershell) $ winget install wez.wezterm 
(Elevated Powershell) $ wsl.exe --install
         (WSL Ubuntu) $ cd ~
         (WSL Ubuntu) $ sudo apt update && sudo apt install zsh yadm 
         (WSL Ubuntu) $ chsh -s $(which zsh)
         (WSL Ubuntu) $ yadm clone https://github.com/kaichevannes/dotfiles.git
```
