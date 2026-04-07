return {
  "stevearc/aerial.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    backends = { "treesitter", "lsp", "markdown" },
    layout = {
      default_direction = "prefer_right",
      min_width = 30,
    },
    show_guides = true,
    on_attach = function(bufnr)
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
  },
  keys = {
    { "<leader>mo", "<cmd>AerialToggle!<CR>", desc = "Toggle outline" },
    { "<leader>ms", "<cmd>Telescope aerial<CR>", desc = "Search symbols" },
  },
  config = function(_, opts)
    require("aerial").setup(opts)
    require("telescope").load_extension("aerial")
  end,
}
