require('newmi1988')

local fn = vim.fn 
local g = vim.g
local opt = vim.opt
local Plug = vim.fn['plug#']

-- bootstrap lazy.nvim 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
-- vim.call('plug#begin', '~/.config/nvim/plugged')
require("lazy").setup({
 'catppuccin/nvim',
 'preservim/nerdtree',
 'Xuyuanp/nerdtree-git-plugin',
 'junegunn/fzf.vim',
 {'junegunn/fzf', build='fzf#install'},
 'editorconfig/editorconfig-vim',
 'p00f/nvim-ts-rainbow',
 'tpope/vim-commentary',
 {'nvim-treesitter/nvim-treesitter', build=':TSUpdate'},
'lewis6991/gitsigns.nvim',
'lukas-reineke/indent-blankline.nvim',
-- Statusbar
'nvim-lualine/lualine.nvim',
'kyazdani42/nvim-web-devicons',
-- Diff Viewer
'nvim-lua/plenary.nvim',
'sindrets/diffview.nvim',
-- Git Plugins
'tpope/vim-fugitive',
-- Undo tree
'mbbill/undotree',
-- Multiline
{'mg979/vim-visual-multi',branch= 'master'},
-- Lsp Zero 
---- LSP Support
'neovim/nvim-lspconfig',
'williamboman/mason.nvim',
'williamboman/mason-lspconfig.nvim',
----------Autocompletion
'hrsh7th/nvim-cmp',
'hrsh7th/cmp-buffer',
'hrsh7th/cmp-path',
'saadparwaiz1/cmp_luasnip',
'hrsh7th/cmp-nvim-lsp',
'hrsh7th/cmp-nvim-lua',
----------  Snippets
'L3MON4D3/LuaSnip',
'rafamadriz/friendly-snippets',
'VonHeikemen/lsp-zero.nvim',
-- docstring generator
{'kkoomen/vim-doge',build='npm i --no-save && npm run build:binary:unix'}
})

---- Some Plugins that don´t get their own lua file
-- Key mappings
---- nerdtree
vim.api.nvim_set_keymap('n','<C-B>',':NERDTreeToggle<CR>', { noremap = true, silent = true})

---- fzf file search
vim.api.nvim_set_keymap('n','<C-p>',':GFiles<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n','<leader>b',':Buffers<CR>', { noremap = true, silent = true})

---- fzf with ripgrep (see README)
vim.api.nvim_set_keymap('n','<C-g>',':Rg<CR>',{ noremap = true, silent = true})

---- escape the terminal
vim.api.nvim_set_keymap('t','<Esc>','<C-\\><C-n>', {noremap = true, silent = true})

-- GitSign
require('gitsigns').setup()

-- Indent Blankline
require("indent_blankline").setup {
  char = "|",
  buftype_exclude = {"terminal"}
}

-- nvim-web-devicons Setup
require('nvim-web-devicons').setup()

