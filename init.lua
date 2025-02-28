-- [Install plugin manager Lazy]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [ Basic keymaps ]
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "<leader>y", '"+y')

-- highlight yanked text for 150ms using the "Visual" highlight group
vim.cmd[[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=150})
augroup END
]]

-- [ Quickfix ]
vim.keymap.set("n", "<C-<>", "<cmd>cprev<CR>")
vim.keymap.set("n", "<C->>", "<cmd>cnext<CR>")

-- [ Go Formatting ]
-- Run gofmt + goimports on save

local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})

-- Set up listchars
vim.opt.listchars = { eol = '↲', trail = '·', tab = '▸ ' }

-- Function to toggle EOL visibility with status message
local function toggle_eol()
  local current = vim.opt.list:get()
  vim.opt.list = not current
  local status = (not current) and "ON" or "OFF"
  vim.notify("EOL: " .. status, vim.log.levels.INFO)
end

-- Function to toggle fixendofline with status message
local function toggle_fixendofline()
  local current = vim.opt.fixendofline:get()
  vim.opt.fixendofline = not current
  local status = (not current) and "ON" or "OFF"
  vim.notify("Fix End of Line: " .. status, vim.log.levels.INFO)
end

-- Set up keymaps
vim.keymap.set(
"n",
"<leader>l",
toggle_eol,
{ noremap = true, silent = true, desc = "Toggle EOL visibility" }
)

vim.keymap.set(
"n",
"<leader>L",
toggle_fixendofline,
{ noremap = true, silent = true, desc = "Toggle fix end of line" }
)

require("lazy").setup('plugins')

