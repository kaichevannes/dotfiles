return {
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
}
