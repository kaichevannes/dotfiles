if status is-interactive
  set fish_greeting

  # Y to accept
  bind \cy accept-autosuggestion

  # Initialise homebrew
  set -x PATH "/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin:$PATH"
  eval (brew shellenv)

  set -x VISUAL nvim
  set -x EDITOR nvim

  # Start ssh agent
  keychain --quiet --eval id_ed25519 | source

  starship init fish | source
  enable_transience
end
