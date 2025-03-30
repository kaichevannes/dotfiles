-- Enable lsps
-- (this is just sourcing the files I think, I could inline their contents here)
vim.lsp.enable({
  "bashls",        -- Bash
  "clangd",        -- C/C++
  "cssls",         -- CSS/LESS/SASS
  "gopls",         -- Go
  "html",          -- HTML
  "lua_ls",        -- Lua
  "marksman",      -- Markdown
  "pylsp",         -- Python
  "rust_analyzer", -- Rust
  "taplo",         -- TOML
  "ts_ls",         -- TypeScript/JavaScript
  "jsonls",        -- JSON
  "yamlls",        -- YAML
})

-- Config
vim.diagnostic.config({
  virtual_text = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    vim.keymap.set({ 'n', 'x' }, 'gq', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', { buffer = args.buf })

    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Enable completions
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf)
    end

    -- Format on save
    if not client:supports_method("textDocument/willSaveWaitUntil")
        and client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
