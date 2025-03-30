precmd() {
  echo -ne "\033]7;file://$PWD\033\\"
}

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Command history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# Set neovim to be the default editor
export VISUAL=nvim
export EDITOR=nvim

# Initialise homebrew
export PATH="/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin:$PATH"
eval "$(brew shellenv)"

# Set shell to vi mode
bindkey -v

zstyle :compinstall filename '/home/cheva/.zshrc'
autoload -Uz compinit
compinit

# Download plugins
# To update: rm -rf ~/.zsh && exec zsh
if [[ ! -e ~/.zsh/powerlevel10k ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
fi
if [[ ! -e ~/.zsh/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi
if [[ ! -e ~/.zsh/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
fi

## Accept suggestions
bindkey '^Y' autosuggest-accept

# Source plugins
# fzf
# <C-r> fuzzy find command history
# <C-t> fuzzy find subdirectories
# <A-c> cd into fuzzy find subdirectories
source <(fzf --zsh)
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
