local cmd = vim.cmd
local g = vim.g
g.mapleader = " "

-- global options
cmd 'syntax on'
cmd 'set number'
cmd 'set relativenumber'

-- autocomplete options
-- " Set completeopt to have a better completion experience
cmd 'set completeopt=menuone,noinsert,noselect'
-- " Avoid showing message extra message when using completion
cmd 'set shortmess+=c'

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.ignorecase = true -- search case insensitive
vim.opt.smartcase = true -- search matters if capital letter
vim.opt.inccommand = "split" -- "for incsearch while sub
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }