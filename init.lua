require('newmi1988')

local fn = vim.fn 
local g = vim.g
local opt = vim.opt
local Plug = vim.fn['plug#']

-- load plugins
vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'catppuccin/nvim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf.vim'
Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
Plug 'editorconfig/editorconfig-vim'
Plug 'p00f/nvim-ts-rainbow'
Plug 'tpope/vim-commentary'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = fn[':TSUpdate']})
Plug 'lewis6991/gitsigns.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
-- Statusbar
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
-- Diff Viewer
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'
-- Git Plugins
Plug 'tpope/vim-fugitive'
-- Undo tree
Plug 'mbbill/undotree'
-- Multiline
Plug('mg979/vim-visual-multi', {['branch'] = 'master'})
-- Lsp Zero 
---- LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

----Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

----  Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'VonHeikemen/lsp-zero.nvim'
vim.call('plug#end')

---- Some Plugins that don´t get their own lua file
-- Key mappings
---- nerdtree
vim.api.nvim_set_keymap('n','<C-B>',':NERDTreeToggle<CR>', { noremap = true, silent = true})

---- fzf file search
vim.api.nvim_set_keymap('n','<C-p>',':GFiles<CR>', { noremap = true, silent = true})

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

