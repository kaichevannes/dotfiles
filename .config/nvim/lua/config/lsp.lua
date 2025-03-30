-- Enable lsps
vim.lsp.enable({
  "bashls",        -- Bash
  "clangd",        -- C/C++
  "cssls",         -- CSS/LESS/SASS
  "gopls",         -- Go
  "dockerls",      -- Docker
  "html",          -- HTML
  "lua_ls",        -- Lua
  "marksman",      -- Markdown
  "neocmake",      -- CMake
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

vim.o.completeopt = "menuone,noinsert,popup,fuzzy"

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Enable completions
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
    end

    -- Format on save
    if not client:supports_method("textDocument/willSaveWaitUntil")
        and client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
