vim.api.nvim_set_keymap('n', '<C-g>', ':Rg<CR>',
  { noremap = true, silent = true, desc = "fzf: ripgrep" }
)

vim.g.tmux_navigator_no_mappings = 1

vim.api.nvim_set_keymap('n','<C-h>', ':<C-U>TmuxNavigateLeft<cr>',
  { noremap = true, silent = true, desc = "Tmux: TmuxNavigateLeft" }
)
vim.api.nvim_set_keymap('n','<C-j>', ':<C-U>TmuxNavigateDown<cr>',
  { noremap = true, silent = true, desc = "Tmux: TmuxNavigateDown" }
)
vim.api.nvim_set_keymap('n','<C-k>', ':<C-U>TmuxNavigateUp<cr>',
  { noremap = true, silent = true, desc = "Tmux: TmuxNavigateUp" }
)
vim.api.nvim_set_keymap('n','<C-l>', ':<C-U>TmuxNavigateRight<cr>',
  { noremap = true, silent = true, desc = "Tmux: TmuxNavigateRight" }
)