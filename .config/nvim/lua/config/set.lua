vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.opt.title = true

-- When a long line wraps on the screen, show it properly indented.
vim.opt.breakindent = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = ""

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions while typing
vim.opt.inccommand = "split"

-- Show confirm prompt when quitting without saving
vim.opt.confirm = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim.undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

vim.opt.colorcolumn = "100"

-- Auto-wrap comments at 80 chars
vim.opt.textwidth = 100
