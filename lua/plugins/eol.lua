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
