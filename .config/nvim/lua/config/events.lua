-- Add groups to autocommands so they are only created once.
vim.api.nvim_create_autocmd("FileType", {
	desc = "Disable newline comments in normal mode",
	group = vim.api.nvim_create_augroup("disable-newline-comment-normal-mode", { clear = true }),
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "o" })
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
