return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"igorlfs/nvim-dap-view",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		require("nvim-dap-virtual-text").setup({
			-- display_callback = function(variable)
			-- 	if #variable.value > 15 then
			-- 		return " " .. variable.value:sub(1, 15) .. "..."
			-- 	end
			-- 	return " " .. variable.value
			-- end,
		})

		require("mason-nvim-dap").setup({
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			ensure_installed = { "js" },
		})

		local dap = require("dap")

		-- local dapui = require("dapui")
		--
		-- dapui.setup({
		-- 	controls = {
		-- 		enabled = false,
		-- 	},
		-- 	layouts = {
		-- 		{
		-- 			elements = {
		-- 				-- {
		-- 				-- 	id = "breakpoints",
		-- 				-- 	size = 0.25,
		-- 				-- },
		-- 				{
		-- 					id = "repl",
		-- 					size = 0.25,
		-- 				},
		-- 				{
		-- 					id = "stacks",
		-- 					size = 0.25,
		-- 				},
		-- 				{
		-- 					id = "scopes",
		-- 					size = 0.25,
		-- 				},
		-- 				{
		-- 					id = "console",
		-- 					size = 0.25,
		-- 				},
		-- 			},
		-- 			position = "left",
		-- 			size = 35,
		-- 		},
		-- 		{
		-- 			elements = {
		-- 				{
		-- 					id = "watches",
		-- 					size = 1,
		-- 				},
		-- 			},
		-- 			position = "bottom",
		-- 			size = 16,
		-- 		},
		-- 	},
		-- })
		--
		-- dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		-- dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		-- dap.listeners.before.event_exited["dapui_config"] = dapui.close

		local dapview = require("dap-view")
		dap.listeners.after.event_initialized["dap-view-config"] = dapview.open
		-- dap.listeners.before.event_terminated["dap-view-config"] = dapview.close
		-- dap.listeners.before.event_exited["dap-view-config"] = dapview.close

		-- Javascript / Typescript
		-- Example: https://github.com/ecosse3/nvim/blob/13f1d35ca2fe326f3f4cdd516ae577eb1cef0921/lua/plugins/dap.lua
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = {
					vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
					"${port}",
				},
			},
		}

		dap.configurations.typescript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch Test Current File (pwa-node with jest)",
				cwd = vim.fn.getcwd(),
				runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
				runtimeExecutable = "node",
				args = { "${file}", "--coverage", "false" },
				rootPath = "${workspaceFolder}",
				sourceMaps = true,
				console = "integratedTerminal",
				internalConsoleOptions = "neverOpen",
				skipFiles = { "<node_internals>/**", "node_modules/**" },
			},
		}

		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F6>", function()
			dapview.toggle(true)
		end, { desc = "Debug: See last session result (dapview)" })
		-- vim.keymap.set("n", "<F6>", dapui.toggle, { desc = "Debug: See last session result (dapui)" })
		vim.keymap.set("n", "<F1>", dap.terminate, { desc = "Debug: Terminate" })

		vim.keymap.set("n", "<F3>", dap.step_back, { desc = "Debug: Step Back" })
		vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<F7>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F8>", dap.step_over, { desc = "Debug: Step Over" })

		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Conditional Breakpoint" })

		vim.keymap.set("n", "g=", require("dap.ui.widgets").hover, { desc = "Debug: Evaluate expression" })
		-- vim.keymap.set("n", "g=", dapui.eval, { desc = "Debug: Evaluate expression" })

		-- Jump to dap view window
		vim.keymap.set("n", "<leader>dw", function()
			dapview.jump_to_view("watches")
		end, { desc = "[D]ebug: Jump to [W]atches" })

		vim.keymap.set("n", "<leader>de", function()
			dapview.jump_to_view("exceptions")
		end, { desc = "[D]ebug: Jump to [E]xceptions" })

		vim.keymap.set("n", "<leader>db", function()
			dapview.jump_to_view("breakpoints")
		end, { desc = "[D]ebug: Jump to [B]reakpoints" })

		vim.keymap.set("n", "<leader>dt", function()
			dapview.jump_to_view("threads")
		end, { desc = "[D]ebug: Jump to [T]hreads" })

		vim.keymap.set("n", "<leader>dr", function()
			dapview.jump_to_view("repl")
		end, { desc = "[D]ebug: Jump to [R]epl" })

		vim.keymap.set("n", "<leader>ds", function()
			dapview.jump_to_view("scopes")
		end, { desc = "[D]ebug: Jump to [S]copes" })

		-- Virtual text
		vim.keymap.set("n", "<leader>dv", ":DapVirtualTextToggle<CR>", { desc = "Debug: Toggle Virtual Text" })
	end,
}
