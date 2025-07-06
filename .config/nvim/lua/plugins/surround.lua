return {
	"kylechui/nvim-surround",
	version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		local config = require("nvim-surround.config")
		require("nvim-surround").setup({
			surrounds = {
				["<"] = {
					add = function()
						local user_input = config.get_input("<")
						if user_input then
							local element = user_input:match("^<?([^%s>]*)")
							local attributes = user_input:match("^<?[^%s>]*%s+(.-)>?$")

							local open = attributes and element .. " " .. attributes or element
							local close = element

							return { { "<" .. open .. ">" }, { "</" .. close .. ">" } }
						end
					end,
					find = function()
						return config.get_selection({ motion = "at" })
					end,
					delete = "^(%b<>)().-(%b<>)()$",
					change = {
						target = "^<([^%s<>]*)().-([^/]*)()>$",
						replacement = function()
							local user_input = config.get_input("<")
							if user_input then
								local element = user_input:match("^<?([^%s>]*)")
								local attributes = user_input:match("^<?[^%s>]*%s+(.-)>?$")

								local open = attributes and element .. " " .. attributes or element
								local close = element

								return { { open }, { close } }
							end
						end,
					},
				},
			},
		})
	end,
}
