vim.cmd("iabbrev -- —")
vim.cmd("iabbrev —- –")

if require("zk.util").notebook_root(vim.fn.expand("%:p")) ~= nil then
	vim.keymap.set("n", "<F10>", function()
		local fo = vim.bo.formatoptions
		if fo:find("a") then
			vim.bo.formatoptions = fo:gsub("a", "")
			print("formatoptions: removed 'a'")
		else
			vim.bo.formatoptions = fo .. "a"
			print("formatoptions: added 'a'")
		end
	end)

	vim.keymap.set(
		"n",
		"<leader>zb",
		"<CMD>ZkBacklinks<CR>",
		{ desc = "[Z]ettel [B]acklinks", noremap = true, silent = false }
	)

	vim.keymap.set("n", "<leader>zl", "<CMD>ZkLinks<CR>", { desc = "[Z]ettel [L]inks", noremap = true, silent = false })

	vim.keymap.set(
		"n",
		"<leader>zi",
		"<CMD>ZkInsertLink<CR>",
		{ desc = "[Z]ettel [I]nsert (Link)", noremap = true, silent = false }
	)

	vim.keymap.set(
		"x",
		"<leader>zi",
		":'<,'>ZkInsertLinkAtSelection<CR>",
		{ desc = "[Z]ettel [I]nsert (Link)", noremap = true, silent = false }
	)

	vim.keymap.set(
		"x",
		"<leader>zn",
		":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
		{ desc = "[Z]ettel from [C]ontent", noremap = true, silent = false }
	)

	vim.keymap.set(
		"x",
		"<leader>zm",
		":'<,'>ZkMatch { sort = { 'created' }}<CR>",
		{ desc = "[Z]ettel [M]atch", noremap = true, silent = false }
	)
end
