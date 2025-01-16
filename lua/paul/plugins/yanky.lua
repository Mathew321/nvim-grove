return {
  "gbprod/yanky.nvim",
  dependencies = {
     "kkharji/sqlite.lua",
     },
  opts = {
    highlight = { timer = 250 },
  },
  keys = {
      -- stylua: ignore
    { "<leader>p", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History" },
  },
}
