return {
  "selimacerbas/markdown-preview.nvim",
  ft = { "markdown", "mermaid" },
  dependencies = { "selimacerbas/live-server.nvim" },
  config = function()
    require("markdown_preview").setup({
      instance_mode = "takeover",
      open_browser = true,
      debounce_ms = 300,

    })

    vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", { desc = "Markdown: Start preview" })
    vim.keymap.set("n", "<leader>mP", "<cmd>MarkdownPreviewStop<cr>", { desc = "Markdown: Stop preview" })
    vim.keymap.set("n", "<leader>mr", "<cmd>MarkdownPreviewRefresh<cr>", { desc = "Markdown: Refresh preview" })
  end,
}
