Basic Flow:
1. Install wezterm
2. Make sure zsh is the default shell
3. Install yadm
4. yadm clone

Windows:
[Elevated Powershell]
1. winget install wez.wezterm 
2. wsl.exe --install
[WSL Ubuntu]
3. sudo apt update && sudo apt install zsh yadm 
4. chsh -s $(which zsh)
5. yadm clone https://github.com/kaichevannes/dotfiles.git
