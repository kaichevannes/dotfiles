return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("render-markdown").setup({
				completions = { blink = { enabled = true } },
				dash = { width = 99 },
				heading = { enabled = false },
				code = {
					sign = false,
					width = "block",
					min_width = 45,
					language_icon = false,
					position = "right",
				},
				link = { enabled = false },
				indent = { enabled = false },
				-- win_options = {
				-- 	conceallevel = {
				-- 		rendered = 0,
				-- 	},
				-- },
			})
		end,
	},
}
