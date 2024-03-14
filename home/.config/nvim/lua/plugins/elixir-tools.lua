return {
  "elixir-tools/elixir-tools.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local elixir = require("elixir")
    local elixirls = require("elixir.elixirls")

    elixir.setup {
      nextls = {
        enable = true,
        cmd = "nextls" -- I'm managing nextl through brew
      },
      credo = {enable = true},
      elixirls = {enable = false}
    }
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
