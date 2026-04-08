vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > 100 * 1024 then
      return
    end
    pcall(vim.treesitter.start)
    vim.bo.indentexpr = "v:lua.vim.treesitter.indentexpr()"
  end,
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = function()
      require("nvim-treesitter").install({ "all" }):wait()
    end,
    init = function()
      local ok, ts = pcall(require, "nvim-treesitter")
      if not ok then return end
      local installed = require("nvim-treesitter.config").get_installed()
      local ensure = { "json", "lua", "elixir", "heex", "javascript", "typescript", "markdown" }
      local to_install = vim.tbl_filter(function(p)
        return not vim.tbl_contains(installed, p)
      end, ensure)
      if #to_install > 0 then
        ts.install(to_install)
      end
    end,
  },
}
