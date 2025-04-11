-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()


-- This is where you actually apply your config choices
-- shell
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_domain = 'WSL:Ubuntu'

    local launch_menu = {}

    table.insert(launch_menu, {
        label = 'PowerShell',
        args = { 'powershell.exe', '-NoLogo' },
        domain = { DomainName = 'local' },
    })

    config.launch_menu = launch_menu
end
 
-- beeps
config.audible_bell = "Disabled"

-- tabs
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- colors
-- config.color_scheme = 'Monokai Pro Ristretto (Gogh)'
config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = "SleepyHollow"
-- config.color_scheme = "Gruvbox Dark (Gogh)"

-- font
config.font = wezterm.font "Dank Mono"
config.font_size = 14.0

-- keybindings
config.disable_default_key_bindings = true
local act = wezterm.action
config.leader = {key='w', mods='ALT', timeout_milliseconds=1000}

config.keys = {
    { key = 'v', mods = 'SHIFT | CTRL', action = act.PasteFrom 'Clipboard'},
    { key = 'c', mods = 'SHIFT | CTRL', action = act.CopyTo 'Clipboard'},
    { key = 'f', mods = 'ALT', action = act.ToggleFullScreen},
    { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1)},
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1)},
    { key = 'r', mods = 'ALT', action = act.ReloadConfiguration},
    { key = '1', mods = 'ALT', action = act.ActivateTab(0)},
    { key = '2', mods = 'ALT', action = act.ActivateTab(1)},
    { key = '3', mods = 'ALT', action = act.ActivateTab(2)},
    { key = '4', mods = 'ALT', action = act.ActivateTab(3)},
    { key = '5', mods = 'ALT', action = act.ActivateTab(4)},
    { key = '6', mods = 'ALT', action = act.ActivateTab(5)},
    { key = '7', mods = 'ALT', action = act.ActivateTab(6)},
    { key = '8', mods = 'ALT', action = act.ActivateTab(7)}, 
    { key = '9', mods = 'ALT', action = act.ActivateTab(8)},
    { key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain'},
    { key = 'q', mods = 'ALT', action = act.CloseCurrentTab{confirm = false}},
    { key = 'c', mods = 'LEADER', action = act.CloseCurrentPane{confirm = false}},
    { key = 'v', mods = 'LEADER', action = act.SplitHorizontal{domain = 'CurrentPaneDomain'}},
    { key = 's', mods = 'LEADER', action = act.SplitVertical{domain = 'CurrentPaneDomain'}},
    { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left'},
    { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down'},
    { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up'},
    { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right'},
}


-- and finally, return the configuration to wezterm
return config
