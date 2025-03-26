return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
      { "nvim-telescope/telescope.nvim" },
    },
    opts = {
      debug = false,
      mappings = {
        reset = {
          normal = '<C-x>',
          insert = '<C-x>'
        }
      }
    },
    keys = {
      {
        "<leader>co",
        function()
          require("CopilotChat").open()
        end,
        desc = "[c]opilotChat - Open chat window",
      },
      {
        "<leader>cf",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        desc = "[c]opilotChat - [f]ix diagnostics",
      },
      -- Show prompts actions with telescope
      {
        "<leader>cp",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "[c]opilotChat - [p]rompt actions",
      },
      {
        "<leader>cq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "[c]opilotChat - [q]uick chat",
      }
    }
  }
}
