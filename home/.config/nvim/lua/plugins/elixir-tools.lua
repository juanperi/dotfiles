return {
  "elixir-tools/elixir-tools.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local elixir = require("elixir")
    local elixirls = require("elixir.elixirls")

    elixir.setup {
      nextls = {enable = false},
      credo = {enable = true},
      elixirls = {enable = true}
    }
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
