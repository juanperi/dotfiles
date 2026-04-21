---@module "snacks"
---@module "opencode"

return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for the `snacks` provider.
    {
      "folke/snacks.nvim",
      opts = {
        input = {},
        picker = {},
        terminal = {},
      },
    },
  },
  config = function()
    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    vim.g.opencode_opts = {
      -- Point at the shared `opencode serve` run by `oc` / `mux_opencode`.
      -- Keep this port in sync with $OPENCODE_BASE in ~/.local/bin/_opencode_common.sh.
      -- See ~/spikes/2026-04-19_create-my-own-orchestrator/INTEGRATION.md § nvim.
      server = {
        port = 4096,
        start = false, -- don't auto-spawn another opencode; use the shared one
      },
    }

    local opencode = require("opencode")
    local map = vim.keymap.set

    -- Recommended/example keymaps.
    map({ "n", "x" }, "<leader>oq", function()
      opencode.ask("@this: ", { submit = true })
    end, { desc = "[o]pencode [q]uestion" })

    map({ "n", "x" }, "<leader>ox", function()
      opencode.select()
    end, { desc = "[o]pencode e[x]ecute action" })

    map({ "n", "x" }, "<leader>oa", function()
      opencode.prompt("@this")
    end, { desc = "[o]pencode [a]dd" })

    map({ "n", "t" }, "<leader>ot", function()
      opencode.toggle()
    end, { desc = "[o]pencode [t]oggle" })

    map("n", "<leader>ou", function()
      opencode.command("session.half.page.up")
    end, { desc = "[o]pencode page [u]p" })

    map("n", "<leader>od", function()
      opencode.command("session.half.page.down")
    end, { desc = "[o]pencode page [d]own" })
  end,
}
