return {
	"echasnovski/mini.nvim",
	config = function()
		-- Adds [N]ext and [P]rev modifiers to text objects
		require("mini.ai").setup({
			mappings = {
				-- around prev
				around_last = "ap",
				-- inside prev
				inside_last = "ip",
			},
			n_lines = 500,
		})
		require("mini.move").setup({
			mappings = {
				left = "H",
				down = "J",
				up = "K",
				right = "L",

				line_left = "H",
				line_down = "J",
				line_up = "K",
				line_right = "L",
			},
		})
	end,
}
