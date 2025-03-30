return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_enabled = false

    vim.keymap.set('i', '<C-y>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false
    })
    vim.g.copilot_no_tab_map = true

    local toggle_copilot = function()
      if vim.g.copilot_enabled then
        vim.g.copilot_enabled = false
        print("Copilot disabled")
      else
        vim.g.copilot_enabled = true
        print("Copilot enabled")
      end
    end

    vim.keymap.set("n", "<leader>cp", toggle_copilot)
  end
}
