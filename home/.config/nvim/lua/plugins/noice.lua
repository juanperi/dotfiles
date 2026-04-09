return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      cmdline = {
        enabled = false,
      },
      messages = {
        enabled = false,
      },
      popupmenu = {
        enabled = false,
      },
      notify = {
        enabled = false,
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = false,
        },
        progress = {
          enabled = true,
        },
        hover = {
          enabled = true,
        },
        signature = {
          enabled = true,
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
    keys = {
      { "<c-f>", function()
        if not require("noice.lsp").scroll(4) then return "<c-f>" end
      end, mode = { "n", "i", "s" }, silent = true, expr = true, desc = "Scroll docs forward" },
      { "<c-b>", function()
        if not require("noice.lsp").scroll(-4) then return "<c-b>" end
      end, mode = { "n", "i", "s" }, silent = true, expr = true, desc = "Scroll docs back" },
    },
  },
}
