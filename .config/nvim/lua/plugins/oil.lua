return {
  "stevearc/oil.nvim",
  dependencies = {{"echasnovski/mini.icons", opts={}}},
  lazy=false,
  config = function()
    require("oil").setup({
      use_default_keymaps = false,
      keymaps = {
        ["<CR>"] = "actions.select",
        ["<C-v>"] = {"actions.select", opts = {vertical = true}},
        ["<C-t>"] = {"actions.select", opts = {tab = true}},
        ["-"] = {"actions.parent", mode = "n"},
        ["_"] = {"actions.open_cwd", mode = "n"},
        ["g."] = {"actions.toggle_hidden", mode = "n"},
      }
    })

  vim.keymap.set("n", "-", "<CMD>Oil<CR>", {desc = "Open parent directory"})
  end
}
