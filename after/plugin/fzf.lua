---- fzf file search
vim.api.nvim_set_keymap('n','<C-p>',':GFiles<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n','<leader>b',':Buffers<CR>', { noremap = true, silent = true})

---- fzf with ripgrep (see README)
vim.api.nvim_set_keymap('n','<C-g>',':Rg<CR>',{ noremap = true, silent = true})
