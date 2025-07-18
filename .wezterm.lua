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

config.window_close_confirmation = 'NeverPrompt'
 
-- beeps
config.audible_bell = "Disabled"

-- tabs
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- Colorscheme 
local path = wezterm.config_dir .. "/.colorscheme"

local file = io.open(path, "r")
if file then
	config.color_scheme = file:read("*a")
	file:close()
else
	config.color_scheme = "SleepyHollow"
end

config.automatically_reload_config = true
wezterm.add_to_config_reload_watch_list(path)

-- font
config.font = wezterm.font "Dank Mono"
config.font_size = 24.0

-- keybindings
config.disable_default_key_bindings = true
config.adjust_window_size_when_changing_font_size = false
local act = wezterm.action
config.leader = {key='w', mods='ALT', timeout_milliseconds=1000}

config.keys = {
    { key = 'v', mods = 'SHIFT | CTRL', action = act.PasteFrom 'Clipboard'},
    { key = 'c', mods = 'SHIFT | CTRL', action = act.CopyTo 'Clipboard'},
    { key = 'f', mods = 'ALT', action = act.ToggleFullScreen},
    { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1)},
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1)},
    { key = '-', mods = 'ALT', action = act.DecreaseFontSize},
    { key = '=', mods = 'ALT', action = act.IncreaseFontSize},
    { key = '0', mods = 'ALT', action = act.ResetFontSize},
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
    { key = '6', mods = 'ALT|SHIFT', action = act.ActivateLastTab},
    { key = 'PageUp', mods = 'ALT', action = act.MoveTabRelative(1)},
    { key = 'PageDown', mods = 'ALT', action = act.MoveTabRelative(-1)},
    { key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain'},
    { key = 'q', mods = 'ALT', action = act.CloseCurrentTab{confirm = false}},
    { key = 'z', mods = 'ALT', action = act.TogglePaneZoomState},
    { key = 'c', mods = 'LEADER', action = act.CloseCurrentPane{confirm = false}},
    { key = 'v', mods = 'LEADER', action = act.SplitHorizontal{domain = 'CurrentPaneDomain'}},
    { key = 's', mods = 'LEADER', action = act.SplitVertical{domain = 'CurrentPaneDomain'}},
    { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left'},
    { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down'},
    { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up'},
    { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right'},
    { key = ";", mods = "CTRL", action = wezterm.action.SendString("\x1b[27;5;59~")},
}

-- and finally, return the configuration to wezterm
return config
