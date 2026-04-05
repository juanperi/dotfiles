return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    heading = {
      backgrounds = {},
    },
  },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#fb4934", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#fabd2f", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#b8bb26", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = "#83a598", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = "#d3869b", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = "#8ec07c", bold = true })

    require("render-markdown").setup(opts)

    vim.keymap.set("n", "<leader>mt", "<cmd>RenderMarkdown toggle<cr>", { desc = "Markdown: Toggle render" })
  end,
}
