return {
	"echasnovski/mini.nvim",
	config = function()
		-- Adds [N]ext and [P]rev modifiers to text objects
		require("mini.ai").setup({
			-- We use last instead of prev to avoid overlapping bindings like dap
			mappings = {
				around_last = "al",
				inside_last = "il",
			},
			n_lines = 500,
		})

		require("mini.move").setup({
			mappings = {
				left = "H",
				down = "J",
				up = "K",
				right = "L",
			},
		})
	end,
}
