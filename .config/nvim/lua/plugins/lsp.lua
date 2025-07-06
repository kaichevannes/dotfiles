return {
	{
		-- Neovim specific LuaLs configuration.
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		-- Better rust LSP
		"mrcjkb/rustaceanvim",
		version = "^6", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("gra", vim.lsp.buf.code_action, "[R]ecommended [A]ction", { "n", "x" })
					map("grs", require("telescope.builtin").lsp_references, "[R]eference[S]")
					map("gri", require("telescope.builtin").lsp_implementations, "[R]eference [I]mplementation")
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [d]efinition")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					map("<leader>ls", require("telescope.builtin").lsp_document_symbols, "[L]ist [s]ymbols")
					map(
						"<leader>lS",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[L]ist all [S]ymbols"
					)
					map("<leader>td", require("telescope.builtin").lsp_type_definitions, "[T]ype [D]efinition")

					-- Diagnostic info points towards error
					vim.diagnostic.config({
						virtual_text = false,
						virtual_lines = false,
					})
					local virtual_lines_enabled = false

					function ToggleVirtualLines()
						virtual_lines_enabled = not virtual_lines_enabled
						vim.diagnostic.config({
							virtual_lines = virtual_lines_enabled,
						})
					end

					map("gdi", ToggleVirtualLines, "[D]ebug [I]nfo")
				end,
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities({
				textDocument = { completion = { completionItem = { snippetSupport = false } } },
			})

			-- Servers to install
			local servers = {
				lua_ls = {
					-- cmd = { ... },
					-- filetypes = { ... },
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
				bashls = {},
				clangd = {},
				cssls = {},
				dockerls = {},
				html = {},
				jsonls = {},
				-- marksman = {},
				pylsp = {},
				taplo = {},
				rust_analyzer = {},
				ts_ls = {},
				yamlls = {},
				-- gopls = {},
				-- neocmake = {},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason").setup()
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
				automatic_installation = false,
				automatic_enable = {
					exclude = { "rust_analyzer" },
				},
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
