return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},

			current_line_blame_opts = {
				delay = 0,
			},

			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Jump to next git [c]hange" })

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Jump to previous git [c]hange" })

				-- Actions
				-- visual mode
				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[H]unk [S]tage" })
				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[H]unt [R]eset" })

				-- normal mode
				map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[H]unk [S]tage" })
				map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[H]unk [r]eset" })
				map("n", "<leader>hu", gitsigns.stage_hunk, { desc = "[H]unk [U]nstage" })
				map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "[H]unk buffer [R]eset" })
				map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[H]unk [P]review" })
				map("n", "<leader>hb", gitsigns.blame_line, { desc = "[H]unk [B]lame" })
				map("n", "<leader>hd", gitsigns.diffthis, { desc = "[H]unk [d]iff" })
				map("n", "<leader>hD", function()
					gitsigns.diffthis("@")
				end, { desc = "[H]unk last commit [D]iff" })

				-- Toggles
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle [B]lame" })
				map("n", "<leader>tD", gitsigns.preview_hunk_inline, { desc = "[T]oggle [D]eleted" })

				-- Text object
				map({ "o", "x" }, "ih", gitsigns.select_hunk)
			end,
		})
	end,
}
