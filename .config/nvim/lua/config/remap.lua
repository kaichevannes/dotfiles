-- Move visually selected lines of text.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Centre screen after motion.
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Avoid accidentally entering Ex mode.
vim.keymap.set("n", "Q", "<nop>")

-- Quickfix/Local list navigation
vim.keymap.set("n", "<C-.>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-,>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>.", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>,", "<cmd>lprev<CR>zz")

-- Global replace word
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- dos2unix in buffer
vim.keymap.set("n", "<F8>", "mz<CMD>%!dos2unix<CR>`z")

-- Show full LSP error message
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { silent = true })

-- Add to quickfix list
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
