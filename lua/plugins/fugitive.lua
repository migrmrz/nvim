return {
  'tpope/vim-fugitive',

  dependencies = {
    'lewis6991/gitsigns.nvim'
  },

  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

    require('gitsigns').setup()
  end

}
