---- fzf file search
vim.api.nvim_set_keymap('n', '<C-p>', ':GFiles<CR>',
  { noremap = true, silent = true, desc = "fzf: git files" }
)
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>',
  { noremap = true, silent = true, desc = "fzf: buffers" }
)

---- fzf with ripgrep (see README)
vim.api.nvim_set_keymap('n', '<C-g>', ':Rg<CR>',
  { noremap = true, silent = true, desc = "fzf: ripgrep" }
)
