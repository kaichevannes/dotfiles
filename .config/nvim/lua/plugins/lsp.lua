return {
  {
    -- Neovim specific LuaLs configuration.
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim',    opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('lrn', vim.lsp.buf.rename, '[L]SP [R]e[n]ame')
          map('lra', vim.lsp.buf.code_action, '[L]SP [R]ecommended [A]ction', { 'n', 'x' })
          map('lrr', require('telescope.builtin').lsp_references, '[L]SP [R]efe[R]ences')
          map('li', require('telescope.builtin').lsp_implementations, '[L]SP [I]mplementation')
          map('ld', require('telescope.builtin').lsp_definitions, '[L]sp [d]efinition')
          map('lD', require('telescope.builtin').lsp_declaration, '[L]sp [D]eclaration')
          map('ls', require('telescope.builtin').lsp_document_symbols, '[L]sp buffer [s]ymbols')
          map('lS', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[L]sp workspace [S]ymbols')
          map('ltd', require('telescope.builtin').lsp_type_definitions, '[L]SP [T]ype [D]efinition')
        end
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Servers to always install, or custom configuration
      local servers = {
        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }
      --
      -- local ensure_installed = vim.tbl_keys(servers or {})
      -- vim.list_extend(ensure_installed, {
      --   'stylua', -- Used to format Lua code
      -- })
      -- require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      --
      -- require('mason-lspconfig').setup {
      --   ensure_installed = {}, -- set to empty, we use ensure installed above for extra config
      --   automatic_installation = false,
      --   handlers = {
      --     function(server_name)
      --       local server = servers[server_name] or {}
      --       -- This handles overriding only values explicitly passed
      --       -- by the server configuration above. Useful when disabling
      --       -- certain features of an LSP (for example, turning off formatting for ts_ls)
      --       server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      --       require('lspconfig')[server_name].setup(server)
      --     end,
      --   },
      -- }
    end,
  }
}
