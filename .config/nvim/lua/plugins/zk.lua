return {
	"zk-org/zk-nvim",
	config = function()
		require("zk").setup({})

		vim.keymap.set(
			"n",
			"<leader>zn",
			"<CMD>ZkNew { title = vim.fn.input('Title: ')}<CR>",
			{ desc = "[Z]ettel [N]ew", noremap = true, silent = false }
		)

		vim.keymap.set(
			"n",
			"<leader>zo",
			"<CMD>ZkNotes { sort = { 'created' }}<CR>",
			{ desc = "[Z]ettel [O]pen", noremap = true, silent = false }
		)

		vim.keymap.set("n", "<leader>zt", function()
			require("zk").pick_tags({}, {}, function(selected)
				local tag_names = vim.tbl_map(function(t)
					return t.name
				end, selected)

				require("zk.commands").get("ZkNotes")({
					sort = { "created" },
					tags = tag_names,
				})
			end)
		end, {
			desc = "[Z]ettel [T]ags",
			noremap = true,
			silent = false,
		})

		vim.keymap.set(
			"n",
			"<leader>zb",
			"<CMD>ZkBacklinks<CR>",
			{ desc = "[Z]ettel [B]acklinks", noremap = true, silent = false }
		)

		vim.keymap.set(
			"n",
			"<leader>zl",
			"<CMD>ZkLinks<CR>",
			{ desc = "[Z]ettel [L]inks", noremap = true, silent = false }
		)

		vim.keymap.set(
			"n",
			"<leader>zi",
			"<CMD>ZkInsertLink<CR>",
			{ desc = "[Z]ettel [I]nsert (Link)", noremap = true, silent = false }
		)

		vim.keymap.set(
			"x",
			"<leader>zi",
			"<CMD>'<,'>ZkInsertLinkAtSelection<CR>",
			{ desc = "[Z]ettel [I]nsert (Link)", noremap = true, silent = false }
		)
	end,
}
