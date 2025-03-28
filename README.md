## Basic Flow
1. Install wezterm
2. Make sure zsh is the default shell
3. Install yadm
4. yadm clone

## Windows
```
(Elevated Powershell) $ winget install wez.wezterm 
(Elevated Powershell) $ wsl.exe --install
         (WSL Ubuntu) $ sudo apt update && sudo apt install zsh yadm 
         (WSL Ubuntu) $ chsh -s $(which zsh)
         (WSL Ubuntu) $ yadm clone https://github.com/kaichevannes/dotfiles.git
```
