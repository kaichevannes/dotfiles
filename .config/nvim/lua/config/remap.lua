-- Move visually selected lines of text.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Centre screen after motion.
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without losing buffer contents.
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Delete without copying into buffer
vim.keymap.set("n", "<leader>d", "\"_d")

-- Create line and stay in normal mode
vim.keymap.set("n", "<leader>o", "o<ESC>")
vim.keymap.set("n", "<leader>O", "O<ESC>")

-- Copy to system clipboard.
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Paste from system clipboard.
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")

-- Avoid accidentally entering Ex mode.
vim.keymap.set("n", "Q", "<nop>")

-- Quickfix/Local list navigation
vim.keymap.set("n", "<C-.>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-,>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>.", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<ledaer>,", "<cmd>lprev<CR>zz")

-- Global replace word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- dos2unix in buffer
vim.keymap.set("n", "<F9>", "mz<CMD>%!dos2unix<CR>`z")
