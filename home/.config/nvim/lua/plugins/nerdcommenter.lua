vim.g["NERDCreateDefaultMappings"] = 0
return {
    "preservim/nerdcommenter",
    keys = {
      {"<leader>cc", "<plug>NERDCommenterToggle()<CR>", mode = "n"},
      {"<leader>cc", "<plug>NERDCommenterToggle()<CR>", mode = "v"},
    }
}
