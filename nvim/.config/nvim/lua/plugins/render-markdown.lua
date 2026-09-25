return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  cmd = { "RenderMarkdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-mini/mini.icons",
  },
  opts = {},
  keys = {
    {
      "<leader>um",
      "<cmd>RenderMarkdown toggle<cr>",
      desc = "Alternar renderizado Markdown",
    },
  },
}
