return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require('gitsigns')
    vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame)
  end
}
