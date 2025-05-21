return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	keys = {
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Start/Continue",
		},
		{
			"<F3>",
			function()
				require("dap").step_back()
			end,
		},
		{
			"<F4>",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step Over",
		},
		{
			"<F7>",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step Into",
		},
		{
			"<F8>",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step Out",
		},
		{
			"<leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle Breakpoint",
		},
		{
			"<leader>B",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Debug: Set Breakpoint",
		},
		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		{
			"<F6>",
			function()
				require("dapui").toggle()
			end,
			desc = "Debug: See last session result.",
		},
		{
			"g=",
			function()
				require("dapui").eval(nil, { enter = true })
			end,
			desc = "Evaluate under cursor",
		},
	},
	config = function()
		require("nvim-dap-virtual-text").setup()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			ensure_installed = { "js" },
		})

		dapui.setup()

		-- dap.listeners.before.attach["dapui_config"] = dapui.open
		-- dap.listeners.before.launch["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

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
	end,
}
