local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "gra", function()
	vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
	-- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })

vim.keymap.set(
	"n",
	"K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
		vim.cmd.RustLsp({ "hover", "actions" })
	end,
	{ silent = true, buffer = bufnr }
)

vim.keymap.set("n", "gee", function()
	vim.cmd.RustLsp("explainError", "current")
end, { silent = true, buffer = bufnr, desc = "[E]xplain [E]rror" })

vim.keymap.set("n", "gL", function()
	vim.cmd.RustLsp("renderDiagnostic", "current")
end, { silent = true, buffer = bufnr })

vim.keymap.set("n", "J", function()
	vim.cmd.RustLsp("joinLines")
end, { silent = true, buffer = bufnr })

vim.keymap.set("n", "<F5>", function()
	vim.cmd.RustLsp("debug")
end, { silent = true, buffer = bufnr })

vim.keymap.set("n", "<S-F5>", function()
	vim.cmd.RustLsp("debuggables")
end, { silent = true, buffer = bufnr })
