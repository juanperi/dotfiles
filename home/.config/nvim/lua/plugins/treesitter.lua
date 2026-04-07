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

return {}
