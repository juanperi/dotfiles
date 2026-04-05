local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",
  opts = {
    highlight = {
      enable = true,
      disable = function(_lang, buf)
        local max_filesize = 100 * 1024         -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    autopairs = { enable = true },
    autotag = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "elixir",
      "heex",
      "erlang",
      "dockerfile",
      "json",
      "make",
      "markdown",
      "markdown_inline",
      "regex",
      "scss",
      "vim",
      "python",
      "lua",
      "c",
      "vim",
      "vimdoc"
    },
    sync_install = true,
    ignore_install = {},
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

return M
