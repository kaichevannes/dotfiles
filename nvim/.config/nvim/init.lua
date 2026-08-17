local servers = { "lua_ls", "yamlls", "terraformls", "gopls", "bashls" }
local parsers = { "lua", "yaml", "terraform", "go", "gomod", "gosum", "gowork", "bash", "gotmpl" }

vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.undofile = true
vim.o.scrolloff = 8
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.termguicolors = true

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
      vim.system({ 'make' }, { cwd = ev.data.path })
    end
  end,
})

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/sainnhe/gruvbox-material",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  "https://github.com/mikavilpas/yazi.nvim",
  "https://github.com/kdheepak/lazygit.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/tpope/vim-surround",
  "https://github.com/tpope/vim-repeat"
})

vim.filetype.add({
  pattern = {
    [".*/templates/.*%.ya?ml"] = "gotmpl",
    [".*/templates/.*%.tpl"] = "gotmpl",
  }
})
vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemaStore = { enable = true },
      schemas = {
        kubernetes = { "apps/**/*.yaml", "*-manifest.yaml" },
        ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yaml",
      }
    }
  }
})
vim.lsp.enable(servers)

vim.diagnostic.config({ virtual_text = true })

require("lazydev").setup()
require("nvim-treesitter").install(parsers)
vim.o.foldcolumn = "0"
-- vim.o.foldcolumn = "1"
-- vim.o.fillchars = 'eob: ,fold: ,foldinner: '
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldtext = ""
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end,
})
require("treesitter-context").setup({
  max_lines = 4,
  multiline_threshold = 1,
})
require("telescope").setup({})
require("telescope").load_extension "fzf"
require("yazi").setup({
  open_for_directories = true,
  floating_window_scaling_factor = 1,
  yazi_floating_window_border = "none",
})
vim.g.loaded_netrwPlugin = 1
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local function map(mode, l, r) vim.keymap.set(mode, l, r, { buffer = bufnr }) end
    map("n", "]c", function() gs.nav_hunk("next") end)
    map("n", "[c", function() gs.nav_hunk("prev") end)
  end,
})
vim.g.lazygit_floating_window_scaling_factor = 1
vim.g.lazygit_floating_window_border_chars = { "", "", "", "", "", "", "", "" }
vim.g.lazygit_floating_window_use_plenary = 0
vim.g.lazygit_use_neovim_remote = 0

local fmt_group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end

    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
    end
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = fmt_group, buffer = ev.buf })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = fmt_group,
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, async = false })
        end,
      })
    end
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:append("r")
    vim.opt_local.formatoptions:remove("o")
  end,
})

vim.g.gruvbox_material_foreground = "mix"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_transparent_background = 1
vim.cmd.colorscheme("gruvbox-material")

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P')
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "<leader>f", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>e", "<cmd>Yazi<cr>")
vim.keymap.set("n", "<C-g>", "<cmd>LazyGit<cr>")
vim.keymap.set("n", "ga", "<C-^>")
vim.keymap.set("n", "<leader>z", function()
  vim.wo.foldcolumn = vim.wo.foldcolumn == "0" and "auto:8" or "0"
end)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
