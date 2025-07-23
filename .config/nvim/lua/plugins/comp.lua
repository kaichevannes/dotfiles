return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = { "folke/lazydev.nvim" },
	config = function()
		require("blink.cmp").setup({
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-y: Accept
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = "default" },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				documentation = { auto_show = false },
				-- accept = {
				-- 	auto_brackets = {
				-- 		enabled = false,
				-- 	},
				-- },
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "lua" },

			-- Signature help window when typing arguments for a function
			signature = { enabled = true },
		})

		local blink = require("blink.cmp")

		vim.keymap.set("i", "<C-s>e", blink.select_and_accept)
		vim.keymap.set("i", "<C-s>;", blink.snippet_forward)
		vim.keymap.set("i", "<C-s>,", blink.snippet_backward)
		vim.keymap.set("i", "<C-e>", blink.show, { desc = "Blink Expand" })
	end,
}
