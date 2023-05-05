vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, {desc="Vim: Explorer"})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc="Move line up"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc="Move line down"})

vim.keymap.set("n", "J", "mzJ`z", {desc="Combine lines"})
vim.keymap.set("n", "<C-d>", "<C-d>zz",{desc="Delete"})
vim.keymap.set("n", "<C-u>", "<C-u>zz",{desc="Undo"})
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- greatest remap ever
vim.keymap.set("x", "<leader>p", "\"_dP")

-- next greatest remap ever : asbjornHaland
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")


vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- tmux session changer
vim.api.nvim_set_keymap('n', '<leader>ts', ':terminal tss<CR>', 
  { noremap = true, silent = true , desc="tmux session selector"}
)

---- escape the terminal
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>',
  { noremap = true, silent = true , desc="Escape Terminal"}
)

-- Git Quickfix List
vim.api.nvim_set_keymap('n', '<leader>clo', ':copen<CR>',
  { noremap = true, silent = true , desc='Open quickfix list'}
)
vim.api.nvim_set_keymap('n', '<leader>clc', ':cclose<CR>',
  { noremap = true, silent = true , desc='Close quickfix list'}
)
vim.api.nvim_set_keymap('n', '<leader>cln', ':cnext<CR>',
  { noremap = true, silent = true , desc='Next quickfix item'}
)
vim.api.nvim_set_keymap('n', '<leader>clp', ':cprevious<CR>',
  { noremap = true, silent = true , desc='Previous quickfix item'}
)