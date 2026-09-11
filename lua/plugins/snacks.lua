return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    indent = {
      enabled = true,
      animate = {
        style = "up_down", -- grow toward whichever end of the scope the cursor entered from
      },
      -- chunk stays disabled (default): that's the boxed corner/arrow style we didn't want
    },
    scroll = {
      enabled = false,
    },
  },
}
