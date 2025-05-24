local neovim_colorscheme_persist_filename = vim.fn.stdpath("data") .. "/colorscheme"
local f = io.open(neovim_colorscheme_persist_filename, "r")
if f then
	vim.cmd.colorscheme(f:read("*a"))
	f:close()
else
	vim.cmd.colorscheme("gruvbox-material")
end

-- Sync colorscheme with WezTerm
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("wezterm_colorscheme", { clear = true }),
	callback = function(args)
		local colorschemes = {
			["catppuccin"] = "Catppuccin Mocha",
			["kanagawa-dragon"] = "Kanagawa Dragon (Gogh)",
			["kanagawa"] = "Kanagawa",
			["gruvbox-material"] = "SleepyHollow",
		}
		local colorscheme = colorschemes[args.match]
		if not colorscheme then
			return
		end
		-- Write the colorscheme to a file
		local uname = vim.fn.system("uname -r")
		local file_to_store_colorscheme = ".colorscheme"
		local filename
		local on_wsl = uname:lower():find("microsoft")
		if on_wsl then
			local win_home = vim.fn.system([[cmd.exe /C "echo %USERPROFILE%" 2> /dev/null]]):gsub("\r?\n", "")
			local wslpath = vim.fn.system("wslpath '" .. win_home .. "'"):gsub("%s+", "")
			filename = wslpath .. "/" .. file_to_store_colorscheme
		else
			filename = vim.fn.expand("$HOME/" .. file_to_store_colorscheme)
		end
		assert(type(filename) == "string")
		local file = io.open(filename, "w")
		assert(file)
		file:write(colorscheme)
		file:close()

		local wezterm_executable
		if on_wsl then
			wezterm_executable = "wezterm.exe"
		else
			wezterm_executable = "wezterm"
		end
		vim.fn.system(wezterm_executable .. "cli reload-config")

		vim.notify("Setting WezTerm color scheme to " .. colorscheme, vim.log.levels.INFO)

		-- Persist in neovim, sometimes the colorschemes are different
		file = io.open(neovim_colorscheme_persist_filename, "w")
		assert(file)
		file:write(args.match)
		file:close()
	end,
})
