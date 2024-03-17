return {
  "elixir-tools/elixir-tools.nvim",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local elixir = require("elixir")
    local elixirls = require("elixir.elixirls")

    elixir.setup {
      nextls = {
        enable = true,
        cmd = "nextls", -- managed by brew
        init_options = {
          experimental = {
            completions = {
              enable = true -- control if completions are enabled. defaults to false
            }
          }
        },
      },
      credo = {
        enable = false,
      },
      elixirls = {
        enable = false,
        -- Compiled manually with:
        -- mix deps.get
        -- MIX_ENV=prod mix compile
        -- MIX_ENV=prod mix elixir_ls.release
        cmd = "/Users/jperi/workspace/elixir-ls/release/language_server.sh",

        -- default settings, use the `settings` function to override settings
        settings = elixirls.settings {
          dialyzerEnabled = false,
          fetchDeps = false,
          enableTestLenses = false,
          suggestSpecs = false,
        },
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
          vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
          vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
        end
      }
    }
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "elixir-editors/vim-elixir",
  },
}
