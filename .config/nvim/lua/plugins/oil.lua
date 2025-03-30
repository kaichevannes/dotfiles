return {
  "stevearc/oil.nvim",
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  config = function()
    require("oil").setup({
      skip_confirm_for_simple_edits = true,
      use_default_keymaps = false,
      keymaps = {
        ["<CR>"] = "actions.select",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["<ESC>"] = { "actions.close", mode = "n" },
      }
    })

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
}
