return {
  "ray-x/go.nvim",
  dependencies = {  -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    -- Ensure GOTMPDIR is set before setting up go.nvim
    local go_tmpdir = os.getenv("HOME") .. "/.tmp/go-tmp"
    if vim.env.GOTMPDIR == nil or vim.env.GOTMPDIR == "" then
      vim.env.GOTMPDIR = go_tmpdir
    end
    
    require("go").setup({
      -- Pass environment to Go tools
      goimport = 'goimports',
      gofmt = 'gofmt',
      -- Disable go.nvim's LSP setup since we configure gopls manually in lsp-simple.lua
      lsp_cfg = false,
      lsp_keymaps = false,
      -- Disable other features that might interfere
      lsp_inlay_hints = {
        enable = false, -- Disable inlay hints to prevent "no package metadata" errors
      },
      diagnostic = {
        hdlr = false,
      },
    })
  end,
  event = {"CmdlineEnter"},
  ft = {"go", 'gomod'},
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
