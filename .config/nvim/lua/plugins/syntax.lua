return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "styled" },
				sync_install = false,

				auto_install = true,

				indent = {
					enable = true,
				},

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})

			require("treesitter-context").setup()
		end,
	},
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
