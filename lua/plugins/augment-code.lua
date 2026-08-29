return {
  --[[ "augmentcode/augment.vim",
  config = function()
    -- Disable default tab mapping
    vim.g.augment_workspace_folders = {'/Users/miguelramirez/go/src/github.com/credifranco'}
    vim.g.augment_disable_tab_mapping = true

    -- Add shortcut for chat toggle
    vim.keymap.set('n', '<leader>fa', '<cmd>Augment chat-toggle<CR>',
      { noremap = true, silent = true, desc = "Toggle Augment Chat" })
  end ]]
}
