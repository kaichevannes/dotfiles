vim.opt.number = false
vim.opt.signcolumn = "no"
vim.opt.termguicolors = true

vim.opt.runtimepath:append(",~/.local/share/nvim/site/pack/core/opt/gruvbox-material")

vim.g.gruvbox_material_foreground = "mix"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_transparent_background = 1
vim.cmd.colorscheme("gruvbox-material")
