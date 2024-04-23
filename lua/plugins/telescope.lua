return {
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      local builtin = require('telescope.builtin')
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<C-p>', builtin.git_files, {})
      vim.keymap.set('n', '<leader>fc', builtin.grep_string, {})

      telescope.setup({
        defaults = {
          mappings = {
            n = {
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            }
          }
        }
      })
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require('telescope').setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown{}
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  },
}
