return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },

  config = function()
    -- import nvim-autopairs
    local autopairs = require("nvim-autopairs")

    -- config autopairs
    autopairs.setup({
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { "string" }, -- treesitter lua string
        javascript = { "template_string" }, -- don't add pairs in javascript template_string treesitter node
        java = false, -- don't check treesitter on java
      },
    })

    -- import nvim-autopairs completion functionality
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    -- import nvim-cmp plugin (completions plugin)
    local cmp = require("cmp")

    -- make autopairs and completion work together
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
}
