if status is-interactive
    set fish_greeting

    # Y to accept
    bind \cy accept-autosuggestion

    # Initialise homebrew
    set -x PATH "/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin:$PATH"
    eval (brew shellenv)

    set -x VISUAL hx
    set -x EDITOR hx

    # Start ssh agent
    # keychain --quiet --eval id_ed25519 | source
    # Only start ssh-agent if not already running
    if not set -q SSH_AUTH_SOCK
        eval (ssh-agent -c) >/dev/null
        ssh-add -q ~/.ssh/id_ed25519
    end

    starship init fish | source
    enable_transience
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# zettel
set -x ZK_NOTEBOOK_DIR ~/zettel

# dotnet
set -x DOTNET_ROOT $HOME/.dotnet
set -x PATH $PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
